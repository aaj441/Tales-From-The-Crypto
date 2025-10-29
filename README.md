# Tales from the Crypto Universe

## Overview

A vaporwave blockchain narrative universe where Pearl's neon bakery sits on a blockchain where smart contracts warp physics. Each loaf is a ledger entry; tips, memes, and votes bend reality. The town's fate is co-authored by twelve autonomous "gods" (LLM agents) whose interventions remix music, logic, time, and visuals under community control.

**Core Concept:** Tokenized reality meets kitchen noir with empathy-centered multicultural satire. Human stakes first; crypto metaphysics second.

## KDP Iteration Guide

**Automated KDP-Ready eBook Production Workflow**

This repository now includes a complete automation workflow for producing Kindle Direct Publishing (KDP)-ready eBooks from the Tales From The Crypto manuscript. The workflow is designed for iterative improvement cycles where contributors and artists can continuously enhance content through multiple publishing iterations.

### Quick Start for Contributors

#### 1. Content Creation Workflow

```bash
# Clone the repository
git clone [repository-url]
cd Tales-From-The-Crypto

# Create or edit chapter content
# All chapters are in /chapters directory
# Use clear section headers and image placeholders
vim chapters/Episode-N-Title.md

# Run the automated eBook generation
./convert-ebook.sh

# Review generated eBook
open output/Tales-From-The-Crypto.epub
```

#### 2. Chapter Structure Guidelines

All chapter files in `/chapters` should follow this template:

```markdown
# Chapter Title

![Illustration Placeholder](../illustrations/chapter-opening.png)

## Major Section Header

*Content goes here*

![Illustration Placeholder](../illustrations/section-diagram.png)

## Another Section

*More content*

![Illustration Placeholder](../illustrations/section-conclusion.png)
```

### Quick Start for Artists

#### 1. Illustration Workflow

```bash
# Create illustrations matching chapter placeholders
# Save in /illustrations directory
# Use descriptive, hyphenated filenames
# Format: PNG or JPEG, 300 DPI, 1200px wide recommended

# Update chapter files with actual image names
# Replace placeholders like:
![Illustration Placeholder](../illustrations/episode-1-opening.png)
# With actual descriptions:
![Pearl's neon bakery at night](../illustrations/episode-1-opening.png)

# Test the complete workflow
./convert-ebook.sh
```

#### 2. Asset Specifications

- **Format**: PNG or JPEG
- **Resolution**: 300 DPI minimum
- **Dimensions**: 1200px wide (recommended)
- **Color Mode**: RGB
- **File Naming**: Descriptive, lowercase, hyphenated
- **Alt Text**: Always include descriptive alt text for accessibility

### KDP Publishing Iteration Loop

The repository is designed for continuous improvement through iterative publishing cycles:

```
┌─────────────────────────────────────┐
│  1. Update Content & Illustrations  │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│  2. Run ./convert-ebook.sh Script   │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│  3. Review Generated EPUB File      │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│  4. Upload to KDP (New/Update)      │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│  5. Gather Reader Feedback          │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│  6. Make Improvements & Iterate ←──┘
└─────────────────────────────────────┘
```

### Step-by-Step KDP Instructions

#### For First-Time Publishers

1. **Generate Your eBook**
   ```bash
   ./convert-ebook.sh --all  # Creates both EPUB and MOBI
   ```

2. **Prepare for KDP**
   - Generated file: `output/Tales-From-The-Crypto.epub`
   - Create cover image (2560x1600px recommended)
   - Prepare book description and keywords

