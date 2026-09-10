#!/usr/bin/env bash
#
# 幻盘 setup.sh — 补齐运行时（Linux / macOS）
#
# 用法：
#   1) 把整个 portable/ 目录拷进 U 盘
#   2) 双击或在终端跑 ./setup.sh
#   3. setup 完提示你跑 ./start.sh，按向导填模型 Key 和通道
#
# 设计：所有 Hermes 状态（配置/记忆/会话/技能）都落在本目录
#   data/.huanri 下（HERMES_HOME 指这里），拔盘不留痕、换盘跟人走。
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
HOME_DIR="$DIR/data/.huanri"
VENV="$DIR/venv"
PY_MIN=310   # Hermes 需要 Python 3.10+

export HERMES_HOME="$HOME_DIR"
mkdir -p "$HOME_DIR"

echo "=================================================="
echo " 幻盘 setup · 常驻 AI 分身 · 便携 U 盘版"
echo "=================================================="
echo " 数据目录: $HOME_DIR  (跟盘走，拔盘不留痕)"
echo

# --- 1. 找 Python 3.10+ ----------------------------------------------
PY=""
for cand in python3.13 python3.12 python3.11 python3.10 python3; do
  if command -v "$cand" >/dev/null 2>&1; then
    ver="$("$cand" -c 'import sys;print(sys.version_info[0]*100+sys.version_info[1])' 2>/dev/null || echo 0)"
    if [ "${ver:-0}" -ge "$PY_MIN" ]; then PY="$cand"; break; fi
  fi
done
if [ -z "$PY" ]; then
  echo "✗ 没找到 Python 3.10+。装一个再来："
  echo "   macOS:   brew install python@3.12"
  echo "   Debian:   sudo apt install python3.11 python3-venv"
  echo "   Windows:  见 docs/快速上手.md"
  exit 1
fi
echo "· Python: $($PY --version 2>&1)"

# --- 2. 建 venv + 装 Hermes ------------------------------------------
if [ ! -x "$VENV/bin/hermes" ]; then
  echo "· 建虚拟环境: $VENV"
  "$PY" -m venv "$VENV"
  # 国内默认走清华源，可用 HERMES_PIP_INDEX 覆盖
  INDEX="${HERMES_PIP_INDEX:-https://pypi.tuna.tsinghua.edu.cn/simple}"
  echo "· 安装 Hermes Agent (源: $INDEX) ..."
  if ! "$VENV/bin/pip" install -q --upgrade pip; then
    echo "  pip 升级失败（多半是没网），继续试主安装..."
  fi
  if ! "$VENV/bin/pip" install -q hermes-agent -i "$INDEX"; then
    echo "· PyPI 没装到，改走 git clone 上游 ..."
    rm -rf "$DIR/.hermes-src"
    git clone --depth 1 https://github.com/NousResearch/hermes-agent "$DIR/.hermes-src"
    "$VENV/bin/pip" install -q -e "$DIR/.hermes-src" -i "$INDEX"
  fi
else
  echo "· 已装过 Hermes，升级中 ..."
  "$VENV/bin/pip" install -q --upgrade hermes-agent -i "${HERMES_PIP_INDEX:-https://pypi.tuna.tsinghua.edu.cn/simple}" || true
fi

# --- 3. 补非 Python 依赖（node / 浏览器等，可选，失败不致命）--------
echo "· 补非 Python 依赖 (hermes postinstall) ..."
"$VENV/bin/hermes" postinstall || echo "  postinstall 跳过（缺 node 时某些工具用不了，核心对话不受影响）"

echo
echo "=================================================="
echo " ✓ setup 完成"
echo "=================================================="
echo " 下一步："
echo "   1) 跑  ./start.sh   进配置向导，填你的模型 Key"
echo "   2) 选一个通道（QQ/Telegram/Discord...）填 token"
echo "   3) 你的分身就上线了，之后双击 start 就能续上"
echo
