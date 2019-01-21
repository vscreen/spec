PYTHON_DIR=python
DART_DIR=dart
GO_DIR=go
SPEC=vscreen.proto

gen: clean python dart go

python:
	mkdir -p ${PYTHON_DIR}
	python -m grpc_tools.protoc -I. --python_out=${PYTHON_DIR} --grpc_python_out=${PYTHON_DIR} ${SPEC}

dart:
	mkdir -p ${DART_DIR}
	protoc -I. ${SPEC} --dart_out=grpc:${DART_DIR}

go:
	mkdir -p ${GO_DIR}
	protoc -I. ${SPEC} --go_out=plugins=grpc:${GO_DIR}

clean:
	rm -rf ${PYTHON_DIR} ${DART_DIR} ${GO_DIR}

setup:
	pip install -r requirements.txt
	pub global activate protoc_plugin
	go get -u google.golang.org/grpc
	go get -u github.com/golang/protobuf/protoc-gen-go