---
description: Stage and commit changes following the repo's commit message conventions
allowed-tools: Bash(gh:*), Bash(git:*), Bash(cat:*), Bash(grep:*), Read, Glob, Grep
---

# Commit — Follow Repo Conventions

## Step 1: Understand what changed

```bash
git diff --staged --stat
git diff --stat
```

If nothing is staged, stage all changes:
```bash
git add -A
```

Show me a brief summary of what's being committed:
```bash
git diff --staged --stat
```

## Step 2: Detect the repo's commit style

```bash
git log --format="%s" -20
```

Also check for enforced conventions:
```bash
cat .commitlintrc* .commitlintrc.js .commitlintrc.json 2>/dev/null || true
cat package.json 2>/dev/null | grep -A5 "commitlint" || true
cat CONTRIBUTING.md 2>/dev/null | head -80 || true
cat .gitmessage 2>/dev/null || true
```

Identify the pattern:
- **Conventional Commits**: `feat:`, `fix:`, `chore:`, `refactor:`, `docs:`, `test:`, `ci:`
- **Scoped**: `fix(auth):`, `feat(api):`
- **Ticket prefixes**: `[JIRA-123]`, `(#456)`, `GH-789:`
- **Plain English**: just a description, no prefix
- **Casing**: lowercase, Sentence case, Title Case
- **Body**: always use one when the change warrants explanation, regardless of repo history
- **Trailers**: `Signed-off-by:`, `Co-authored-by:`, etc.

## Step 3: Write the commit message

Write a commit message that:
1. **Matches the detected style exactly** -- don't invent a new convention
2. **Describes what changed and why**, not just which files were touched
3. **Is concise** -- if a one-liner is the repo norm, keep the subject line short
4. **Includes a body** when the change isn't completely obvious from the subject line alone. A sentence or two explaining the why is almost always worth it. Don't pad it -- if the subject says everything, skip the body.

If `$ARGUMENTS` is provided, use it as the commit message (but still format it to match the repo's style -- add the correct prefix, fix casing, etc.).

## Step 4: Commit

```bash
git commit -m "[subject line]" -m "[body]"
```

Skip the body only if the change is truly trivial (typo fix, version bump, etc.) or if the repo's contributing guidelines explicitly prohibit commit bodies.

Do NOT push unless I ask.
