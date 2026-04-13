#!/usr/bin/env bash
set -euo pipefail

ROOT="$(
  cd "$(dirname "$0")/.."
  pwd
)"

export PATH="${ROOT}/bin:${PATH}"
export SWT_HOME="$(mktemp -d)/swt-home"

TMP_REPO="$(mktemp -d)/repo"
mkdir -p "$TMP_REPO"
cd "$TMP_REPO"

git init -b main >/dev/null
git config user.email test@example.com
git config user.name test
printf 'base\n' > tracked.txt
git add tracked.txt
git commit -m init >/dev/null

printf 'SECRET=1\n' > .env
mkdir -p config
printf 'local\n' > config/dev.txt
printf '.env\nconfig/*.txt\n' > .copy

first="$(bash "${ROOT}/bin/swt" feat-one 2>/dev/null)"
second="$(bash "${ROOT}/bin/swt" feat-one 2>/dev/null)"

first="$(
  cd "$first"
  pwd -P
)"
second="$(
  cd "$second"
  pwd -P
)"

[[ "$first" == "$second" ]]
[[ -f "$first/.env" ]]
[[ -f "$first/config/dev.txt" ]]

printf 'smoke test passed\n'
