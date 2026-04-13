swt() {
  local target

  target="$(command swt "$@")" || return $?
  if [[ -n "$target" ]]; then
    cd "$target" || return
  fi
}
