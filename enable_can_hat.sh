#!/bin/bash
# start_can.sh 内で同じディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/can_hat_setup.bash" can0 250000
source "${SCRIPT_DIR}/can_hat_setup.bash" can1 250000
