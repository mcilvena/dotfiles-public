# Claude Code Git Commit Scripts

AI-powered git commit tools that help create well-structured, logical commits during rapid development sessions with Claude Code.

## Problem

When developing with Claude Code, you often end up with many changes across multiple files that should be committed as separate, logical commits rather than one massive commit. Manually staging files and writing commit messages for each logical change is tedious and time-consuming.

## Solution

These scripts use Claude AI to:
- Analyze your changes and group them into logical commits
- Generate conventional commit messages that clearly describe what changed and why
- Automate the entire commit process while maintaining good git hygiene

## Scripts

### `single-commit`
Creates a single commit from currently staged changes with an AI-generated commit message.

**Use when:**
- You've already staged the files you want to commit
- You want a well-formatted commit message without manual writing
- You're using this as part of the batch-commit workflow

**Features:**
- Generates conventional commit messages (feat:, fix:, refactor:, etc.)
- Includes detailed descriptions when needed
- Handles large diffs gracefully (50KB limit with truncation)
- Multi-line commit message support

### `batch-commit`
Intelligently analyzes ALL unstaged changes and groups them into multiple logical commits.

**Use when:**
- You have many changes across multiple files
- Changes span different features, fixes, or refactorings
- You want to maintain clean git history without manual file staging

**Features:**
- Groups changes by domain/feature area (API, database, frontend, tests, etc.)
- Groups by change type (feat, refactor, fix, test, docs, chore)
- Creates multiple commits automatically in one command
- Handles untracked files and large diffs safely
- Colorized output for better visibility
- Safety limits to prevent infinite loops or token limit issues

## Installation

### 1. Install Claude Code CLI

First, ensure you have the Claude CLI installed. The scripts expect it at:
```bash
~/.claude/local/claude
```

Or set a custom path via environment variable:
```bash
export CLAUDE_CLI_PATH="/path/to/your/claude"
```

### 2. Install the Scripts

Copy both scripts to a directory in your PATH:

```bash
# Create the directory if it doesn't exist
mkdir -p ~/.local/bin

# Copy the scripts
cp single-commit batch-commit ~/.local/bin/

# Make them executable
chmod +x ~/.local/bin/single-commit
chmod +x ~/.local/bin/batch-commit

# Ensure ~/.local/bin is in your PATH (add to ~/.bashrc or ~/.zshrc if not)
export PATH="$HOME/.local/bin:$PATH"
```

### 3. Verify Installation

```bash
which single-commit
which batch-commit
```

Both should show paths to your installed scripts.

## Usage

### Single Commit Workflow

```bash
# Make your changes
vim file1.js file2.js

# Stage the files you want to commit
git add file1.js file2.js

# Generate commit message and commit
single-commit
```

**Example output:**
```
[main abc1234] feat: add user authentication endpoint
 2 files changed, 45 insertions(+), 3 deletions(-)
```

### Batch Commit Workflow

```bash
# Make many changes across different areas
vim src/api/users.js
vim src/components/Login.jsx
vim tests/auth.test.js
vim README.md

# Let Claude analyze and create multiple commits
batch-commit
```

**Example output:**
```
Analyzing changes...
Asking Claude to group changes into logical commits...
Processing commit group 1 (total: 1)...
  Staged: src/api/users.js
Created commit 1: feat: add user registration endpoint

Processing commit group 2 (total: 2)...
  Staged: src/components/Login.jsx
Created commit 2: feat: add login component with form validation

Processing commit group 3 (total: 3)...
  Staged: tests/auth.test.js
Created commit 3: test: add authentication flow tests

Processing commit group 4 (total: 4)...
  Staged: README.md
Created commit 4: docs: update authentication setup instructions

All changes have been committed in 4 total commit(s) across 1 iteration(s)!
```

## Integration with Lazygit

These scripts work great with lazygit. Add custom commands to your lazygit config (`~/.config/lazygit/config.yml`):

```yaml
customCommands:
  - key: 'C'
    command: 'single-commit'
    description: 'AI commit (staged changes)'
    context: 'files'
    loadingText: 'Generating commit message...'
    subprocess: true

  - key: 'B'
    command: 'batch-commit'
    description: 'AI batch commit (all unstaged)'
    context: 'files'
    loadingText: 'Creating logical commits...'
    subprocess: true
```

Then in lazygit:
- **C** - Commit staged changes with AI-generated message
- **B** - Group all unstaged changes into logical commits

## How It Works

### single-commit
1. Validates that Claude CLI is available
2. Checks for staged changes
3. Gets the staged diff (with 50KB size limit)
4. Sends diff to Claude with a prompt for conventional commit format
5. Parses Claude's response to extract the commit message
6. Creates the commit with the generated message

### batch-commit
1. Validates Claude CLI and single-commit script are available
2. Analyzes ALL unstaged changes (modified files + untracked files)
3. Sends changes to Claude to group into logical commits
4. For each group Claude identifies:
   - Stages only those files
   - Calls single-commit to create the commit
   - Moves to next group
5. Repeats until all changes are committed (max 20 iterations)

## Configuration

### Environment Variables

- `CLAUDE_CLI_PATH` - Custom path to Claude CLI executable (default: `~/.claude/local/claude`)

### Script Limits

**single-commit:**
- Max diff size: 50KB (truncates larger diffs)
- Max commit message lines: 20

**batch-commit:**
- Max iterations: 20 (prevents infinite loops)
- Max file size: 1MB (skips larger files)
- Max total diff size: 10MB (stops adding files after limit)
- Skips binary files automatically

## Troubleshooting

### "Claude CLI not found"
Ensure Claude CLI is installed and the path is correct:
```bash
ls -la ~/.claude/local/claude
# Or set custom path
export CLAUDE_CLI_PATH="/actual/path/to/claude"
```

### "No staged changes to commit" (single-commit)
You need to stage files first:
```bash
git add <files>
```

### "No unstaged changes or untracked files to commit" (batch-commit)
All your changes are already committed or staged. This is expected behavior.

### Commits not grouping as expected
The AI's grouping is based on the diff content. You can:
- Run batch-commit again to regroup remaining changes
- Use single-commit for more control over individual commits
- Manually stage files and use single-commit

### Large files being skipped
This is intentional to avoid token limit issues. For large files:
- Commit them separately with `git commit` manually
- Or increase the limits in the script (edit MAX_FILE_SIZE)

## Best Practices

1. **Review before pushing** - These scripts create commits locally. Always review with `git log` before pushing.

2. **Use batch-commit early** - Run it when you have lots of changes. Don't wait until you have hundreds of files changed.

3. **Combine with manual commits** - Use these for most commits, but manually commit when you need very specific control.

4. **Stage intentionally** - For single-commit, stage only related files together.

5. **Check the generated messages** - If a commit message isn't quite right, use `git commit --amend` to fix it.

## Requirements

- Bash 4.0+
- Git 2.0+
- Claude Code CLI
- Standard Unix tools: `awk`, `sed`, `grep`, `file`, `stat`

## License

These scripts are provided as-is for use with Claude Code development workflows. Feel free to modify and share with your team.

## Credits

Created for streamlining git workflows during Claude Code development sessions where rapid changes benefit from automated, intelligent commit organization.
