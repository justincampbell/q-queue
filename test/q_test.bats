load test_helper

@test "q" {
  run $q

  [ $status -eq 0 ]
}
