#!/usr/bin/env bash
VERSION="1.1.0"

# 使用方法／Usage
usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] <CURRENT_SA_hex> <NEW_SA_hex> [<CAN_INTERFACE>]

Options:
  --help       Show this help message and exit
               ヘルプを表示して終了
  --version    Show script version and exit
               バージョン情報を表示して終了

Arguments:
  CURRENT_SA_hex   Old unit address in hex, e.g. 81 or 0x81
                   変更前ユニットアドレス（16進）、例: 81 または 0x81
  NEW_SA_hex       New unit address in hex, e.g. 90 or 0x90
                   変更後ユニットアドレス（16進）、例: 90 または 0x90
  CAN_INTERFACE    CAN interface name, e.g. can0 (default: can0)
                   CANインタフェース名、例: can0（デフォルト: can0）
EOF
}

# スクリプトが source されているかチェック／Detect if sourced
is_sourced() {
  [[ "${BASH_SOURCE[0]}" != "${0}" ]]
}

# オプション処理／Handle --help and --version
case "$1" in
  --help)
    usage
    if is_sourced; then
      return 0
    else
      exit 0
    fi
    ;;
  --version)
    echo "set_sa.bash version $VERSION"
    if is_sourced; then
      return 0
    else
      exit 0
    fi
    ;;
esac

# 引数チェック／Argument check
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
  usage
  if is_sourced; then
    return 1
  else
    exit 1
  fi
fi

# 引数から「0x」を取り除き、大文字化／Strip leading “0x” if present and uppercase
CUR=${1#0x}; CUR=${CUR^^}
NEW=${2#0x}; NEW=${NEW^^}

# CANインタフェース名の設定／Set CAN interface (default: can0)
IFACE=${3:-can0}

# マスター機器のSA／Master’s SA (例: 0x10)
MASTER_SA="10"

# 29bit CAN ID の生成／Construct 29-bit CAN IDs
UB_ID="18FF59${MASTER_SA}"    # Unit Behavior (PGN 65369)
SAVE_ID="18FF51${MASTER_SA}"  # Save Configuration (PGN 65361)

# Unit Behavior ペイロード設定／Payload for Unit Behavior
UB_PAYLOAD="${CUR}.00.00.10.00.${NEW}"
# Byte0: Destination unit address = CUR
# Byte1: Enable bitmask = 00
# Byte2: Additional enable = 00
# Byte3: Disable bitmask = 10 (disable autobaud detection)
# Byte4: Additional disable = 00
# Byte5: New unit address = NEW

# Save Configuration ペイロード設定／Payload for Save Configuration
SAVE_PAYLOAD="02.${CUR}.00"
# Byte0: Request with reset = 02
# Byte1: Target unit address for save = CUR
# Byte2: Dummy byte = 00

echo ">>> Sending Unit Behavior on ${IFACE} (disable autobaud + set address)"
cansend "${IFACE}" "${UB_ID}#${UB_PAYLOAD}"

sleep 0.1

echo ">>> Persisting on ${IFACE} (Save Configuration + reset)"
cansend "${IFACE}" "${SAVE_ID}#${SAVE_PAYLOAD}"

echo "Done."
