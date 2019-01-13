PYTHON_DIR=python
DART_DIR=dart
SPEC=vscreen.proto

gen: clean python dart

python:
	mkdir -p ${PYTHON_DIR}
	python -m grpc_tools.protoc -I. --python_out=${PYTHON_DIR} --grpc_python_out=${PYTHON_DIR} ${SPEC}

dart:
	mkdir -p ${DART_DIR}
	protoc -I. ${SPEC} --dart_out=grpc:${DART_DIR}

clean:
	rm -rf ${PYTHON_DIR} ${DART_DIR}

setup:
	pip install -r requirements.txt
	pub global activate protoc_plugin