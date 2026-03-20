---
description: Create a pull request with a well-written title and description following repo conventions
allowed-tools: Bash(gh:*), Bash(git:*), Bash(cat:*), Bash(find:*), Bash(grep:*), Read, Glob, Grep
---

# Create Pull Request — Follow Repo Conventions

## Step 1: Check branch state

```bash
BRANCH=$(git branch --show-current)
DEFAULT_BRANCH=$(gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name')
```

Confirm we're not on the default branch. If we are, stop and tell me.

Check if there are uncommitted changes:
```bash
git status --short
```

If there are uncommitted changes, stop and suggest I commit first (or run `/user:commit`).

Make sure the branch is pushed:
```bash
git log origin/$BRANCH..$BRANCH --oneline 2>/dev/null
```

If there are unpushed commits, push first:
```bash
git push -u origin $BRANCH
```

## Step 2: Understand the changes

Get the full picture of what this PR introduces:
```bash
# Commits on this branch not in the default branch
git log $DEFAULT_BRANCH..$BRANCH --oneline
git log $DEFAULT_BRANCH..$BRANCH --format="%s%n%b" | head -100

# Files changed
git diff $DEFAULT_BRANCH...$BRANCH --stat

# The actual diff (for understanding what changed)
git diff $DEFAULT_BRANCH...$BRANCH
```

## Step 3: Detect PR conventions

Check for a PR template:
```bash
# GitHub looks for templates in these locations
cat .github/pull_request_template.md 2>/dev/null || \
cat .github/PULL_REQUEST_TEMPLATE.md 2>/dev/null || \
cat docs/pull_request_template.md 2>/dev/null || \
cat pull_request_template.md 2>/dev/null || \
cat PULL_REQUEST_TEMPLATE.md 2>/dev/null || true

# Also check for multiple templates
ls .github/PULL_REQUEST_TEMPLATE/ 2>/dev/null || true
```

Check the title convention by looking at recent merged PRs:
```bash
gh pr list --state merged --limit 15 --json title,number --jq '.[] | "#\(.number) \(.title)"'
```

Look for patterns:
- **Conventional Commits in titles**: `feat: ...`, `fix(scope): ...`
- **Ticket prefixes**: `[PROJ-123] ...`, `PROJ-123: ...`
- **PR number references**: `(#123)`
- **Casing**: lowercase, Sentence case, Title Case
- **Branch name conventions**: does the branch name contain a ticket number to reference?

Also check contributing guidelines:
```bash
cat CONTRIBUTING.md 2>/dev/null | head -100 || true
```

## Step 4: Write the PR title

The title must:
1. **Match the convention** detected from recent merged PRs
2. **Be specific** about what this PR does -- not vague ("Update code", "Fix bug")
3. **Be concise** -- aim for under 72 characters
4. **Extract ticket/issue references** from the branch name if the convention expects them

If `$ARGUMENTS` is provided, use it as the basis for the title (but reformat to match the repo's convention).

## Step 5: Write the PR description

If a **PR template exists**, fill it in properly:
- Fill every section with real content relevant to this PR
- Remove sections that genuinely don't apply (e.g. "Screenshots" for a backend-only change) rather than writing "N/A" everywhere
- Don't leave template placeholders or instructions in the final output

If **no template exists**, write a description with:
- **What**: a short summary of what the PR does (2-3 sentences)
- **Why**: the motivation -- what problem does it solve, what feature does it add
- **How**: brief notes on the approach if it's not obvious from the diff
- **Anything notable**: breaking changes, migration steps, things reviewers should pay attention to

Keep it proportional to the change. A one-file bugfix doesn't need five paragraphs. A large feature PR deserves a thorough description.

## Step 6: Check for linked issues

Look at the branch name and commit messages for issue/ticket references:
```bash
echo $BRANCH
git log $DEFAULT_BRANCH..$BRANCH --format="%s %b" | grep -oE '#[0-9]+|[A-Z]+-[0-9]+' | sort -u
```

If references are found, include proper closing keywords in the description (`Closes #123`, `Fixes #456`) so GitHub auto-links and auto-closes them.

## Step 7: Create the PR

```bash
gh pr create \
  --base "$DEFAULT_BRANCH" \
  --title "[title]" \
  --body "[description]"
```

If the repo has a PR template and `gh` picks it up automatically, use `--body-file` with a temp file instead to preserve formatting:
```bash
cat > /tmp/pr-body.md << 'EOF'
[description]
EOF
gh pr create \
  --base "$DEFAULT_BRANCH" \
  --title "[title]" \
  --body-file /tmp/pr-body.md
```

After creation, print the PR URL.

Do NOT add reviewers or labels unless I ask. Do NOT auto-merge or mark as ready if it's a draft. If I include "draft" in `$ARGUMENTS`, create it as a draft with `--draft`.
