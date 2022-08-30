#!/bin/bash
set -eux
# Taken from https://github.com/zhxiaogg/cargo-static-build

printenv

ln -s /root/.cargo $HOME/.cargo
ln -s /root/.rustup $HOME/.rustup

cd $GITHUB_WORKSPACE
eval "$*"
chmod 0777 ./target
