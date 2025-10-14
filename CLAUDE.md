# Claude Code Memory for mcilvena's dotfiles

## Important Instructions

### Sudo Commands
- **NEVER run sudo commands directly**
- When sudo is needed, prompt the user with the exact command to run
- User will execute sudo commands separately in their terminal
- Continue with non-sudo parts of the workflow after prompting

## System Information
- OS: Arch Linux
- Window Manager: Hyprland
- Theme: Catppuccin (based on config files)
- Shell: ZSH (based on .zshrc presence)

## Project Structure
- Main dotfiles in `src/` directory
- Hyprland configs in `src/.config/hypr/`
- Contains wallpaper management scripts
- Uses rofi for power menu functionality
- Claude Code configs in `src/.claude/`

## Development Workflow
- Run lint/typecheck commands when available
- Only commit changes when explicitly requested
- Follow existing code conventions and patterns

## Claude Code Configuration

### New Machine Setup

1. **Clone and stow dotfiles**:
   ```bash
   cd ~/dotfiles
   make stow
   ```

2. **Trust the dotfiles repository**:
   - When Claude Code prompts to trust the repository, answer "yes"
   - Plugins and marketplaces will **automatically install** from `.claude/settings.local.json`

3. **Install MCP servers** (optional, for Rust development):
   ```bash
   cargo install cargo-mcp
   ```

   Then configure in `~/.claude.json` (see MCP template in `src/.claude/mcp-config.json.example`)

4. **Restart Claude Code** to load slash commands and plugins

### Custom Slash Commands
- `/review-changes` - Review uncommitted changes with Arch/Hyprland context
- Located in `src/.claude/commands/`

### Plugins (Auto-Install)
Configured in `.claude/settings.local.json` for automatic installation:
- **Marketplace**: `anthropics/claude-code` - Official Anthropic plugin repository
- **Plugins**: `feature-dev` - Structured feature development workflow

When you trust this repository, these plugins install automatically. No manual `/plugin` commands needed!

### MCP Servers (Manual Setup)
MCP servers require machine-specific configuration in `~/.claude.json`.

**For Rust development** - cargo-mcp:
```bash
cargo install cargo-mcp
```

Then add to `~/.claude.json`:
```json
{
  "mcpServers": {
    "cargo-mcp": {
      "type": "stdio",
      "command": "cargo-mcp",
      "args": [],
      "env": {
        "CARGO_MCP_DEFAULT_TOOLCHAIN": "stable"
      }
    }
  }
}
```

See `src/.claude/mcp-config.json.example` for template.

### Git Commit Scripts
- `~/.claude/local/single-commit` - AI-generated commit for staged changes
- `~/.claude/local/batch-commit` - Batch commits from unstaged changes
- Used via lazygit keybindings: `C` and `B`