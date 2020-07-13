.PHONY: go-generic bazel

go-generic:
	docker build -t prysm-generic -f Dockerfile.generic .

bazel:
	docker build -t prysm-bazel -f Dockerfile.bazel .