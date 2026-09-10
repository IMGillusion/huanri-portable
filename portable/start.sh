#!/usr/bin/env bash
#
# 幻盘 start.sh — 起常驻分身（Linux / macOS）
#
# 用法：
#   ./start.sh          # 前台跑（关窗口=停），首次进配置向导
#   ./start.sh -d       # 后台常驻（nohup），关掉终端也在线
#
# 所有状态落在 data/.huanri（HERMES_HOME），跟盘走。
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
HOME_DIR="$DIR/data/.huanri"
VENV="$DIR/venv"
export HERMES_HOME="$HOME_DIR"

if [ ! -x "$VENV/bin/hermes" ]; then
  echo "还没装运行时，先跑  ./setup.sh"
  exit 1
fi

HERMES="$VENV/bin/hermes"

if [ "${1:-}" = "-d" ]; then
  LOG="$DIR/data/gateway.log"
  echo "· 后台常驻，日志: $LOG"
  nohup "$HERMES" gateway >> "$LOG" 2>&1 &
  echo "  已起 (pid $!)，看日志: tail -f $LOG"
  echo "  停分身:  pkill -f 'HERMES_HOME=$HOME_DIR'"
else
  echo "· 前台起分身（关这个窗口就停），首次会进配置向导"
  exec "$HERMES" gateway
fi
