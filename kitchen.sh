#!/bin/bash -ex

package() {
  if which apt-get; then
    apt-get install $@ -y
  elif which yum; then
    yum install $@ -y
  fi
}

package git-core make time

git clone https://github.com/sstephenson/bats.git /tmp/bats && \
  cd /tmp/bats && \
  ./install.sh /usr

cd /tmp/kitchen/data
make
