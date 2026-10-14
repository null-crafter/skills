# The `{{DIR}}` tree

**The principle: slim `AGENTS.md` files, a big knowledge base.** An `AGENTS.md` rei keeps
under this tree is meant to hold only the rules that must hold on every turn. Everything
else an agent learns or needs — how {{SYSTEMS}} behaves, why
a decision was made, what broke last time and how it was proven — lives in the knowledge
base, with evidence. **Whatever you are looking for, look in the knowledge base first**:
before these files, before the code, before the web, before asking.

This file loads on top of the global instructions for everything under `{{DIR}}`;
each `AGENTS.md`/`CLAUDE.md` below it loads on top of it.

## Knowledge base: search it before any task

`{{DIR}}/knowledge-base/logs/` (`$KB`) is the durable record of what agents verified
here. **No task starts before it has been searched, and your first message about a task
says what you searched and what came back** — a fact and its recheck result, or "nothing
under `<terms>`".

    KB={{DIR}}/knowledge-base/logs
    rg -IN '^## ' $KB/<project>/*-standing-notes/   # this repo's standing notes, one line each
    rg -iN '^## .*<term>' $KB | head -20            # facts by identifier: function, setting, error string
    rg -il '<term>' $KB | head -20                  # files whose body mentions it
    ls -dt $KB/*/*/ | head -5                       # the newest sessions, any project

{{PROJECT_RULE_SHORT}} **A hit is a lead,
not the truth**: run its Evidence recheck against your checkout before acting on it; if it
has changed, write the correction as a fact of your own that names the old file. Never
edit another agent's entry.

**After every task**, and before a long task's context is summarised, write what you
learned to your own directory, `$KB/<project>/<unix-timestamp>-<topic>/<task>.md`, from
`$KB/TEMPLATE.md`: one `##` per fact that names its identifier, with Trap, Evidence pinned
to {{PIN}} plus a recheck that works in a fresh clone, and Apply. List the
directory under `## Knowledge base` in the `CLAUDE.local.md` of the checkout you started
in (or `{{DIR}}/CLAUDE.local.md` outside any checkout) as **one line**,
`<project>/<unix-timestamp>-<topic>: <file> <file>` — names without `.md`, no phrases, no
dates. pi never loads `CLAUDE.local.md`; under
pi, read it at session start. Never a token, key, cookie, env content{{NEVER}}. A task that taught nothing writes nothing. **The full protocol is
`$KB/README.md`** — directories, the `CLAUDE.local.md` block, several agents at once,
corrections, assets, the shape of a topic `AGENTS.md`. Read it before your first save.

## Rules that hold everywhere here

- **When a task ends, propose** any line that belongs in an `AGENTS.md` — never write it
  unprompted. Facts go to the base.
