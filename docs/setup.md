# Setup Guide

This guide gets you from a fresh clone to a working first session.

---

## Prerequisites

- Claude Code installed and running
- VSCode with the Claude Code extension
- Obsidian installed (for the knowledge vault)
- Access to QH Jira and Atlassian (for MCP integration)
- Access to Slack (for MCP integration)

---

## Step 1: Clone the repo

Copy this folder to your local machine. Suggested location:

```bash
~/Developer/[your-name]/claude-dotfiles/
```

---

## Step 2: Set environment variables

Add these to your `~/.zshrc` or `~/.bashrc`:

```bash
export QH_SCRIPTS=~/path/to/your/qh-scripts
export QH_KNOWLEDGE=~/path/to/your/vault
export QH_MEETINGS=~/path/to/your/meetings
export CLAUDE_DOTFILES=~/Developer/[your-name]/claude-dotfiles
```

Reload your shell:
```bash
source ~/.zshrc
```

`$QH_SCRIPTS` is optional for the base setup. Most skills degrade gracefully when scripts are not present. See `docs/scripts.md` for the full scripts system.

`$QH_KNOWLEDGE` is required. This is your Obsidian vault root.

---

## Step 3: Create your Obsidian vault

Create a new Obsidian vault. Suggested name: `qh-knowledge`.

Inside the vault, create this folder structure:

```
00-landing/
01-system-map/
    clients/
    pipelines/
    architecture/
    data-model/
    databricks-learning/
02-tickets/
03-knowledge-base/
    decisions/
    learnings/
    patterns/
```

Point `$QH_KNOWLEDGE` at the vault root.

---

## Step 4: Configure MCP servers

Open `settings.local.json` and fill in your credentials:

```json
{
  "mcpServers": {
    "slack": {
      "env": {
        "SLACK_BOT_TOKEN": "xoxb-your-token-here",
        "SLACK_TEAM_ID": "your-team-id"
      }
    },
    "atlassian": {
      "env": {
        "CONFLUENCE_URL": "https://your-org.atlassian.net/wiki",
        "CONFLUENCE_USERNAME": "your.email@qualifiedhealth.com",
        "CONFLUENCE_API_TOKEN": "your-atlassian-api-token",
        "JIRA_URL": "https://your-org.atlassian.net",
        "JIRA_USERNAME": "your.email@qualifiedhealth.com",
        "JIRA_API_TOKEN": "your-atlassian-api-token"
      }
    }
  }
}
```

To get an Atlassian API token: go to id.atlassian.com, Security, API tokens.

Never commit `settings.local.json`. It is in `.gitignore`.

---

## Step 5: Fill in your identity

Open `CLAUDE.md` and fill in the Identity section at the top:

```
**Name:** Your Name
**Title:** Your Title
```

---

## Step 6: Install the dotfiles

Copy the commands folder so Claude Code can find the skills:

```bash
mkdir -p ~/.claude/commands
cp -r $CLAUDE_DOTFILES/commands/* ~/.claude/commands/
cp $CLAUDE_DOTFILES/CLAUDE.md ~/.claude/CLAUDE.md
```

Or keep a live link so edits to the repo apply immediately:

```bash
ln -sf $CLAUDE_DOTFILES/commands/* ~/.claude/commands/
```

---

## Step 7: Run your first session

Open a new Claude Code session and type:

```
/start ticket
```

The checklist will run. Each item either passes or logs a skip reason. After the checklist, you're ready to run `/qh-ticket [JIRA-ID]` on any assigned ticket.

---

## Troubleshooting

**MCP tool not found.** Your Atlassian or Slack MCP server is not connected. Check the tokens in `settings.local.json` and reconnect the server in Claude Code settings.

**$QH_KNOWLEDGE not found.** Your shell profile doesn't have the env var exported. Check Step 2 and reload your shell.

**Script steps skipped in /start.** Normal if `$QH_SCRIPTS` is not set. The skill continues without the vault health and repo sync steps. See `docs/scripts.md` to set up the scripts system.

---

## What's Next

- Read `docs/overview.md` to understand how the skill chain works
- Try `/learn Databricks` for your first learning session
- Try `/qh-ticket [a real ticket ID]` to orient to your first ticket
