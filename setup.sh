#!/usr/bin/env bash
# setup.sh — Idempotent symlink setup for claude-config repo
# Run this after cloning the repo on any machine.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

# Compute the machine-specific projects slug (mirrors how Claude Code names it)
# e.g. /Users/yourname → -Users-yourname
SLUG=$(echo "$HOME" | sed 's|/|-|g')
MEMORY_TARGET="$CLAUDE_DIR/projects/$SLUG/memory"

backup() {
  local path="$1"
  if [ -e "$path" ] && [ ! -L "$path" ]; then
    local backup="$path.bak.$(date +%Y%m%d%H%M%S)"
    echo "  Backing up $path → $backup"
    mv "$path" "$backup"
  fi
}

symlink() {
  local src="$1"   # repo file/dir
  local dest="$2"  # ~/.claude/ location
  backup "$dest"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "  ✓ Already linked: $dest"
  else
    ln -sf "$src" "$dest"
    echo "  ✓ Linked: $dest → $src"
  fi
}

echo "Setting up Claude Code config symlinks..."

# Ensure target dirs exist
mkdir -p "$CLAUDE_DIR"
mkdir -p "$(dirname "$MEMORY_TARGET")"

symlink "$REPO_DIR/CLAUDE.md"   "$CLAUDE_DIR/CLAUDE.md"
symlink "$REPO_DIR/settings.json" "$CLAUDE_DIR/settings.json"
symlink "$REPO_DIR/commands"    "$CLAUDE_DIR/commands"
symlink "$REPO_DIR/memory"      "$MEMORY_TARGET"

echo ""
echo "Setting up Cursor rules symlinks..."

# Cursor rules — deploy to qh-knowledge vault
# Override QH_KNOWLEDGE env var on a new machine if vault is in a different location
QH_KNOWLEDGE="${QH_KNOWLEDGE:-$HOME/Developer/qh-knowledge}"
CURSOR_RULES_DIR="$QH_KNOWLEDGE/.cursor/rules"

if [ -d "$QH_KNOWLEDGE" ]; then
  mkdir -p "$CURSOR_RULES_DIR"
  symlink "$REPO_DIR/cursor-rules/00-policy.mdc"  "$CURSOR_RULES_DIR/00-policy.mdc"
  symlink "$REPO_DIR/cursor-rules/01-context.mdc" "$CURSOR_RULES_DIR/01-context.mdc"
  echo "  Vault: $QH_KNOWLEDGE"
else
  echo "  Skipped: vault not found at $QH_KNOWLEDGE"
  echo "  Set QH_KNOWLEDGE=/path/to/vault and re-run to deploy Cursor rules."
fi

echo ""
echo "Done! All symlinks are in place."
echo "Repo: $REPO_DIR"
echo ""
echo "Next: fill in real API tokens in settings.local.json (gitignored, never committed)"
echo "New machine? Set QH_KNOWLEDGE=/path/to/vault before running setup.sh"
