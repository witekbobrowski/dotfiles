---
description: Read PR review comments, critically analyze them, implement only good suggestions, and reply to each comment with the decision
allowed-tools: Bash(gh), Bash(git:*), Bash(cat:*), Bash(find:*), Bash(grep:*), Read, Write, Glob, Grep
---

# Review PR Comments — Critical Analysis, Selective Implementation & Reply

You are a senior developer reviewing Pull Request feedback. Your job is to read all review comments on the current PR, **critically evaluate each one**, implement **only the suggestions that genuinely improve the code**, and **reply to every comment** on GitHub explaining your decision.

## Step 1: Identify the PR

```bash
BRANCH=$(git branch --show-current)
PR_NUMBER=$(gh pr view "$BRANCH" --json number --jq '.number' 2>/dev/null)
```

If `$ARGUMENTS` is provided, use that as the PR number instead.
If no PR is found, stop and tell me.

## Step 2: Gather all review feedback and check resolution status

### Check for already addressed comments

First, get the commit history since PR was opened to see what was already fixed:
```bash
# Get PR base branch and commits since divergence
BASE_BRANCH=$(gh pr view $PR_NUMBER --json baseRefName --jq '.baseRefName')
COMMITS_SINCE_PR=$(git log --oneline $BASE_BRANCH..HEAD)

# Get last summary comment (if exists) to see what was previously addressed
LAST_SUMMARY=$(gh pr view $PR_NUMBER --json comments --jq '.comments[] | select(.body | contains("## Review feedback addressed")) | .body' | tail -1)
```

### Fetch all review feedback

