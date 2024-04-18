# Warmup Lab

This lab provides a refresher on Risc-V assembly and an introduction to ROP inside a familiar Risc-V environment.

## Getting Started

`./run.sh` launches the simulator using whatever level is set in `config.sh`

`./run.sh levelX` launches qemu on level X (where X is 1-4)

`./run.sh levelX --debug` launches the simulator waiting for GDB on the port specified in `config.sh`

`./gdb.sh` connects to the running qemu simulator instance when running in debug mode, using the binary specified by `config.sh`.

`./gdb.sh levelX` launches GDB using the binary at level X.

## Dependencies

You'll need Docker and Qemu for this to work.
Optionally, you can run this with a native cross compiler (eg. `riscv64-unknown-elf binutils`) avoiding the need for Docker.

On Linux: ```sudo apt-get install -y docker qemu```

On macOS:
1) get Docker Desktop from the Docker website.
2) (assuming you have Homebrew): ```brew install qemu```

On Windows: ```TODO```

You will also need the pwn library for solving the level 3 and 4 puzzle:
```python3 -m pip install pwntools```

## Compilation

The provided container allows you to build the Risc-V binaries and debug them from GDB.

To build the container, run: ```docker-compose run warmup```

Then, to build the lab materials, simply run: ```make```

Now, from a **different** window, you can launch the lab with the following:
```./run.sh```

## Debugging

To use GDB, you can add `--debug` to the `run.sh` invocation.
Then, you can attach to the qemu instance from within Docker using `gdb.sh`.

If you're on Linux, (running qemu under Docker or natively), make sure `config.sh` sets `DEBUG_HOST` to the following:
```DEBUG_HOST=localhost```

On macOS and Windows (AKA Docker Desktop environments) when attaching to qemu from within the container, `config.sh` should say:
```DEBUG_HOST=host.docker.internal```

If you are running a native gdb instance (eg. not under Docker) on macOS / Windows, set `DEBUG_HOST` to `localhost` just like on Linux.

## Configuring

`config.sh` contains various runtime configuration parameters.

`DEBUG_HOST` is the host that `gdb` will attempt to connect to.
(If running in a Docker Desktop container, set this to `host.docker.internal`, otherwise `localhost` or wherever `run.sh` is being run).

`TARGET_LEVEL` specifies the default binary to run- set it to `levelX`.
This setting is overriden if `run.sh` is passed a given level (eg. with `./run.sh level1`).

`DEBUG_PORT` is the port that qemu will launch its gdbserver on.

