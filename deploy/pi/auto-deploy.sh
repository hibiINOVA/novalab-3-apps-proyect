#!/bin/bash
# Auto-deploy: si hay commits nuevos en GitHub, actualiza front y/o backend.
# Instalar en /opt/novalab/auto-deploy.sh (ver docs/deploy-raspberry-pi.md §6).
set -euo pipefail
REPO=/opt/novalab/app-repo
RUNTIME=/opt/novalab/backend
WEB=/var/www/novalab
export GIT_SSH_COMMAND="ssh -i /opt/novalab/.ssh/repo_ed25519 -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new"

cd "$REPO"
git fetch -q origin main
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)
if [ "$LOCAL" = "$REMOTE" ]; then
  exit 0
fi
git pull -q --rebase origin main
NEW=$(git rev-parse HEAD)
# core.quotepath=false: las rutas "Backend único/" contienen no-ASCII y sin esto
# git las escapa como "Backend \303\272nico/..." y el grep no las detecta.
CHANGED=$(git -c core.quotepath=false diff --name-only "$LOCAL" "$NEW" || true)
echo "deploy: $LOCAL -> $NEW"
echo "$CHANGED"

NEEDS_BACKEND=0
NEEDS_WEB=0
NEEDS_DEPS=0
echo "$CHANGED" | grep -q "^Backend" && NEEDS_BACKEND=1
echo "$CHANGED" | grep -q "^deploy/web/" && NEEDS_WEB=1
echo "$CHANGED" | grep -q "pyproject.toml" && NEEDS_DEPS=1

if [ "$NEEDS_WEB" = 1 ]; then
  rsync -a --delete "$REPO/deploy/web/" "$WEB/"
  sudo /usr/bin/systemctl reload nginx
  echo "deploy: front actualizado"
fi

if [ "$NEEDS_BACKEND" = 1 ]; then
  rsync -a --delete \
    --exclude ".venv" --exclude "data/" --exclude "__pycache__" \
    --exclude "*.db" --exclude "*.egg-info" \
    "$REPO/Backend único/" "$RUNTIME/"
  if [ "$NEEDS_DEPS" = 1 ]; then
    "$RUNTIME/.venv/bin/pip" install -q -e "$RUNTIME"
    echo "deploy: dependencias actualizadas"
  fi
  cd "$RUNTIME"
  .venv/bin/alembic upgrade head
  sudo /usr/bin/systemctl restart novalab-backend
  echo "deploy: backend reiniciado"
fi
echo "deploy: listo"
