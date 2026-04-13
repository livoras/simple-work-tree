swt() {
  emulate -L zsh
  local target

  target="$(command swt "$@")" || return $?
  [[ -n "$target" ]] && cd "$target"
}
