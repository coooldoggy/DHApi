#!/usr/bin/env bash
# ReDoc HTML 생성 후 Chrome으로 PDF 저장 (macOS + Google Chrome 가정)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
YAML="${ROOT}/datahub-gov-api.openapi.yaml"
HTML="${ROOT}/datahub-gov-api.html"
PDF="${ROOT}/datahub-gov-api.pdf"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"

npx --yes @redocly/cli build-docs "$YAML" -o "$HTML"
if [[ -x "$CHROME" ]]; then
  "$CHROME" --headless=new --disable-gpu --no-pdf-header-footer \
    --print-to-pdf="$PDF" "file://${HTML}"
  echo "Wrote $PDF"
else
  echo "Chrome not found at $CHROME — open $HTML in a browser and use Print → Save as PDF."
  exit 1
fi
