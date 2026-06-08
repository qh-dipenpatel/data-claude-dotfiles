# Claude Code: Data Integration AI System

Created by Dipen Patel.

---

## What This Is

This is a structured Claude Code configuration built for data integration work. It turns Claude from a general assistant into a specialized thinking partner that knows:

- The QH Jira workflow and ticket chain
- The Bronze layer ingestion pipeline and how to debug it
- The communication style for client vs internal messages
- How to structure specs, designs, and QA reviews for QH tickets
- PHI and PII guardrails that apply to every layer of the system



---

## What It Does

This system replaces ad hoc Claude use with a structured session model:

1. Every session starts with `/start` (Jira sync, vault health, blockers surface)
2. Ticket work follows a skill chain: orient → spec → design → implement → QA
3. Every session ends with `/close` (session log, memory update, vault commit)

Between those bookends, skills handle specific tasks:
- `/qh-ticket` orients you to any assigned ticket in 10 minutes
- `/qh-spec` produces acceptance criteria and success metrics
- `/qh-arch` produces design options with trade offs and a recommendation
- `/qh-dev` implements against an approved design, no scope drift
- `/qh-qa` runs an adversarial review before any PR is opened
- `/qh-support` diagnoses bug tickets from source to silver
- `/draft` writes any Jira comment, Slack message, or email following the team voice standard
- `/learn` runs structured learning sessions on Databricks and Unity Catalog

---

## What It Is Not

The system does not:
- Run autonomously or schedule itself
- Access production systems directly
- Send or post to any external system (Slack, Jira, Confluence)
- Make decisions for you

Every output is a draft. You review and send.

---

## The Skill Chain

Most tickets follow one of these chains:

**Coordination ticket (investigation + comment + next step):**
`/start ticket → /qh-ticket [ID] → /close`

**Bug ticket:**
`/start → /qh-ticket [ID] → /qh-support [ID] → /qh-spec [ID] → /qh-arch [ID] → [approve] → /qh-dev [ID] → /qh-qa [ID] → /close`

**Build ticket:**
`/start → /qh-ticket [ID] → /qh-spec [ID] → /qh-arch [ID] → [approve] → /qh-dev [ID] → /qh-qa [ID] → /close`

Each skill in the chain reads the output of the previous skill. State carries forward through the vault.

---

## Files in This Repo

| File / Folder | What it is |
|---|---|
| `CLAUDE.md` | The core behavior rules. Claude reads this on every session. Fill in your identity at the top. |
| `voice-standard.md` | The writing rules. Every output follows these. |
| `commands/` | Skill files. Each one is a `/command` you invoke in Claude Code. |
| `lenses/` | Perspective files for `/lens`. Each one shifts how Claude frames a problem. |
| `memory/` | Your personal feedback memories. These accumulate as you work and correct Claude. |
| `settings.json` | Permission rules for Claude Code. Edit to add tools you use. |
| `settings.local.json` | MCP server credentials. Fill in your tokens. Never commit this file. |
| `docs/` | This folder. Guides for setup and integration. |

---

## Next Steps

1. Read `docs/setup.md` to configure your environment
2. Read `docs/system-design.md` to understand how the system is architected
3. Read `docs/walkthrough.md` to see a complete bug ticket worked end to end with fake data
4. Fill in your identity in `CLAUDE.md`
5. Fill in your MCP tokens in `settings.local.json`
6. Run your first `/start` and follow the checklist
