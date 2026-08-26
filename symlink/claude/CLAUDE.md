# Model budget policy: Fable orchestrates, workers execute

The main session runs on Fable, which has tight usage limits. Treat main-loop tokens as the scarce resource: Fable's job is understanding the request, planning, decomposing, dispatching, and reviewing results — not bulk reading or bulk writing.

## Worker rank (cheapest capable model wins)

| Agent | Model | Use for |
|---|---|---|
| `scout` | Haiku | All searching, file reading, "where is / how does X work" questions, summarizing docs or logs |
| `implementer` | Sonnet | Writing the code once the approach is decided: edits, new files, refactors, tests, mechanical migrations |
| `codex` | external CLI | Self-contained, well-specified tasks (boilerplate, one-shot scripts, contained fixes). Separate usage pool but small — use sparingly, never for tasks needing conversation context |
| `codex-reviewer` | external CLI | Cross-vendor review of a finished change set (uncommitted diff, branch, or commit). One review per change set, no retries |
| main loop (Fable) | Fable | Planning, architecture decisions, task decomposition, reviewing worker output, judgment calls, final answers to the user |

## Escalation ladder (route by attempt, not just task type)

Don't jump straight to the strongest worker. For a task of uncertain difficulty, start one rung lower than you'd guess and escalate on failure:

1. `scout` (Haiku) attempts small, mechanical fixes it discovers while investigating — a rename, a one-liner, a config tweak — when spawned with edit permission for that purpose.
2. `implementer` (Sonnet) picks up anything scout couldn't do, or any task that clearly needs real code changes.
3. If `implementer` fails twice on the same task, the main loop (Fable) takes over directly — more round-trips would cost more than doing it.

Escalate on concrete failure signals (tests fail, worker reports being stuck, output is wrong on review) — not on vague dissatisfaction with style.

## Cross-vendor review

After `implementer` (or the main loop) completes a non-trivial change set, dispatch `codex-reviewer` on the diff before presenting results. A second model family catches blind spots same-family review misses. Fable stays the judge: triage codex's findings critically, fix what's real, discard what isn't. Skip this for trivial diffs — the codex pool is small.

## Rules

- Before reading more than 1–2 files yourself, dispatch `scout` instead and work from its report.
- Before writing more than a trivial diff yourself, write a precise spec (files, changes, constraints, acceptance criteria) and dispatch `implementer`.
- Trivial work (a one-line edit, a single known file lookup, conversational answers) stays in the main loop — spawning an agent for it wastes more than it saves.
- Run independent workers in parallel in one message.
- Review worker output critically before reporting to the user; you own correctness, they own labor.
- If a worker fails twice on the same task, do it yourself rather than burning more round-trips.
