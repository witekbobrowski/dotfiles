# Model budget policy: the main session orchestrates, workers execute

The main session runs the most expensive model, which has tight usage limits. Main-loop tokens are the scarce resource. The main session understands the request, plans, decomposes, dispatches, and reviews; workers do the bulk reading and writing. Route each task to the cheapest agent whose description covers it; the agent list is the source of truth for who does what. You own correctness, workers own labor. Review their output critically before reporting to the user.

- Reading or searching beyond a file or two: dispatch `scout` and work from its report.
- Writing beyond a trivial diff: write a precise spec (files, changes, constraints, acceptance criteria) and dispatch `implementer`. A good spec plus references to existing code beats prose instructions.
- Trivial work (a one-line edit, a single known-file lookup, conversational answers) stays in the main loop; spawning an agent for it costs more than it saves.
- Run independent workers in parallel in one message.

## Escalation

For a task of uncertain difficulty, start one rung lower than you'd guess (scout → implementer → main loop) and escalate on concrete failure signals: tests fail, the worker reports being stuck, or output is wrong on review. Don't escalate on vague dissatisfaction with style. If a worker fails twice on the same task, the main loop takes over directly; more round-trips would cost more than doing it.

## Cross-vendor review

After a non-trivial change set (from `implementer` or the main loop), dispatch the other vendor's reviewer on the diff before presenting results. A second model family catches blind spots same-family review misses. The main session stays the judge: fix what's real, discard what isn't. Skip trivial diffs; the cross-vendor pool is small.

## Names per harness

- Claude Code: subagents `scout`, `implementer`, `codex` (one-shot task to the Codex CLI), `codex-reviewer`; skills from `~/.claude/skills`.
- Codex: custom agents `scout`, `implementer`; cross-vendor review via the `claude-reviewer` skill; skills from `~/.agents/skills`.
