# Prysm: Bazel vs Generic `go build`

This repo shows a comparison between Bazel Prysm builds and Generic Go builds.

# Why generic builds are better

## Speed

I've created dockerfiles with the instructions to build the images. With Go builds I was able to choose Alpine because it is supported by the official **go** docker image, but I couldn't with the bazel. Bazel doesn't have the official docker image and also has no support for Alpine Linux.

#### Benchmarks:

| Hardware                       | Bazel build (Docker Image) | Go build (Docker Image) | Speedup |
| ------------------------------ | -------------------------- | ----------------------- | ------- |
| DO Droplet (2vCPUs and 4GB RAM)| 14 mins 15 secs            | 2 mins 12 secs          | 5.56x                   |

## Ease of use

Generic builds are done by CDing to the **beacon-chain** or **validator** directory and executing `go build` command. After a few seconds, you should be able to see the built executable in the same directory. Just do `./beacon-chain` (or `./validator`), and you got the prysm up and running.

## Portability

Bazel structure considers the bazel server to be always installed on the server, but `go build` just builds the executable and leaves it in the current directory.

It is very uncomfortable to manage binary files as the result of Bazel builds as it puts it to the middle of nowhere.

## Generic builds follow the KISS principle

> KISS - Keep it simple, stupid

The best way to build any software is always the simplest one. There's no need to overengineer the building process.


# Minor Q&A

### Prysm has system dependencies, and bazel is a great way to manage them

Yes, it has some of them. Anyway, all of them can be installed by `sudo apt install build-essential linux-headers-$(uname -r)`. Easy and fairly simple.


# Running the benchmarks

All builds are handled by docker images.

* Bazel
```sh
make bazel # Equals to `docker build -t prysm-bazel . --no-cache`
```

* Go generic build
```sh
make go-generic # Equals to `docker build -t prysm-generic . --no-cache`
```