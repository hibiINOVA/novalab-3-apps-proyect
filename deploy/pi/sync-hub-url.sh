#!/bin/bash
# sync-hub-url.sh — actualiza url.txt del hub GitHub Pages con la URL vigente del tunel.
# Corre tras cada arranque de novalab-tunnel (ExecStartPost) o manualmente.
set -u
TOKEN_FILE="$HOME/.novalab-hub-token"
REPO="hibiINOVA/novalab"

URL=""
for _ in $(seq 1 45); do
  URL=$(journalctl -u novalab-tunnel -n 200 --no-pager -o cat 2>/dev/null \
    | grep -oE 'https://[a-z0-9-]+\.trycloudflare\.com' | tail -1)
  [ -n "$URL" ] && break
  sleep 2
done
if [ -z "$URL" ]; then
  echo "sync-hub: no se encontro URL del tunel en journal" >&2
  exit 0
fi

TOKEN=$(cat "$TOKEN_FILE" 2>/dev/null || true)
if [ -z "$TOKEN" ]; then
  echo "sync-hub: falta $TOKEN_FILE" >&2
  exit 1
fi

API="https://api.github.com/repos/$REPO/contents/url.txt"
META=$(curl -s -m 20 -H "Authorization: Bearer $TOKEN" -H "Accept: application/vnd.github+json" "$API")
CURRENT=$(printf '%s' "$META" | python3 -c "import sys,json,base64;d=json.load(sys.stdin);print(base64.b64decode(d['content']).decode().strip())" 2>/dev/null || true)
SHA=$(printf '%s' "$META" | python3 -c "import sys,json;print(json.load(sys.stdin)['sha'])" 2>/dev/null || true)

if [ "$CURRENT" = "$URL" ]; then
  echo "sync-hub: sin cambios ($URL)"
  exit 0
fi
if [ -z "$SHA" ]; then
  echo "sync-hub: no se pudo leer url.txt actual" >&2
  exit 1
fi

BODY=$(URL="$URL" SHA="$SHA" python3 -c "
import json, base64, os
print(json.dumps({
    'message': 'sync: url del tunel',
    'content': base64.b64encode(os.environ['URL'].encode()).decode(),
    'sha': os.environ['SHA'],
    'branch': 'main',
}))
")
RESP=$(curl -s -m 20 -X PUT "$API" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -d "$BODY")
OK=$(printf '%s' "$RESP" | python3 -c "import sys,json;print('ok' if json.load(sys.stdin).get('commit') else 'err')" 2>/dev/null || echo err)
if [ "$OK" = "ok" ]; then
  echo "sync-hub: url.txt -> $URL"
else
  echo "sync-hub: PUT fallo: $(printf '%s' "$RESP" | head -c 200)" >&2
  exit 1
fi
