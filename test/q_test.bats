load test_helper

@test '`q` shows usage' {
  run $q

  [ $status -eq 1 ]
  echo "$output" | grep "q-queue"
}

@test '`q` shows queued commands if commands are queued' {
  echo "$PWD	foo" > $HOME/.q
  run $q

  [ $status -eq 0 ]
  echo $output | grep "foo"
}

@test '`q -l` shows queued commands' {
  echo "$PWD	foo" > $HOME/.q
  run $q -l

  [ $status -eq 0 ]
  echo $output | grep "foo"
}

@test '`q -l` does nothing if no commands are queued' {
  run $q -l

  [ $status -eq 0 ]
  [ -z "$output" ]
}

@test '`q foo` queues foo for later in ~/.q' {
  run $q foo

  [ $status -eq 0 ]
  grep "^$PWD" $HOME/.q
  grep "foo$" $HOME/.q
}

@test '`q foo` works with directories containing spaces' {
  mkdir -p "$BATS_TMPDIR/bar baz" && cd "$BATS_TMPDIR/bar baz"
  run $q foo

  [ $status -eq 0 ]

  mock "foo"

  run $q -r

  verify_mocks
}

@test '`q ls -la .` works with multiple command arguments' {
  run $q ls -la .
  run $q -r

  [ $status -eq 0 ]
}

@test '`q -r` runs all queued commands' {
  echo "$PWD	foo bar" > $HOME/.q

  mock "foo"

  run $q -r

  [ $status -eq 0 ]
  [ ! -f $HOME/.q ]
  echo $output | grep $PWD
  verify_mocks
}

@test '`q -r` shows an error if no commands are queued' {
  run $q -r

  [ $status -eq 1 ]
  echo $output | grep -i "no commands"
}

@test '`q -z` shows an error and does not queue -z' {
  run $q -z

  [ $status -eq 1 ]
  [ ! -f $HOME/.q ]
}

@test '`q -s` shows number of queued commands' {
  echo "$PWD	foo bar" > $HOME/.q

  run $q -s

  [ $status -eq 0 ]
  echo $output | grep "1 command queued"
}

@test '`q -s` pluralizes correctly' {
  echo "$PWD	foo bar" > $HOME/.q
  echo "$PWD	foo bar" >> $HOME/.q

  run $q -s

  [ $status -eq 0 ]
  echo $output | grep "2 commands queued"
}

@test '`q -s` shows nothing if no commands are queued' {
  run $q -s

  [ $status -eq 0 ]
  [ -z "$output" ]
}
