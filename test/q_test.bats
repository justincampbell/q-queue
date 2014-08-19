load test_helper

@test "q shows usage" {
  run $q

  [ $status -eq 1 ]
  echo "$output" | grep "q-queue"
}

@test "q foo queues foo for later in ~/.q" {
  run $q foo

  [ $status -eq 0 ]
  grep "^$PWD" $HOME/.q
  grep "foo$" $HOME/.q
}

@test "q shows queued commands" {
  echo "$PWD	foo" > $HOME/.q
  run $q

  [ $status -eq 0 ]
  echo $output | grep "foo"
}