Fetch **three sources** of comments (the gh CLI doesn't merge them):

1. **Top-level PR comments** (general discussion):
   ```bash
   gh pr view $PR_NUMBER --json comments --jq '.comments[] | {author: .author.login, body: .body, createdAt: .createdAt}'
   ```

2. **Review bodies** (summary text from submitted reviews):
   ```bash
   gh pr view $PR_NUMBER --json reviews --jq '.reviews[] | {author: .author.login, state: .state, body: .body, submittedAt: .submittedAt}'
   ```

3. **Inline review comments** (attached to specific lines — the important ones):
   ```bash
   # Get all comments with their resolution status
   gh api repos/{owner}/{repo}/pulls/$PR_NUMBER/comments --paginate --jq '.[] | {id: .id, author: .user.login, path: .path, line: .line, original_line: .original_line, diff_hunk: .diff_hunk, body: .body, in_reply_to_id: .in_reply_to_id, created_at: .created_at, reactions: .reactions}'
   ```

4. **Check for existing replies to identify resolved comments**:
   ```bash
   # Get all comment threads to see which have replies
   gh api repos/{owner}/{repo}/pulls/$PR_NUMBER/comments --paginate --jq '.[] | select(.in_reply_to_id != null) | {reply_to: .in_reply_to_id, author: .user.login, body: .body}'
   ```

Also fetch the PR diff for full context:
```bash
gh pr diff $PR_NUMBER
```

### Identify already resolved comments

Mark comments as ALREADY RESOLVED if:
- The comment has a reply from the PR author (you) saying "Fixed", "Done", or similar
- The comment appears in a previous "Review feedback addressed" summary
- The comment's suggestion was implemented in a commit (check commit messages)
- The comment is from a bot and was addressed in a previous round

## Step 3: Critical analysis of each comment

For **every** review comment or suggestion, evaluate it against these criteria:

### Skip if ALREADY RESOLVED:
- Comment has a reply from PR author confirming it was fixed
- Comment was addressed in a previous commit (check commit messages)
- Comment appears in a previous "Review feedback addressed" summary
- Comment is outdated (the code it refers to has changed since)

### Accept if the suggestion:
- Fixes a real bug, crash, race condition, or data loss risk
- Improves type safety or nullability handling in a meaningful way
- Addresses a genuine performance concern with measurable impact
- Improves naming/readability in a way that actually clarifies intent
- Catches a missing edge case or error handling gap
- Aligns with established project conventions (check existing code first!)
- Suggests better API usage backed by current official documentation for the relevant framework/platform
- Points out a real security concern

### Reject (with reason) if the suggestion:
- Is generic boilerplate that ignores the specific context (common with Copilot reviews)
- Suggests "best practices" that don't apply to the actual architecture
- Proposes unnecessary abstraction/refactoring that adds complexity without clear benefit
- Recommends deprecated or outdated patterns for the repo's stack (check the language version and framework docs — suggestions based on old idioms should be rejected)
- Is cosmetic bikeshedding with no meaningful impact
- Conflicts with existing codebase conventions
- Suggests changes that would break other functionality
- Is a rubber-stamp comment with no substance (e.g. "looks good", "nice", "consider refactoring")
- Proposes overly defensive programming that clutters the code (unnecessary nil checks where the type system already guarantees safety, etc.)
- Misunderstands the surrounding code or business logic

### Flag for discussion if:
- The suggestion has merit but the tradeoffs are unclear
- It touches architectural decisions that need broader team input
- It's a valid concern but the proposed fix isn't right

## Step 4: Present analysis before acting

Before making ANY changes or posting ANY replies, present a clear summary:

```
## PR #[number] — Review Comment Analysis

### ALREADY RESOLVED ([count])
For each:
- **[File:Line]** — [Author]: "[Brief quote of suggestion]"
  -> Status: [How it was resolved - e.g., "Fixed in commit 2d31bc2", "Replied and fixed"]

### ACCEPT ([count])
For each:
- **[File:Line]** — [Author]: "[Brief quote of suggestion]"
  -> Why: [1-sentence justification]

### REJECT ([count])
For each:
- **[File:Line]** — [Author]: "[Brief quote of suggestion]"
  -> Why: [1-sentence reason for rejection]

### DISCUSS ([count])
For each:
- **[File:Line]** — [Author]: "[Brief quote of suggestion]"
  -> Concern: [What needs clarification]
```

**Wait for my confirmation before proceeding.**

## Step 5: Implement approved changes

After I confirm (or adjust the accept/reject list):

1. Read each file that needs changes
2. Apply the accepted suggestions, one file at a time
3. After each file, verify the change doesn't break surrounding code
4. Try to run whatever build/lint/typecheck the repo uses. Detect it:
   ```bash
   # Check what's available — run the first one that applies
   # package.json -> npm run build / npm run lint / npx tsc --noEmit
   # Cargo.toml -> cargo check
   # Package.swift -> swift build
   # Makefile -> make check / make lint
   # pyproject.toml / setup.py -> ruff check / mypy / python -m py_compile
   # go.mod -> go vet ./...
   # Gemfile -> bundle exec rubocop
   # Or check scripts in CI config (.github/workflows/) for the repo's preferred commands
   ```
   Run whatever is appropriate. Don't guess -- look at the repo first.

## Step 5.5: Detect and follow the repo's commit style

Before committing, **study the existing commit history** to match the repo's conventions:

```bash
# Look at recent commit messages for style/format
git log --oneline -20
# Check for conventional commits, squash style, ticket prefixes, etc.
git log --format="%s" -20
```

Look for patterns:
- **Conventional Commits**: `feat:`, `fix:`, `chore:`, `refactor:` prefixes
- **Ticket/issue prefixes**: `[JIRA-123]`, `(#456)`, `GH-789:`
- **Scope patterns**: `fix(auth):`, `feat(api):`
- **Casing**: lowercase vs sentence case vs Title Case
- **Body style**: bullet points vs prose vs no body at all
- **Co-author / sign-off lines**: `Signed-off-by:`, `Co-authored-by:`

Also check for repo-level config:
```bash
# Commitlint, husky, or similar enforced conventions
cat .commitlintrc* .commitlintrc.js .commitlintrc.json 2>/dev/null || true
cat package.json 2>/dev/null | grep -A5 "commitlint" || true
cat CONTRIBUTING.md 2>/dev/null | head -80 || true
```

**Write the commit message in whatever style the repo actually uses.** If the repo uses conventional commits, use that. If they use ticket prefixes, include the PR number or linked issue. If they just write plain English one-liners, do that. Don't impose a style the repo doesn't follow.

Stage and commit:
```bash
git add -A
git commit -m "[message matching repo conventions]"
```

Push the changes:
```bash
git push
```

## Step 6: Reply to unresolved comments on GitHub

After implementing and pushing, reply to **each unresolved** review comment thread on GitHub. Skip comments that were marked as ALREADY RESOLVED in the analysis. Use the inline comment reply API so replies appear directly in the conversation thread.

### How to reply

For **inline review comments** (have a numeric `id`), reply directly to the thread:
```bash
gh api repos/{owner}/{repo}/pulls/$PR_NUMBER/comments/{comment_id}/replies \
  -f body="Your reply here"
```

Important:
- Only reply to **top-level** comments in a thread (`in_reply_to_id` is null)
- Skip comments that are themselves replies — they're part of an existing thread
- Skip comments marked as ALREADY RESOLVED — don't reply again to fixed issues

For **top-level PR comments** that aren't inline review comments, reply using:
```bash
gh pr comment $PR_NUMBER --body "Your reply here"
```

### Reply tone and content

**For accepted suggestions — simple/obvious fixes (typos, missing imports, small naming tweaks):**
Keep it short. No need to explain what's self-evident.
```
Fixed.
```
```
Good catch, fixed.
```

**For accepted suggestions — substantive changes:**
Briefly acknowledge what was improved and why it matters. 2-3 sentences max.
```
Done. Switched to `[weak self]` here — the closure was capturing self strongly
and could retain the view controller after dismissal.
```
```
Added the nil coalescing. The API can return null for this field despite the
docs saying otherwise, which would crash downstream.
```
```
Good call — wrapped the DB query in a transaction. Concurrent writes to that
table could absolutely cause a partial update.
```

**For rejected suggestions — always explain why:**
Be clear and respectful, but direct. Don't be apologetic or wishy-washy. Give the actual technical reason. 2-4 sentences max.
```
Skipping this one. The suggested guard clause would add an early return before
the notification is posted, which would silently break observers downstream.
The current flow is intentional.
```
```
Respectfully disagree. `async let` is the right pattern for these two independent
calls — a TaskGroup would add complexity with no benefit since we know the exact
number of tasks at compile time.
```
```
This suggests a pattern that's outdated for the version we're targeting. With
structured concurrency, we don't need to manually manage the dispatch queue —
the actor already provides that serialization guarantee.
```
```
The suggested `useMemo` here would actually hurt — the dependency array changes
on every render because of the inline object. The current implementation is
already cheap enough that memoization adds overhead for no gain.
```

**For flagged suggestions:**
```
Flagging for discussion. This would change the data flow between the view model
and the coordinator, which has implications for [X]. Worth a quick sync before
deciding. @[author] thoughts?
```

### Rules for replies
- **Never write walls of text.** Keep replies concise and scannable.
- **Never be condescending.** The reviewer took time to review your code.
- **Always give the real reason** for rejections — not "I prefer it this way" but the actual technical justification.
- **Don't explain the obvious.** If you fixed a typo, just say "Fixed." Don't write a paragraph about it.
- **Use code references** when they help (backtick formatting for symbol names, patterns, etc.)
- **Batch awareness:** If multiple comments point at the same underlying issue, reply to the first one with the full explanation and reply to the others with "See reply above" or similar.

## Step 7: Post a summary comment

After all individual replies are posted, leave one top-level summary comment on the PR.

Build the comment dynamically based on what actually happened:
- Only include sections that have items (no empty "Rejected (0)" sections)
- Add a brief thank you if there were human reviewers (not bots/agents)

```bash
# Build the comment body dynamically
COMMENT="## Review feedback addressed\n\n"

if [[ implemented_count -gt 0 ]]; then
  COMMENT+="**Implemented** ($implemented_count):\n"
  COMMENT+="- [one-liner per change]\n\n"
fi

if [[ rejected_count -gt 0 ]]; then
  COMMENT+="**Rejected** ($rejected_count):\n"
  COMMENT+="- [one-liner per rejection with brief reason]\n\n"
fi

if [[ flagged_count -gt 0 ]]; then
  COMMENT+="**Flagged for discussion** ($flagged_count):\n"
  COMMENT+="- [one-liner per flagged item]\n\n"
fi

# Add thank you if there were human reviewers
if [[ has_human_reviewers ]]; then
  COMMENT+="Thanks for the review! "
fi

COMMENT+="All changes pushed in [commit SHA short]."

gh pr comment $PR_NUMBER --body "$COMMENT"
```

Note: Don't thank bot reviewers (Copilot, Vercel, etc.) — only thank actual humans who took time to review.

## Important rules

- **Never blindly implement all comments.** That defeats the entire purpose.
- **Read the actual code around each suggestion** before deciding — context is everything.
- **Check git blame / history** if a comment questions why something was done a certain way — there may be a good reason.
- **Prefer minimal, surgical changes** over rewrites.
- **If a suggestion is good but the proposed implementation is wrong**, implement the *intent* correctly rather than copy-pasting the suggested code.
- When in doubt, **reject and flag** rather than implement something you're unsure about.
- **Wait for my confirmation** after the analysis step before implementing or posting any replies.
