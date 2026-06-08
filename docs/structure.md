# File Structure and Layout

Created by Dipen Patel.

This document shows where everything lives on your Mac, what each piece does, and how the parts connect at runtime.

---

## How the Parts Fit Together

Three locations work together every session:

```
claude-dotfiles/     ← your config repo (this repo)
     |
     | you install (copy or symlink)
     ↓
~/.claude/           ← Claude Code reads from here at runtime
     |
     | skills write state and session logs to
     ↓
your-vault/          ← your Obsidian knowledge base ($QH_KNOWLEDGE)
```

You edit config in `claude-dotfiles/`. You install it to `~/.claude/`. Claude reads from `~/.claude/` and writes context to your vault. The three never overlap.

---

## This Repo: claude-dotfiles/

Suggested location: `~/Developer/[your-name]/claude-dotfiles/`

```
claude-dotfiles/
│
├── README.md                     ← start here
│
├── CLAUDE.md                     ← core behavior rules, identity, guardrails
│                                    Claude reads this at the start of every session
│
├── voice-standard.md             ← writing rules for every word Claude produces
│                                    conclusion first, bracket test, two voices
│
├── technical-standards.md        ← code quality rules: type hints, 40 line limit,
│                                    no magic numbers, explicit write modes
│
├── pipeline-standards.md         ← pipeline rules: layer boundaries, idempotency,
│                                    null handling, schema lineage
│
├── skill-standard.md             ← structural rules for skill files
│                                    read this before writing a new skill
│
├── settings.json                 ← Claude Code permissions (which tools are allowed)
│                                    edit to add tools your workflow needs
│
├── settings.local.json           ← MCP server credentials
│                                    NEVER commit this file — add to .gitignore
│
├── commands/                     ← one file per skill
│   ├── start.md                  ← /start    open a session, Jira sync, blockers
│   ├── close.md                  ← /close    session log, memory, vault commit
│   ├── qh-ticket.md              ← /qh-ticket  orient on any ticket, classify, route
│   ├── qh-support.md             ← /qh-support  diagnose bugs, trace source to silver
│   ├── qh-spec.md                ← /qh-spec    requirements and acceptance criteria
│   ├── qh-arch.md                ← /qh-arch    design options, trade offs, recommendation
│   ├── qh-dev.md                 ← /qh-dev     implement against approved design
│   ├── qh-qa.md                  ← /qh-qa      adversarial review before PR
│   ├── draft.md                  ← /draft      write any message going to another person
│   ├── weekly.md                 ← /weekly     client call prep
│   ├── status.md                 ← /status     current state for a client or ticket
│   ├── learn.md                  ← /learn      structured learning sessions
│   ├── sync.md                   ← /sync       10 minute fact hygiene
│   ├── save.md                   ← /save       mid session checkpoint
│   ├── whiteboard.md             ← /whiteboard  idea validation before backlog
│   ├── setup-client.md           ← /setup-client  new client onboarding
│   ├── pull-notes.md             ← /pull-notes  meeting transcript into vault
│   ├── explore.md                ← /explore    learn a new system area or pipeline
│   └── lens.md                   ← /lens       shift perspective mid session
│
├── lenses/                       ← perspective files used by /lens
│   ├── client.md                 ← how a client sees the situation
│   ├── manager.md                ← how your manager sees it
│   ├── jr-dev.md                 ← how a junior developer sees it
│   ├── teacher.md                ← how a teacher would explain it
│   ├── end-user-doctor.md        ← how a physician sees the data
│   ├── end-user-nurse.md         ← how a nurse sees the data
│   ├── end-user-admin.md         ← how a clinical admin sees it
│   └── coworker.md               ← how a peer on your team sees it
│
├── memory/                       ← personal feedback memories
│   └── MEMORY.md                 ← index of all memory files
│                                    memories accumulate here as you correct Claude
│
├── cursor-rules/                 ← Cursor IDE policy files
│   ├── 00-policy.mdc             ← what Cursor is and is not allowed to do
│   └── 01-context.mdc            ← system context for Cursor sessions
│
└── docs/                         ← this folder
    ├── overview.md               ← what the system is and how it works
    ├── setup.md                  ← step by step from clone to first session
    ├── system-design.md          ← architecture, philosophy, how to adopt
    ├── skill-chains.md           ← ticket types, chains, gates, when to stop
    ├── walkthrough.md            ← complete bug ticket with fake data
    └── structure.md              ← this file
```

---

## Claude Code Runtime: ~/.claude/

Claude Code reads from `~/.claude/` at runtime. You install your config here from the dotfiles repo.

```
~/.claude/
│
├── CLAUDE.md                     ← copied or symlinked from claude-dotfiles/CLAUDE.md
│                                    this is what Claude actually reads at session start
│
├── commands/                     ← copied or symlinked from claude-dotfiles/commands/
│   └── [all skill files]         ← Claude finds /commands here when you type /qh-ticket etc.
│
├── settings.json                 ← copied or symlinked from claude-dotfiles/settings.json
│
└── projects/                     ← Claude Code writes session data here automatically
    └── [session-id]/             ← one folder per working directory
        ├── tool-results/         ← cached tool call results
        └── memory/               ← your memory files for this project context
```

