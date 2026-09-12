
lambda { |_stdout,_stderr,status|
  # elm-test decides the status from its own counts, in its
  # Test/Runner/Node.elm: 2 when a test failed, 0 when every test passed and
  # nothing was left incomplete, and 3 when a Test.todo, Test.only or Test.skip
  # made it incomplete. Any other status is a run that never reached a summary
  # at all, which is elm reporting a compile error, or elm-test finding no
  # tests to run.
  return :green if status === 0
  return :red   if status === 2
  return :amber
}
