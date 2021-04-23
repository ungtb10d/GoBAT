# Copyright (c) 2021 Ericsson Software Technology
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

ORG_PATH="github.com/Nordix"
REPO_PATH="${ORG_PATH}/GoBAT"

if [ ! -h .gopath/src/${REPO_PATH} ]; then
	mkdir -p .gopath/src/${ORG_PATH}
	ln -s ../../../.. .gopath/src/${REPO_PATH} || exit 255
fi

export GOPATH=${PWD}/.gopath
export GOBIN=${PWD}/bin
export CGO_ENABLED=0
export GO15VENDOREXPERIMENT=1
export REV_LIST=`git rev-list --tags --max-count=1`
export REVISION=`git describe --tags $REV_LIST`
export COMMIT_ID=`git rev-parse --short HEAD`

go install -ldflags "-X main.tgentappver=$REVISION-$COMMIT_ID" -tags no_openssl "$@" ${REPO_PATH}/cmd/tgenapp
 