To install: copy or symlink the three files from your dotfiles repo:

```bash
cp $CLAUDE_DOTFILES/CLAUDE.md ~/.claude/CLAUDE.md
cp -r $CLAUDE_DOTFILES/commands/* ~/.claude/commands/
cp $CLAUDE_DOTFILES/settings.json ~/.claude/settings.json
```

Or symlink for live edits (changes to the repo apply immediately):

```bash
ln -sf $CLAUDE_DOTFILES/commands ~/.claude/commands
```

---

## Your Vault: $QH_KNOWLEDGE

Suggested location: `~/Developer/[your-name]/[your-vault]/`

The vault is your personal knowledge base. Skills read from and write to this location during every session. It is separate from this repo and backed by its own git repository.

```
your-vault/
│
├── 00-landing/                   ← rough notes and quick captures
│                                    start here when you have a thought to park
│
├── 01-system-map/                ← what your system looks like
│   ├── clients/
│   │   └── CLIENT-NAME.md        ← one file per client: catalog names, contacts,
│   │                                pipeline details, known issues
│   ├── pipelines/
│   │   └── PIPELINE-NAME.md      ← one file per pipeline: layers, notebooks,
│   │                                YAML config, known failure modes
│   ├── architecture/             ← how the system connects at a high level
│   ├── data-model/               ← schemas, Unity Catalog structure, Bronze/Silver
│   └── databricks-learning/      ← Databricks and Unity Catalog concepts explained
│                                    added by /learn and /explore during sessions
│
├── 02-tickets/                   ← one folder per ticket
│   └── CD-200/                   ← example ticket folder
│       ├── CD-200-state.md       ← live ticket state
│       │                            every skill reads and updates this file
│       │                            this is how the chain carries state between sessions
│       │
│       ├── CD-200-support-handoff.md  ← written by /qh-support
│       │                                root cause, evidence, fix recommendation
│       │
│       ├── CD-200-spec.md        ← written by /qh-spec
│       │                            requirements, acceptance criteria, success metrics
│       │
│       ├── CD-200-design.md      ← written by /qh-arch
│       │                            options, trade offs, approved recommendation
│       │
│       ├── CD-200-qa-findings.md ← written by /qh-qa
│       │                            findings routed to dev, arch, or spec
│       │
│       └── CD-200-session-YYYY-MM-DD.md  ← written by /close
│                                            what was done, decided, and what is next
│
└── 03-knowledge-base/            ← durable knowledge that outlives any ticket
    ├── decisions/
    │   └── YYYY-MM-DD-topic.md   ← why something was decided the way it was
    │                                used when the same question comes up again
    ├── learnings/
    │   └── YYYY-MM-DD-topic.md   ← what was learned and where it applies
    └── patterns/
        └── YYYY-MM-DD-topic.md   ← patterns that have proven themselves
                                     promoted from ticket learnings
```

---

## What the State File Looks Like

The state file at `02-tickets/{KEY}/{KEY}-state.md` is the handoff contract between skills. A real one looks like this:

```markdown
## CD-200 State

Status: SUPPORT_COMPLETE
Next skill: /qh-spec

Confirmed approach: quarantine_ind flag for null encounter_date records
Source: Data Platform approved 2026-06-02

KNOWN
  - 22 records have null encounter_date in raw_lakewood_tavr
  - Root cause: Bronze filter added in CD-157 excludes null records
  - Raw count: 500, Bronze count: 478, Silver count: 478

UNKNOWN
  - Whether Lakewood will resubmit the 22 records or provide a blanket correction

ASSUMING
  - quarantine_ind is the correct column name (verify with Data Platform)
```

When `/qh-spec` starts, it reads this file. It knows the root cause, the confirmed approach, and what is still open. It does not ask you to recap.

---

## Summary: What Goes Where

| Thing | Where it lives | Who writes it |
|---|---|---|
| Skill files | `claude-dotfiles/commands/` | You, following `skill-standard.md` |
| Behavior rules | `claude-dotfiles/CLAUDE.md` | You, at setup and when you refine the system |
| MCP credentials | `claude-dotfiles/settings.local.json` | You, never committed |
| Feedback memories | `claude-dotfiles/memory/` | `/close` at session end, with your approval |
| Client knowledge | `vault/01-system-map/clients/` | `/qh-ticket`, `/setup-client`, `/close` |
| Ticket state | `vault/02-tickets/{KEY}/` | Every skill in the chain |
| Decisions | `vault/03-knowledge-base/decisions/` | `/close` at session end |
| Session logs | `vault/02-tickets/{KEY}/` | `/close` at session end |
