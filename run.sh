#!/usr/bin/env bash
# ZeroWasteKit 本地启动（macOS / Linux）
set -e
cd "$(dirname "$0")"

if ! command -v node >/dev/null 2>&1; then
  echo ""
  echo "[提示] 未检测到 Node.js，将直接用浏览器打开 index.html"
  echo "       建议安装 Node.js 后重跑，可获得完整的三餐抽签与数据同步功能。"
  echo ""
  (open index.html 2>/dev/null || xdg-open index.html 2>/dev/null || true)
  exit 0
fi

PORT="${PORT:-8080}"
echo ""
echo "  正在启动本地服务：http://localhost:${PORT}"
echo "  关闭这个终端即停止服务。"
echo ""

( sleep 1; (open "http://localhost:${PORT}" 2>/dev/null || xdg-open "http://localhost:${PORT}" 2>/dev/null || true) ) &
PORT="$PORT" node server.js
