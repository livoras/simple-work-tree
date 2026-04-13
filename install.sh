#!/usr/bin/env bash
set -euo pipefail

ROOT="$(
  cd "$(dirname "$0")"
  pwd
)"

BIN_DIR="${HOME}/.local/bin"
TARGET_BIN="${BIN_DIR}/swt"
SHELL_NAME="$(basename "${SHELL:-}")"

mkdir -p "$BIN_DIR"
ln -sf "${ROOT}/bin/swt" "$TARGET_BIN"
chmod +x "${ROOT}/bin/swt"

case "$SHELL_NAME" in
  zsh)
    RC_FILE="${HOME}/.zshrc"
    WRAPPER="${ROOT}/shell/swt.zsh"
    ;;
  bash)
    RC_FILE="${HOME}/.bashrc"
    WRAPPER="${ROOT}/shell/swt.bash"
    ;;
  *)
    RC_FILE=""
    WRAPPER=""
    ;;
esac

if [[ -n "${RC_FILE}" ]]; then
  mkdir -p "$(dirname "$RC_FILE")"
  touch "$RC_FILE"
  LINE="source \"${WRAPPER}\""
  if ! grep -Fqx "$LINE" "$RC_FILE"; then
    printf '\n%s\n' "$LINE" >> "$RC_FILE"
  fi
  printf 'Installed swt to %s and updated %s\n' "$TARGET_BIN" "$RC_FILE"
else
  printf 'Installed swt to %s\n' "$TARGET_BIN"
  printf 'Source one of these wrappers manually:\n' >&2
  printf '  %s\n' "${ROOT}/shell/swt.zsh" >&2
  printf '  %s\n' "${ROOT}/shell/swt.bash" >&2
fi
