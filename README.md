# skills

Agent skills shared across machines, one per `skills/<name>/SKILL.md`.

## Install

Claude Code reads skills from `~/.claude/skills/<name>`, so link the ones you want:

```sh
ln -s ~/Projects/src/github/null-crafter/skills/skills/pr-review ~/.claude/skills/pr-review
```

pi installs the whole repo as a package and finds `skills/` on its own:

```sh
pi install git:github.com/null-crafter/skills
```

## Uninstall

```sh
rm ~/.claude/skills/pr-review
pi remove git:github.com/null-crafter/skills
```

## Skills

`./list-skills.sh` prints each skill's name and description.
