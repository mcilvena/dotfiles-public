# Claude Code Configuration

This directory contains Claude Code configuration that's version controlled and portable across machines.

## Directory Structure

```
src/.claude/
├── commands/              # Custom slash commands
│   └── review-changes.md  # /review-changes command for dotfiles review
├── local/                 # Git commit automation scripts
│   ├── single-commit      # Single AI-generated commit
│   └── batch-commit       # Batch commits for unstaged changes
├── settings.json          # Global Claude Code preferences
├── settings.local.json.example  # Project-specific settings template
└── mcp-config.json.example      # MCP server configuration template
```

## Configuration Levels

### 1. Global Settings (`settings.json`)
Synced across all projects:
- Default mode (plan/code)
- Thinking preferences
- UI preferences

**File**: `src/.claude/settings.json`
**Stowed to**: `~/.claude/settings.json`

### 2. Project Settings (`settings.local.json`)
Project-specific configuration:
- Permissions (allowed/denied tools and domains)
- Plugin marketplaces
- Installed plugins

**Template**: `src/.claude/settings.local.json.example`
**Active file**: `.claude/settings.local.json` (gitignored, machine-specific)

When you trust the dotfiles repository, Claude Code reads the active `settings.local.json` and auto-installs configured plugins.

### 3. MCP Servers (`~/.claude.json`)
Machine-specific tool integrations:
- Cargo/Rust tools
- Database connections
- API integrations
- Any tools requiring credentials or local paths

**Template**: `src/.claude/mcp-config.json.example`
**Active file**: `~/.claude.json` (not in dotfiles, machine-specific)

## How Plugin Auto-Install Works

When you open Claude Code in the dotfiles directory:

1. **Trust prompt appears**: "Do you trust this repository?"
2. **Answer "yes"**
3. **Claude Code reads** `.claude/settings.local.json`
4. **Automatically installs**:
   - Marketplaces listed in `plugins.marketplaces`
   - Plugins listed in `plugins.installed`

### Adding New Plugins

To add a plugin to auto-install:

1. Edit `.claude/settings.local.json.example`:
   ```json
   {
     "plugins": {
       "marketplaces": [
         "anthropics/claude-code",
         "username/my-marketplace"  // Add new marketplace
       ],
       "installed": [
         "feature-dev@claude-code",
         "my-plugin@my-marketplace"  // Add new plugin
       ]
     }
   }
   ```

2. Copy to active file (if needed):
   ```bash
   cp src/.claude/settings.local.json.example .claude/settings.local.json
   ```

3. Restart Claude Code or re-trust the repository

## Slash Commands

Custom commands are Markdown files in `commands/` directory.

### Creating a Command

1. Create file: `src/.claude/commands/my-command.md`
2. Add content with optional frontmatter:
   ```markdown
   ---
   description: Brief description of what this command does
   allowed-tools: [Bash, Read, Grep]
   argument-hint: "[optional-arg]"
   ---

   Your command prompt here.
   Use $1, $2, or $ARGUMENTS for user input.
   ```

3. Stow dotfiles: `make stow`
4. Restart Claude Code
5. Use command: `/my-command [args]`

### Command Namespacing

Commands in this directory appear as:
- `/my-command` (if unique)
- `/dotfiles:my-command` (if name conflicts exist)

## Git Commit Scripts

Located in `local/` directory, these are symlinked to `~/.claude/local/`.

### single-commit
Generates and creates one commit from staged changes.

**Usage** (in lazygit):
- Press `C` on staged files
- Claude analyzes changes and creates conventional commit

**Direct usage**:
```bash
git add files...
~/.claude/local/single-commit
```

### batch-commit
Analyzes all unstaged changes, groups them logically, and creates multiple commits.

**Usage** (in lazygit):
- Press `B` with unstaged changes
- Claude groups changes and creates multiple logical commits

**Direct usage**:
```bash
~/.claude/local/batch-commit
```

## MCP Servers

MCP (Model Context Protocol) servers provide Claude Code with tools and integrations.

### Why MCP Config is Separate

MCP servers often require:
- **Credentials** (API keys, tokens)
- **Local paths** (project-specific directories)
- **Environment variables** (machine-specific settings)

Therefore, MCP configuration lives in `~/.claude.json` (not version controlled).

### Using the Template

1. View template: `cat src/.claude/mcp-config.json.example`
2. Install MCP server: `cargo install cargo-mcp`
3. Add to `~/.claude.json`:
   ```bash
   # Option 1: CLI wizard
   claude mcp add cargo-mcp --scope user -- cargo-mcp

   # Option 2: Manual edit
   # Edit ~/.claude.json and add mcpServers config
   ```

4. Restart Claude Code
5. Verify: `/mcp` command shows "connected"

## Project vs Personal Configuration

### Project Config (this repo)
- **Location**: `.claude/` in project root
- **Purpose**: Team/project-specific settings
- **Auto-installs**: When repository is trusted
- **Examples**: Plugins, slash commands, permissions

### Personal Config (global)
- **Location**: `~/.claude/`
- **Purpose**: Personal preferences across all projects
- **Examples**: Global settings, personal commands, MCP servers

## Best Practices

1. **Keep secrets out**: Never commit credentials or API keys
2. **Use templates**: Provide `.example` files for sensitive configs
3. **Document permissions**: Explain why specific tools are allowed
4. **Test on fresh clone**: Verify auto-install works on new machine
5. **Update templates**: Keep examples in sync with active configs

## Troubleshooting

### Plugins not installing?
- Ensure repository is trusted
- Check `.claude/settings.local.json` exists (not just .example)
- Restart Claude Code
- Run `/plugin list` to verify

### Slash commands not appearing?
- Verify files are in `src/.claude/commands/`
- Check symlinks: `ls -la ~/.claude/commands/`
- Restart Claude Code
- Run `/help` to see available commands

### MCP server not connecting?
- Run `/mcp` to see connection status
- Verify binary installed: `which cargo-mcp`
- Check `~/.claude.json` syntax (valid JSON)
- Restart Claude Code
- Check logs in `~/.claude/debug/`

## See Also

- Main docs: `../CLAUDE.md`
- Dotfiles README: `../../README.md`
- Lazygit config: `../config/lazygit/config.yml`
