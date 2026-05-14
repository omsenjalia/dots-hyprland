# AI Agent Documentation Guide

This document helps AI agents understand and navigate the dots-hyprland documentation system accurately.

## 📁 Documentation Structure

```
/docs
├── /src
│   └── /content
│       └── /docs
│           ├── /ai-agents          # AI-specific documentation
│           │   ├── /changelog      # Auto-generated changelog entries
│           │   ├── /weekly-summaries # Weekly commit summaries (generated weekly)
│           │   ├── 00-overview.md  # Start here - how AI agents should navigate
│           │   ├── 01-architecture.md # Component relationships
│           │   ├── 02-workflow.md  # Development workflows
│           │   ├── 03-update-docs.md # How to keep documentation in sync
│           │   └── ...             # Other AI agent guides
│           ├── /guide              # End-user documentation
│           │   ├── 01-overview.md
│           │   ├── 02-install.md
│           │   ├── 03-usage.md
│           │   ├── 04-configuration.md
│           │   └── 05-troubleshooting.md
│           └── /custom             # User-provided documentation (auto-synced)
├── assets                          # Images, logos, icons
├── scripts                         # Documentation synchronization scripts
├── astro.config.mjs                # Astro site configuration
├── package.json                    # Node dependencies
└── vercel.json                     # Vercel deployment configuration
```

## 🔑 Key Files for AI Agents

### 1. **Start Here**
- `docs/src/content/docs/ai-agents/00-overview.md` - Essential reading first
- `../CLAUDE.md` (in repo root) - Canonical architecture reference

### 2. **Changelog System**
- Auto-generated: `docs/src/content/docs/ai-agents/changelog/YYYY-MM-DD-<short-sha>.md`
- Weekly summaries: `docs/src/content/docs/ai-agents/weekly-summaries/<month>-week-<num>.md`
- **Always check these before starting work** to understand recent changes

### 3. **Documentation Update Rules**
See `docs/src/content/docs/ai-agents/03-update-docs.md` for complete details:
- After any code change, update relevant guide page
- Fill in AI Agent Notes section of matching changelog entry
- Weekly summaries help track what needs documentation

### 4. **GitHub Workflows**
- `.github/workflows/docs-changelog.yml` - Generates changelog entries on push
- `.github/workflows/weekly-summary.yml` - Creates weekly commit summaries every Sunday
- `.github/workflows/docs-deploy.yml` - Deploys to Vercel (if exists)

## 🤖 How to Use This Documentation

### Before Making Changes:
1. **Check CLAUDE.md** for architectural guidelines
2. **Review recent changelog entries** in `/ai-agents/changelog/`
3. **Check weekly summary** for the current week in `/ai-agents/weekly-summaries/`
4. **Understand the workflow** in `/ai-agents/02-workflow.md`

### After Making Changes:
1. **Update the relevant guide page** (see table in 03-update-docs.md)
2. **Fill in AI Agent Notes** in the auto-generated changelog entry
3. **Verify documentation builds**: `cd docs && npm run dev`

## 🔍 Finding Specific Information

### By Topic:
- **Keybinds**: `guide/03-usage.md` (keybind tables)
- **Autostart apps**: `guide/04-configuration.md` (execs section)
- **Install dependencies**: `guide/02-install.md` (packages section)
- **Quickshell services**: `ai-agents/01-architecture.md` (services table)
- **Config options**: `guide/04-configuration.md`
- **Troubleshooting**: `guide/05-troubleshooting.md`

### By File Type:
- **Markdown content**: `/src/content/docs/`
- **Configuration**: `astro.config.mjs`, `vercel.json`, `package.json`
- **Styles**: `/src/styles/custom.css`
- **Scripts**: `/scripts/` (for documentation syncing)
- **Assets**: `/assets/` (images, icons, logos)

## 📚 Related Resources

- **Changelog entries**: Auto-generated with file lists and commit messages
- **Weekly summaries**: Aggregate view of all commits per week
- **AI Agent Notes**: Critical context explaining WHY changes were made
- **Custom documentation**: User-provided content synced via `scripts/sync-custom-docs.mjs`

## 💡 Best Practices for AI Agents

1. **Always fill AI Agent Notes** - Explain the reasoning, not just the changes
2. **Check for existing documentation** before creating new content
3. **Use weekly summaries** to understand the broader context of changes
4. **Verify links work** when adding new documentation
5. **Keep changes minimal and focused** - one topic per PR when possible
6. **Update documentation immediately** after code changes, not later

## 🛠️ Tools & Commands

### Documentation Development:
```bash
# Start development server
cd docs
npm install
npm run dev     # http://localhost:4321

# Sync custom documentation
npm run sync    # Copies dots/custom/*.md into content/docs/custom/

# Build for production
npm run build
```

### Git Workflow:
```bash
# Before starting work
git pull
# Check changelog and weekly summaries

# After making changes
git add <your-changes>
git commit -m "descriptive message"
git push
# This triggers auto-changelog generation
```

## ❓ Need Help?

If you're unsure about:
- Where to document a change: Check the table in `03-update-docs.md`
- How the workflow works: Review `02-workflow.md`
- Repository structure: See `CLAUDE.md` in the root
- Recent changes: Look at the latest changelog entry

Remember: **Documentation is part of the code**. Treat it with the same care and attention to detail.
