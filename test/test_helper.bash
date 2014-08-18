setup() {
  QQ_TMPDIR=$BATS_TMPDIR/q-queue
  HOME=$QQ_TMPDIR
  PATH=$QQ_STUBS:$PATH

  rm -rf $QQ_TMPDIR
  mkdir -p $QQ_TMPDIR

  q=bin/q
}

teardown() {
  echo $status: $output
}
