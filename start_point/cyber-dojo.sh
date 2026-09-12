set -e

# --------------------------------------------------------------
function cyber_dojo_exit()
{
  # Text files in this directory are returned to the browser, so the working
  # files the compiler leaves behind are removed before the run ends.
  rm -rf "${CYBER_DOJO_SANDBOX}/elm-stuff"
}
trap cyber_dojo_exit EXIT SIGTERM
# --------------------------------------------------------------

# Elm compiles the packages named in elm.json before it compiles any of your
# code, and keeps the result in elm-stuff, beside your files. That takes about
# ten seconds, which is a long time to wait to be told about a typo, so the
# packages come already compiled in the image and the run starts from a copy.
#
# Only the packages are reused. Every module you write is compiled again on
# every test run, so what you are shown is always built from your files as they
# are now.
#
# The copy is taken only when your elm.json is character for character the one
# those packages were compiled from. Change it, to add a package or to drop
# one, and the copy is skipped and elm compiles what you actually asked for.
# That test run is the slow one; the ones after it are not.
if cmp -s elm.json /etc/elm/cache/elm.json; then
  # -p, because elm decides whether it has to compile the packages again by
  # looking at elm.json's modification time. Copies that lose the timestamps
  # are a cache nothing ever reads.
  cp -R -p /etc/elm/cache/elm-stuff "${CYBER_DOJO_SANDBOX}/elm-stuff"
  touch -r /etc/elm/cache/elm.json elm.json
fi

# Both tools draw their progress by overwriting a line with a carriage return.
# That reads as one line in a terminal and as a pile of half-written ones
# anywhere else, so only the last piece of each line is kept, which is what a
# terminal would have left showing.
readonly CARRIAGE_RETURN="$(printf '\r')"
function last_written_line()
{
  sed "s/.*${CARRIAGE_RETURN}//"
}

# elm finishes its progress and starts its error report with nothing in
# between, so the first line of a failed compile reads
# "Compiling ...-- WEIRD NUMBER ---". Dropping that much, and only from the
# line elm put it on, leaves the report beginning where it should. Worded
# differently one day the prefix simply stays, which is untidy rather than
# wrong.
function without_progress_prefix()
{
  sed '1s/^Compiling [^-]*//'
}

# Elm compiles only the modules something imports. A module you have added but
# not imported yet would never be looked at, so a mistake in it would go
# unreported and your tests would pass around it. Type-checking every module
# reports it instead. --output=/dev/null asks for the check without the
# JavaScript, and nothing is printed unless the check fails.
#
# The directories to look in come from elm.json rather than being assumed to be
# src/, so renaming that entry, or adding a second one, goes on working. When
# elm.json cannot be read at all the type-check is skipped and the run carries
# on to elm-test, which says what is wrong with elm.json far more clearly than
# the reader of it would.
source_dirs="$(node --print \
  'JSON.parse(require("fs").readFileSync("elm.json"))["source-directories"].join("\n")' \
  2>/dev/null)" || source_dirs=''
if [ -n "${source_dirs}" ]; then
  source_files="$(find ${source_dirs} -type f -name '*.elm')"
  if [ -n "${source_files}" ]; then
    type_check_status=0
    type_check_output="$(elm make --output=/dev/null ${source_files} 2>&1)" \
      || type_check_status=$?
    if [ "${type_check_status}" != '0' ]; then
      printf '%s\n' "${type_check_output}" | last_written_line | without_progress_prefix
      exit "${type_check_status}"
    fi
  fi
fi

# elm-test finds your tests itself, in tests/ and at any depth below it, so a
# new test module needs no wiring in anywhere. What it does need is to expose
# the tests it defines, the way tests/HikerTest.elm exposes suite: a test that
# is not exposed cannot be found, and so cannot be run.
#
# Renaming a file means renaming the module inside it. Elm works out a module's
# name from where its file is: tests/HikerTest.elm has to say HikerTest, and
# tests/Unit/DeepTest.elm has to say Unit.DeepTest. Every part of the path is
# part of the name, which is why a directory under tests/ needs a capital
# letter of its own. Elm says so itself if you get it wrong.
#
# They all run in one go, in a single process, so the counts printed at the end
# cover every test module you have.
#
# One worker, rather than one per processor. Code that stops the tests dead,
# such as a Debug.todo you have not filled in yet, is reported by each worker
# separately, so ten of them turn a two-line answer into two hundred lines of
# the runner's own innards. One worker says it once, and says it in terms of
# your module and the line in it.
elm-test --workers 1 2>&1 | last_written_line
exit "${PIPESTATUS[0]}"
