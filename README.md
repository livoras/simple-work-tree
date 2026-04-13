# simple-work-tree

Minimal `git worktree` wrapper for people who want one command and no ceremony.

## Behavior

- `swt`
  Opens a tiny picker for the current repo's worktrees.
  `Enter` switches into the selected worktree.
  `d` removes the selected worktree.
  If the selected row is the current linked worktree, `swt` switches back to the main worktree and then removes it.
- `swt <name>`
  Switches to an existing worktree if it exists.
  Creates a new branch and worktree if it does not.
- Worktrees live under `~/.swt/<repo>/worktrees/<name>` by default.
- If the repo contains `.copy`, new worktrees get those local files copied in.
- If `.copy` does not exist, `swt` also supports the older `.worktreeinclude` name.

This tool is shell-first. The `swt` executable prints a target path. A small shell wrapper turns that into `cd`.

## Install

```bash
git clone git@github.com:livoras/simple-work-tree.git ~/git/simple-work-tree
cd ~/git/simple-work-tree
./install.sh
exec "$SHELL"
```

Manual install also works:

```bash
ln -sf ~/git/simple-work-tree/bin/swt ~/.local/bin/swt
echo 'source "$HOME/git/simple-work-tree/shell/swt.zsh"' >> ~/.zshrc
```

For bash, source `shell/swt.bash` instead.

## `.copy`

Example:

```text
.env
.env.local
config/dev/*.yaml
app/android/app/src/main/res/**/*.png
```

Each non-empty, non-comment line is treated as a glob relative to the repo root. Matching files are copied into a newly created worktree with `rsync -a`.

## Notes

- The main worktree cannot be deleted from the picker.
- `d` removes the worktree path. It does not delete the branch.
- The base branch is chosen in this order:
  - `origin/HEAD`
  - `main`, `master`, `trunk`, `develop`
  - current branch

## Smoke test

```bash
./scripts/smoke-test.sh
```
