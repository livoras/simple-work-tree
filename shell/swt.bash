swt() {
  local target
  local switch_path
  local remove_path

  target="$(command swt "$@")" || return $?
  if [[ "$target" == "__SWT_SWITCH_REMOVE__"$'\n'* ]]; then
    switch_path="${target#*$'\n'}"
    switch_path="${switch_path%%$'\n'*}"
    remove_path="${target##*$'\n'}"

    cd "$switch_path" || return
    git -C "$switch_path" worktree remove "$remove_path"
    return $?
  fi
  if [[ -n "$target" ]]; then
    cd "$target" || return
  fi
}
