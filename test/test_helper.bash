setup() {
  BATS_TMPDIR=$BATS_TMPDIR/q-queue
  BATS_STUBS=$BATS_TMPDIR/stubs
  BATS_MOCKS_RECEIVED=$BATS_STUBS/mocks-received
  BATS_MOCKS_SETUP=$BATS_STUBS/mocks-setup
  HOME=$BATS_TMPDIR
  PATH=$BATS_STUBS:$PATH

  rm -rf $BATS_TMPDIR
  mkdir -p $BATS_TMPDIR
  mkdir -p $BATS_STUBS

  q=$PWD/bin/q
}

teardown() {
  echo $status: $output
}

stub() {
  stub=$BATS_STUBS/$1
  echo "#!/bin/bash" > $stub
  echo $2 >> $stub
  chmod +x $stub
}

mock() {
  touch $BATS_MOCKS_RECEIVED
  echo $1 >> $BATS_MOCKS_SETUP
  stub $1 "echo $1 >> $BATS_MOCKS_RECEIVED"
}

verify_mocks() {
  cat $BATS_MOCKS_SETUP | while read mock; do
    if ! grep $mock $BATS_MOCKS_RECEIVED; then
      echo "$mock not called" && return 1
    fi
  done
}

verify_called() {
  grep $1 $BATS_MOCKS
}

verify_not_called() {
  grep -v $1 $BATS_MOCKS
}
