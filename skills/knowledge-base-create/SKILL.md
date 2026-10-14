---
name: knowledge-base-create
description: Gives a directory its own knowledge base, shaped like the ~/Projects/src and ~/Projects/ibl.ai ones — knowledge-base/logs/ with the protocol README and TEMPLATE, knowledge-base/assets/, and the "search it before any task" opening in the directory's AGENTS.md.
argument-hint: "<directory>"
disable-model-invocation: true
---

Give the directory named in the arguments (`ARGUMENTS:` in Claude Code, `User:` in pi) its own
knowledge base; with none, ask — never assume the current one. `DIR` below is that directory,
written `~/…` when it is under home.

The protocol ships in `templates/` next to this file (`${CLAUDE_SKILL_DIR}/templates/` in Claude
Code): [README.md](templates/README.md) and [TEMPLATE.md](templates/TEMPLATE.md) become the base's
own, [opening.md](templates/opening.md) goes into its instruction file. They are the live bases'
shared text with each directory-specific part a `{{PLACEHOLDER}}`; everything else stays verbatim.

## 1. Check the target

- `DIR/knowledge-base/` exists → stop: it has a base.
- A parent of `DIR` holds `knowledge-base/logs/README.md` → `DIR` is already a project of that
  base. Say which, and go on only if the user wants a separate base; that README then gets a
  "`DIR` has its own base" paragraph, worded like the `{{BOUNDARIES}}` example below.
- A base below `DIR` goes into `{{BOUNDARIES}}`:
  `find -L DIR -maxdepth 5 \( -name .git -o -name node_modules \) -prune -o -path '*/knowledge-base/logs/README.md' -print`
- `git -C DIR rev-parse --show-toplevel` succeeds → stop and ask: the base and its `AGENTS.md`
  would land in that repo, and never in a clone rei doesn't own.

## 2. Write the base

`mkdir -p DIR/knowledge-base/{logs,assets}`, copy `README.md` and `TEMPLATE.md` into `logs/`, and
fill every placeholder in place. In parentheses, what `~/Projects/src`'s base has there:

- `{{DIR}}` — the directory
- `{{SCOPE}}` — what the base will hold (verified behaviour of the upstream projects cloned here
  and of rei's own repos that no repo's docs hold)
- `{{PROJECT_RULE}}` — how `<project>` follows from a path: every case with two real examples
  from `DIR`, and `workspace` for `DIR` itself. Read the layout first: `ls`, and
  `find DIR -maxdepth 4 -name .git`. (`<owner>-<repo>` from `<host>/<owner>/<repo>`; ibl.ai uses
  the topic directory a checkout sits under)
- `{{SYSTEMS}}` — what an agent here might assume the behaviour of (an upstream project or one of
  rei's repos)
- `{{STALE}}` — why facts here go stale (Upstream moves and rei changes his own repos.)
- `{{MOVES}}` — why a local path won't survive (clones here get pulled, re-cloned and moved)
- `{{PIN}}` — what evidence is pinned to: in words in the README (the upstream `owner/repo` and
  the commit or tag), short elsewhere (an `owner/repo@commit`)
- `{{ABOUT}}` — `workspace` plus the technology names in use here (`workspace`, `zsh` and `git`)
- `{{PROJECTS}}` — a few `<project>` names the rule gives for `DIR`, in `TEMPLATE.md`
- `{{BOUNDARIES}}` — one paragraph per base from step 1 (**ibl.ai has its own base.** Work for
  ibl.ai is recorded in `~/Projects/ibl.ai/knowledge-base/logs/`, never here — even when it reads
  a clone under this tree. `github/iblai` is a symlink into that tree; never write through it.);
  none → delete it
- `{{READERS}}`, `{{NEVER}}` — ask: who may read the base (be synced or shared), and what this
  directory holds that must never land in it beyond tokens, keys, cookies, auth headers and env
  contents, continuing each sentence (, nothing from `~/.pi/agent/auth.json`, and no private
  remote URL) — or nothing
- `{{TOPIC_DIRS}}` — which sub-directories get a topic `AGENTS.md` (a host or owner directory)

## 3. Wire it in

`DIR/CLAUDE.md` a real file → the opening goes there, and the base says `CLAUDE.md` wherever the
templates say `AGENTS.md`. Otherwise it goes into `DIR/AGENTS.md`, created if missing, with
`CLAUDE.md` a relative symlink to it (`ln -s AGENTS.md DIR/CLAUDE.md`). In an existing file the
opening goes first, under that file's own title. Fill it as above; `{{PROJECT_RULE_SHORT}}` is
the rule in one sentence, ending "the full rule is in `$KB/README.md`."

## 4. Verify

- `rg -n '\{\{' DIR/knowledge-base <instruction file>` hits nothing. Run it on `templates/` first:
  it must hit, or it proves nothing.
- `rg -l '^# Knowledge base' DIR/knowledge-base/logs` lists `README.md` — an ignore rule above
  the base would hide every future fact without a word.
- `readlink DIR/CLAUDE.md` → `AGENTS.md`, when this run made the pair.

## 5. Report

What was created or changed, the `<project>` rule with its examples, and any boundary paragraph.
Propose, never write: the line a parent base's instruction file needs, and carving an
instruction file under `DIR` that has grown into a reference into standing notes (the README's
"Standing notes").
