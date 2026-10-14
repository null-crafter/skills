---
task: <what the task was, one line>
project: <the repo you are working in: {{PROJECTS}} | workspace | …>
about: [<the systems the facts below concern: project names as README.md defines them ({{PROJECTS}}, …) plus {{ABOUT}}>]
date: YYYY-MM-DD
---

<!-- before saving: no token, key, cookie, auth header, env contents{{NEVER}}
     — placeholders (acme,
     jane@x.io) instead. Every fact below has Evidence with {{PIN}}
     and a recheck that works in a fresh clone. -->

## <FACT, AS ONE SENTENCE THAT NAMES ITS KEY IDENTIFIER>

**Trap:** <what it looked like instead and what that cost — or "none">

**Evidence:** <{{PIN}}> — <the lines, quoted, or the command and
its output> — recheck: <a command that works in a fresh clone, e.g.
`git grep -n 'the_function' <commit> -- '*.cpp'`; a local path, if any, is a
convenience, not the proof>

**Apply:** <what to do differently next time; where a repo already records this,
if one does>

## <NEXT FACT>

…
