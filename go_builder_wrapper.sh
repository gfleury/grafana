#!/bin/bash
set -e
./install_basics.sh
sudo mkdir -p /go
sudo chown -R ubuntu:ubuntu /go
export GOPATH=/go
mkdir -p /go/src/github.com/grafana/
ln -s /home/application/current /go/src/github.com/grafana/grafana
pushd /go/src/github.com/grafana/grafana
go get -u github.com/golang/dep/cmd/dep 
$GOPATH/bin/dep ensure
make deps-go 
make all 
mkdir -p ./bin
cp /go/src/github.com/grafana/grafana/bin/linux-amd64/grafana-server /go/src/github.com/grafana/grafana/bin/linux-amd64/grafana-cli ./bin/
cp ./packaging/docker/run.sh run.sh
chmod +x run.sh
popd
