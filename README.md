# Claude Code: Data Integration AI System

Created by Dipen Patel.

A structured Claude Code configuration built for health data integration work. Turns Claude from a general assistant into a specialized thinking partner: oriented to your stack, governed by explicit standards, and designed to hand off cleanly between phases of work.

---

## What Is In This Repo

| File / Folder | What it is |
|---|---|
| `CLAUDE.md` | Core behavior rules. Claude reads this on every session. Fill in your identity at the top. |
| `voice-standard.md` | Writing rules. Every output follows these. |
| `technical-standards.md` | Code and artifact quality rules. Applied by every skill that produces technical output. |
| `pipeline-standards.md` | Pipeline architecture rules. Layer boundaries, write semantics, schema lineage. |
| `skill-standard.md` | Structural rules for skill files. Read before writing a new skill. |
| `commands/` | Skill files. Each one is a `/command` you invoke in Claude Code. |
| `lenses/` | Perspective files for `/lens`. Each one shifts how Claude frames a problem. |
| `memory/` | Personal feedback memories. Accumulate as you work and correct Claude. |
| `cursor-rules/` | Cursor IDE policy files for the secondary review workflow. |
| `settings.json` | Permission rules for Claude Code. Edit to add tools you use. |
| `settings.local.json` | MCP server credentials. Fill in your tokens. Never commit this file. |
| `docs/` | Guides for setup, system design, and worked examples. |

---

## Documentation

| Document | What it covers |
|---|---|
| [Overview](docs/overview.md) | What the system is and how the skill chain works |
| [Setup](docs/setup.md) | Step by step setup from clone to first session |
| [System Design](docs/system-design.md) | Architecture: departments model, standards, state, vault, PHI rules, how to adopt |
| [Skill Chains](docs/skill-chains.md) | Ticket types, chain structures, gates, and when to stop |
| [Walkthrough](docs/walkthrough.md) | Complete bug ticket worked end to end with fake data |
| [File Structure](docs/structure.md) | Mac file layout for the repo, ~/.claude/, and the vault |

Start with [System Design](docs/system-design.md) to understand the architecture. Then [Walkthrough](docs/walkthrough.md) to see it in action.

---

## Quick Start

1. Clone this repo to your local machine
2. Follow [Setup](docs/setup.md) to configure your environment and MCP credentials
3. Fill in your identity in `CLAUDE.md`
4. Copy the `commands/` folder to `~/.claude/commands/`
5. Open Claude Code in VSCode and run `/start`

---

## The Skill Chain

Most tickets follow one of these patterns:

**Coordination (investigation, decision, status update):**
```
/start → /qh-ticket [ID] → /close
```

**Bug (wrong data, trace root cause):**
```
/start → /qh-ticket [ID] → /qh-support [ID] → /qh-spec [ID] → /qh-arch [ID] → /qh-dev [ID] → /qh-qa [ID] → /close
```

**Build (new feature, new pipeline):**
```
/start → /qh-ticket [ID] → /qh-spec [ID] → /qh-arch [ID] → /qh-dev [ID] → /qh-qa [ID] → /close
```

See [Walkthrough](docs/walkthrough.md) for a complete example of the bug chain with fake data.

---

## Key Design Principles

Every output is a draft. Nothing is sent or committed automatically. You send.

Each skill is a role. `/qh-spec` is the product manager. `/qh-arch` is the architect. `/qh-dev` is the engineer. `/qh-qa` is the adversary. The chain exists because each role has a different job and a defined handoff.

State carries forward through the vault. A state file in `02-tickets/{KEY}/{KEY}-state.md` means any session can pick up exactly where the last one left off.

PHI guardrails apply at every layer. No patient identifiers in logs, drafts, vault files, code comments, or commit messages.

---

## License

MIT. See `LICENSE`.

