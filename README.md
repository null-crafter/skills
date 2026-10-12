# skills

Agent skills shared across machines, one per `skills/<name>/SKILL.md`.

## Install

Claude Code reads skills from `~/.claude/skills/<name>`, so link the ones you want:

```sh
ln -s ~/Projects/src/github/mecha-null-crafter/skills/skills/pr-review ~/.claude/skills/pr-review
```

pi installs the whole repo as a package and finds `skills/` on its own:

```sh
pi install git:github.com/mecha-null-crafter/skills
```

## Uninstall

```sh
rm ~/.claude/skills/pr-review
pi remove git:github.com/mecha-null-crafter/skills
```

## Skills

- `pr-review` — `/pr-review` reviews the current branch against `main` for bugs, security
  issues, missing tests and convention violations in a forked context, and ends with a
  verdict.
