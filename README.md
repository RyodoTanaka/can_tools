# can\_tools

## Installation
```
mkdir <workspace>
cd <workspace>
git clone --recursive https://github.com/RyodoTanaka/can_tools.git
cd <worksapce>/can_tools/can-utils
mkdir build
cd build
cmake ..
make -j`nproc` && sudo make install
cd <worksapace>/can_tools
```

## Execution
### PCAN setup & run
```
cd <workspace>/can_tools
# interface: can0
# bitrate: 250000
./peakcan_setup.bash can0 250000
```
