swt() {
  emulate -L zsh
  local target
  local rest
  local switch_path
  local remove_path

  target="$(command swt "$@")" || return $?
  if [[ "$target" == "__SWT_SWITCH_REMOVE__"$'\n'* ]]; then
    rest="${target#*$'\n'}"
    switch_path="${rest%%$'\n'*}"
    remove_path="${rest#*$'\n'}"

    cd "$switch_path" || return
    git -C "$switch_path" worktree remove "$remove_path"
    return $?
  fi
  [[ -n "$target" ]] && cd "$target"
}
