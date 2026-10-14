# Knowledge base

What agents learn working under `{{DIR}}`: {{SCOPE}}, traps (what looked
like X and was Y, and how that was proven), process mistakes and their fix, and decisions
with the reasoning that settled them. Several agents write to it at once; the rules below
keep it usable.

**The rules live here.** `{{DIR}}/AGENTS.md` carries the mandatory core — search
first, verify, write to your own directory, list it in `CLAUDE.local.md`, never secrets —
and points here for everything else. Read this file before your first save.

    knowledge-base/
      logs/                                        the whole base: sync this directory alone
        README.md                                  this file
        TEMPLATE.md                                the per-task file skeleton agents copy
        <project>/<unix-timestamp>-<topic>/        one directory per agent session (date +%s)
            <task>.md                              one file per task: every fact and trap from it
        <project>/<unix-timestamp>-standing-notes/ notes carved out of an AGENTS.md (see below)
      assets/                                      overflow only (large or unnecessary files);
        <project>/<same directory name>/           may be empty or absent — nothing depends on it

**`<project>` is derived from the path, never from a list.** {{PROJECT_RULE}}

A new repo needs no registration: its first task file creates `logs/<project>/`.

**Read — before any task, and whenever in doubt.** Before assuming how {{SYSTEMS}}
behaves, before reporting that something is absent or unused, before
planning, when a command fails in a way you don't understand, and at the start of every
task. Search by term and cap the output; never dump the base. Your first message about a
task says what you searched and what came back.

    KB={{DIR}}/knowledge-base/logs
    rg -IN '^## ' $KB/<project>/*-standing-notes/   # the repo's standing notes, one line each
    rg -iN '^## .*<term>' $KB | head -20            # facts by identifier: path and sentence
    rg -il '<term>' $KB | head -20                  # files whose body mentions it
    ls -dt $KB/*/*/ | head -5                       # the newest sessions, any project
    ls -t $KB/<project> | head -5                   # this repo's newest sessions…
    rg -IN '^## ' $KB/<project>/<dir>/              # …and the facts one of them recorded

A search that comes back suspiciously empty is re-run with `rg --no-ignore --hidden`; no
`.gitignore` or `.ignore` ever lands in `logs/`, because `rg` would skip what it names
without a word.

**A hit is a lead, not the truth.** {{STALE}} Before
acting on a fact, run its **Evidence** recheck against the checkout you are in (or the
cited commit or newer) and read what comes back. Still true → act on it. Changed → the
correction is a fact of your own: write it in your own task file, naming the old entry's
path and the commit where it changed. Several files for one fact → the newest dated file
is current. Never edit the old entry. A path that no longer exists is not a refutation —
re-verify at the cited commit or newer.

**Write — one agent, one directory; one task, one file.** On your first save, create
`logs/<project>/<unix-timestamp>-<topic>/` (`date +%s`; `<topic>` is your session's
subject) and keep using it for the rest of the session. After each task — and before a
long task's context is summarised — add one file to it. Copy `TEMPLATE.md`: frontmatter
(`task`, `project`, `about` — the systems the facts concern — and `date`), then one `##`
per fact — the fact as a sentence that names its key identifier (the function, setting or
flag), so the heading search finds it — with **Trap**, **Evidence** and **Apply**. A task
that taught nothing writes nothing.

**Evidence must survive the checkout it came from** — {{MOVES}} — so it is never just a local
path: {{PIN}} it was verified against, the lines
quoted or the command with its output, and a recheck that works in a fresh clone
(`git grep` for the symbol at that commit, never a bare line number). A fact without that
is a rumour. Where a repo's `AGENTS.md`/`CLAUDE.md` already records the fact, point at it
with the commit; never copy it. Before writing a fact, check for it: `rg -il` its two or
three most specific identifiers. Found → do not restate it; name that file and write only
what is new or corrected.

**`about:`** takes project names as defined above plus the technology names {{ABOUT}}. A new project name needs no edit; a new technology name is added to this
sentence.

**Never write outside your own directory** — no appends, no edits, no deletes of another
agent's files. There is no shared file to race on. Subagents never write to the base —
their findings return to the agent that spawned them, who does.

{{BOUNDARIES}}

**This is plaintext that may {{READERS}}.** Never a token, key, cookie, auth
header or env file's contents{{NEVER}} —
placeholders (`acme`, `jane@x.io`) instead.

**The `CLAUDE.local.md` block.** On your first save, record your directory in the
`CLAUDE.local.md` of the checkout you started in — or `{{DIR}}/CLAUDE.local.md` when
you started outside any checkout; create the file
if it is missing, keep any other sections it has — under a `## Knowledge base` heading, as
one line: the directory relative to `$KB`, a colon, then each file you write there by name
without `.md`, space-separated, added each time you add a file:

    ## Knowledge base

    <project>/<unix-timestamp>-<topic>: <task> <task>

Nothing else goes on the line — no full path, no date (the directory's timestamp is the
start), no phrase: name each file for its task, so the name says what it holds. A session
that writes under several projects has one line per directory. Claude Code loads that file
with the instructions, so your directory and what you have already recorded are in front
of you every turn. **pi never loads it** — it reads only `AGENTS.override.md`,
`AGENTS.md`, `AGENTS.MD`, `CLAUDE.md` and `CLAUDE.MD` — so under pi, read it at session
start. A task with a name there is recorded — add to that file rather than starting a
second one for it — and if the line and the directory ever disagree, the directory is the
truth; fix the line. `ls -t $KB/<project>` is only the fallback when the block is missing.
A new session in the same checkout starts a new directory and rewrites the block. Never
commit `CLAUDE.local.md`; it is ignored globally, upstream clones included.

**Several agents at once.** If the block has a line that is not yours and its directory
has files minutes old, another agent is live in this checkout: add your line under it, and
each of you keeps its own line.

**Assets are overflow.** Anything binary, a raw dump, or over about 50 KB goes under
`assets/<project>/<same directory name>/`, linked from the entry as
`../../../assets/<project>/<dir>/<file>` with one line saying what it shows and what was
concluded — the entry stands on its own, and a dangling link means the asset was not
synced, never that the entry is wrong. Nothing may depend on `assets/` existing.

**Standing notes.** A `logs/<project>/<unix-timestamp>-standing-notes/` directory holds
notes carved out of an `AGENTS.md` that had grown into a reference: one file per former
section, the same fact shape, the original preserved under `assets/`. Its headings are the
index a topic `AGENTS.md` prints first (`rg -IN '^## ' …/*-standing-notes/`). They are
corrected like any other entry — a newer fact of your own, never an edit — and each time an
`AGENTS.md` is trimmed, the carve-out is a new `<unix-timestamp>-standing-notes` directory
of the agent that did it.

**The shape of a topic `AGENTS.md`.** An `AGENTS.md` rei keeps in {{TOPIC_DIRS}} holds only what must hold on every turn: a header, the standing-notes line, one
line per hard rule. `AGENTS.md` is the real file; `CLAUDE.md` is a relative symlink to it.
Never put one inside a clone rei doesn't own. rei creates the file; an agent proposes its
lines.

    # The `<dir>/` clones

    Loads on top of `{{DIR}}/AGENTS.md` for everything under `<dir>/`. What agents
    verified about it is in the base:

        rg -IN '^## ' {{DIR}}/knowledge-base/logs/<project>/*-standing-notes/

    ## Rules that hold in every <dir> clone

    - <one line per rule that must hold on every turn; everything else goes to the base>
