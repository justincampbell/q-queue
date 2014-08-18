load test_helper

@test "q shows usage" {
  run $q

  [ $status -eq 0 ]
  echo "$output" | grep "q-queue"
}
