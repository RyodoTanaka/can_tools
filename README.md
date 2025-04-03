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

# Copy files to /opt directory
cd <workspace>
sudo cp -rf can_tools /opt
```

# Make systemctl service
**CAUTION** The following code is only for **Raspberry Pi with CAN hat**.
```bash
cd <workspace>/can_tools
sudo systemctl enable ./can_hat_setup.service
sudo systemctl start can_hat_setup.service
# Then you can check whether the script works fine or not
sudo systemctl status can_hat_setup.service
```

## Execution
### PCAN setup & run
```
cd <workspace>/can_tools
# interface: can0
# bitrate: 250000
./peakcan_setup.bash can0 250000
```
