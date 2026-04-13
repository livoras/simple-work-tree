swt() {
  local target
  local first_line
  local remainder
  local switch_path
  local remove_path

  target="$(command swt "$@")" || return $?
  first_line="${target%%$'\n'*}"
  if [[ "$first_line" == "__SWT_SWITCH_REMOVE__" ]]; then
    remainder="${target#*$'\n'}"
    switch_path="${remainder%%$'\n'*}"
    remove_path="${remainder#*$'\n'}"
    [[ -n "$switch_path" && -n "$remove_path" ]] || return 1

    cd "$switch_path" || return
    git -C "$switch_path" worktree remove "$remove_path"
    return $?
  fi
  if [[ -n "$target" ]]; then
    cd "$target" || return
  fi
}