3. **Upload to KDP**
   - Go to [kdp.amazon.com](https://kdp.amazon.com)
   - Click "+ Create" → "eBook"
   - Upload manuscript and cover
   - Set pricing and publish

4. **For Updates**
   - Make content improvements
   - Re-run `./convert-ebook.sh`
   - Upload new version to existing KDP title

#### Detailed Instructions

See `/kdp-production/README.md` for comprehensive KDP formatting guidelines, illustration integration instructions, and complete publishing workflow documentation.

### Automation Features

#### The convert-ebook.sh Script Provides:

- **Automatic Chapter Assembly**: Combines all `/chapters/*.md` files in order
- **Image Processing**: Handles illustration references and paths
- **Metadata Generation**: Creates proper eBook metadata
- **Multiple Formats**: Generates EPUB and optionally MOBI
- **KDP Optimization**: Output formatted for Kindle Direct Publishing
- **Error Checking**: Validates dependencies and file structure

#### Script Options:

```bash
./convert-ebook.sh           # Generate EPUB (default)
./convert-ebook.sh --mobi    # Generate MOBI for Kindle
./convert-ebook.sh --all     # Generate both formats
./convert-ebook.sh --verbose # Show detailed output
```

### Version Control Strategy

#### Git Workflow for Iterations

```bash
# Tag versions for each KDP publication
git tag -a v1.0 -m "First KDP publication"
git push origin v1.0

# Use branches for different types of work
git checkout -b content-updates    # For text changes
git checkout -b illustrations      # For artist work
git checkout -b kdp-v1.1          # For next publication

# Commit with clear messages
git commit -m "[CHAPTER] Enhanced Episode 2 dialogue"
git commit -m "[ILLUST] Added blockchain diagram to Chapter 3"
git commit -m "[KDP] Generated v1.1 for republication"
```

### Future Upgrades & Extensions

The automation system is designed to support:

- **Multi-language Editions**: Easy localization workflow
- **Interactive Elements**: Enhanced EPUB3 features
- **Print Editions**: PDF generation for print-on-demand
- **Audiobook Integration**: Text-to-speech preparation
- **Marketing Materials**: Automated excerpt generation
- **Analytics Integration**: Sales and engagement tracking

### Contributing to the KDP Workflow

We welcome contributions to improve the automation process:

- **Script Enhancements**: Improve the bash automation
- **Template Updates**: Better chapter templates
- **Documentation**: Clearer instructions
- **Quality Assurance**: Testing and validation tools
- **Integration**: Connect with other publishing platforms

### Support & Troubleshooting

#### Common Issues:

- **Missing Dependencies**: Install Pandoc and Calibre
- **Image Path Errors**: Check illustration file names
- **Format Problems**: Validate Markdown syntax
- **KDP Rejection**: Review formatting guidelines

#### Getting Help:

- Check `/kdp-production/README.md` for detailed instructions
- Review script output with `--verbose` flag
- Submit issues on GitHub for technical problems
- Join Discord for community support

---

## Integration Strategy

### Community Engagement Mechanics

- **Discord Voting**: Real-time community polls that influence narrative direction
- **Tip-to-Canon**: QR tip bucket integration that triggers story transformations
- **Meme Inputs**: #MintMyMeme contests where winners become menu items and visuals
- **ARG QR Trail**: Physical stickers unlock AR recipes, secret roles, and episode branches
- **Accessibility First**: Alt text for AR, flicker-safe visuals, content warnings, opt-in consent gates

### Core Rules of Reality

1. **Tokenized Reality**: Food, memories, emotions can be minted with explicit and auditable consent
2. **Smart Contract Consequences**: Gas drains vitality; bugs manifest physically; burns scar AR-space
3. **Metaverse Bleed**: DAOs run civic life; Discord drama changes traffic and prices; AR UI overlays all
4. **Algorithmic Fate**: Oracle predictions bias outcomes; prior transactions haunt the present
5. **Multicultural Satire**: Folklore and cryptoverse remix with empathy-centered approach

## Narrative Engine Architecture

### The Twelve Gods System

| God | Function | Devil's-Advocate Twist | Output Contract |
|-----|----------|----------------------|------------------|
| **Storyteller** | Narrative architect | Inserts paradoxes | Episode beats (10), holes (3), forks (3) |
| **Muse** | Musical/tonal engine | Deliberate dissonance | Motifs keyed to variables |
| **Architect** | Rules/invariants | Introduces fixable bugs | Inputs→effects, patch/exploit/tests |
| **Mythmaker** | Folklore legend | Recursive, self-disproving | Recursive legends/versioning |
| **Trickster** | Bounded chaos | Random guardrails | RNG twists |
| **Sage** | Aphorism generator | Contradictory koans | Paired koans |
| **Chronos** | Non-linear time | Reordered beats | Timestamp tags |
| **Spatialis** | AR spatial staging | Location swaps | Coordinates, room-scale cues |
| **Connector** | Community polls/threads | Cross-episode links | Poll configs, role grants |
| **Alchemist** | Transformation rules | Mutation side effects | Mutation grammar |
| **Oracle/Emergence** | Probabilistic future | Self-fulfilling predictions | Forecasts with confidence bands |
| **Glitchweaver** | Visual/UI distortion | Accessibility and chaos | LUTs, AR layers, alt data |

### Key Locations

- **Pearl's Bakery**: QR menus, neon oven error logs
- **Jayz's Discord HQ**: Meme-lit basement
- **Sofia's Startup**: EXIT SCAM loop
- **Faisal's Restaurant**: Altcoin roulette
- **Doug's Garage**: Miner-bunker

### Episode Framework

| # | Title | Summary |
|---|-------|----------|
| 1 | Casserole on the Chain | Pearl's recipe NFT flips physics; gods cold-open; bakery AR goes feral |
| 2 | DAO of the Dead | Viral governance bug; votes mint zombies; bureaucracy loops satire |
| 3 | Gas Fees from Hell | Purchases drain life; prophecy receipts; musical minor chords on charge |

---

**Contact & Links:**
- **Discord:** [Join our community server]
- **Documentation:** [Extended technical docs]
- **Contributing:** See [CONTRIBUTING.md] for detailed guidelines
- **License:** [Choose appropriate open source license]

*A Perplexity × Bika.ai collaborative project*

*"Where smart contracts meet story contracts"*
