swt() {
  emulate -L zsh
  local target
  local -a lines
  local switch_path
  local remove_path

  target="$(command swt "$@")" || return $?
  lines=("${(@f)target}")
  if [[ "${lines[1]:-}" == "__SWT_SWITCH_REMOVE__" ]]; then
    switch_path="${lines[2]:-}"
    remove_path="${lines[3]:-}"
    [[ -n "$switch_path" && -n "$remove_path" ]] || return 1

    cd "$switch_path" || return
    git -C "$switch_path" worktree remove "$remove_path"
    return $?
  fi
  [[ -n "$target" ]] && cd "$target"
}
