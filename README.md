
# Binary Exploitation and RISC-V Warmup

This recitation provides a refresher on RISC-V assembly and an introduction to ROP inside a familiar RISC-V environment.



## Getting Started

`./run.sh` launches the simulator using whatever level is set in `config.sh`

`./run.sh levelX` launches qemu on level X (where X is 1-5)

`./run.sh levelX --debug` launches the simulator waiting for GDB on the port specified in `config.sh`

`./gdb.sh` connects to the running qemu simulator instance when running in debug mode, using the binary specified by `config.sh`.

`./gdb.sh levelX` launches GDB using the binary at level X.


## Run on the Lab Machine

This Recitation could be run on our lab machine `unicorn.csail.mit.edu`:
You can log in with the same user account as previous labs.

Then, compile the code with `make`, and run the code with `./run.sh levelX`.


## Run Locally

Alternatively, you could also run the recitation on your own machine with following setups.

### Dependencies

You'll need Docker and Qemu for this to work.
Optionally, you can run this with a native cross compiler (eg. `riscv64-unknown-elf binutils`) avoiding the need for Docker.

On Linux: ```sudo apt-get install -y docker qemu```

On macOS:
1) get Docker Desktop from the Docker website.
2) (assuming you have Homebrew): ```brew install qemu```

On Windows: ```TODO```

You will also need the pwn library for solving the level 3, 4 and 5 puzzle:
```python3 -m pip install pwntools```


### Compilation

The provided container allows you to build the Risc-V binaries and debug them from GDB.

To build the container, run: ```docker-compose run warmup```

Then, to build the lab materials, simply run: ```make```

Now, from a **different** window, you can launch the lab with the following:
```./run.sh```


## Debugging

To use GDB, you can add `--debug` to the `run.sh` invocation.
Then, you can attach to the qemu instance from within Docker using `gdb.sh`.

You need to first set `DEBUG_PORT` in `config.sh`.
If you are using `unicorn`, please set this to the debug port we emailed you for lab6.A. Otherwise, you can just use 5050.

Then, if you are not using `unicorn`, you need to set `DEBUG_HOST`:

- If you're on Linux (including our lab machine), running qemu under Docker or natively, make sure `config.sh` sets `DEBUG_HOST` to the following:
```DEBUG_HOST=localhost```

- On macOS and Windows (AKA Docker Desktop environments) when attaching to qemu from within the container, `config.sh` should say:
```DEBUG_HOST=host.docker.internal```

- If you are running a native gdb instance (eg. not under Docker) on macOS / Windows, set `DEBUG_HOST` to `localhost` just like on Linux.


## Configuring

`config.sh` contains various runtime configuration parameters.

`DEBUG_HOST` is the host that `gdb` will attempt to connect to.
(If running in a Docker Desktop container, set this to `host.docker.internal`, otherwise `localhost` or wherever `run.sh` is being run).

`TARGET_LEVEL` specifies the default binary to run- set it to `levelX`.
This setting is overriden if `run.sh` is passed a given level (eg. with `./run.sh level1`).

`DEBUG_PORT` is the port that qemu will launch its gdbserver on.

