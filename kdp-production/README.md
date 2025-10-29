# KDP Production Workflow

## Overview

This directory contains all the resources and instructions for producing a **Kindle Direct Publishing (KDP)-ready eBook** from the Tales From The Crypto manuscript. The workflow is designed to be iterative, allowing contributors and artists to continuously improve content through multiple publishing cycles.

---

## Table of Contents

1. [KDP Formatting Guidelines](#kdp-formatting-guidelines)
2. [Manuscript Preparation](#manuscript-preparation)
3. [Illustration Integration](#illustration-integration)
4. [Automated eBook Generation](#automated-ebook-generation)
5. [KDP Upload Process](#kdp-upload-process)
6. [Iterative Improvement Cycle](#iterative-improvement-cycle)

---

## 1. KDP Formatting Guidelines

### eBook Requirements

- **Format**: EPUB 3.0 or MOBI
- **File Size**: Maximum 650 MB (recommended under 50 MB)
- **Images**: JPEG or PNG, RGB color mode
- **Resolution**: 300 DPI for print-quality illustrations
- **Cover**: Minimum 1000px on shortest side, ideal 2560x1600px

### Markdown Structure

All chapter files in `/chapters` should follow this structure:

```markdown
# Chapter Title

![Illustration Placeholder](../illustrations/chapter-image.png)

## Section Header

*Content goes here*

![Illustration Placeholder](../illustrations/section-image.png)
```

### Typography Guidelines

- Use `#` for chapter titles
- Use `##` for major sections
- Use `###` for subsections
- Use `*italics*` for emphasis
- Use `**bold**` for strong emphasis

---

## 2. Manuscript Preparation

### Chapter Organization

All chapters are stored in `/chapters` directory:

- **Episodes**: `Episode-N-Title.md`
- **Scenarios**: `Scenario-Title.md`
- **Architecture**: `Core-Architecture-Topic.md`

### Content Guidelines

1. **Clear Headers**: Each chapter needs descriptive section headers
2. **Image Placeholders**: Mark where illustrations should be inserted
3. **Consistent Voice**: Maintain narrative tone across chapters
4. **Technical Accuracy**: Verify blockchain concepts are correct

### Quality Checklist

- [ ] Spelling and grammar checked
- [ ] Technical terms explained on first use
- [ ] Smooth transitions between sections
- [ ] Image placeholders positioned correctly
- [ ] Chapter length appropriate (2000-5000 words recommended)

---

## 3. Illustration Integration

### Illustration Directory Structure

```
illustrations/
├── episode-1-opening.png
├── episode-1-network-awakens.png
├── episode-2-opening.png
└── ...
```

### Illustration Specifications

- **Format**: PNG or JPEG
- **Resolution**: 300 DPI minimum
- **Dimensions**: 1200px wide (recommended)
- **Color Mode**: RGB
- **File Naming**: Descriptive, lowercase, hyphenated

### Adding Illustrations to Chapters

1. Create illustration file in `/illustrations` directory
2. Update placeholder in corresponding chapter markdown:
   ```markdown
   ![Scene Description](../illustrations/your-image.png)
   ```
3. Include alt text for accessibility
4. Ensure file paths are correct relative to chapter location

### Artist Workflow

1. Review chapter content and placeholder locations
2. Create illustrations matching narrative tone
3. Save files with appropriate names in `/illustrations`
4. Update markdown files with actual filenames
5. Test local preview to verify image loading
6. Commit changes to repository

---

## 4. Automated eBook Generation

### The convert-ebook.sh Script

The automation script in the repository root combines all chapters into a single KDP-ready EPUB file.

### Prerequisites

```bash
# Install Pandoc
sudo apt-get install pandoc  # Debian/Ubuntu
brew install pandoc          # macOS

# Install calibre (for ebook-convert)
sudo apt-get install calibre # Debian/Ubuntu
brew install calibre         # macOS
```

### Running the Script

```bash
# From repository root
chmod +x convert-ebook.sh
./convert-ebook.sh
```

### What the Script Does

1. Reads all chapter files from `/chapters` in order
2. Combines chapters into single markdown document
3. Processes image references
4. Generates EPUB file with metadata
5. Creates KDP-compliant eBook structure
6. Outputs: `Tales-From-The-Crypto.epub`

### Script Options

```bash
# Generate EPUB only
./convert-ebook.sh --epub

# Generate MOBI for Kindle
./convert-ebook.sh --mobi

# Generate both formats
./convert-ebook.sh --all

# Verbose output
./convert-ebook.sh --verbose
```

---

## 5. KDP Upload Process

### Step-by-Step Upload Guide

#### 1. Prepare Your Files

- [ ] Generated EPUB file
- [ ] Cover image (2560x1600px recommended)
- [ ] Book metadata (title, description, keywords)

#### 2. Login to KDP

- Navigate to [kdp.amazon.com](https://kdp.amazon.com)
- Sign in with your Amazon account

#### 3. Create New Title

- Click "+ Create" → "eBook"
- Enter book details:
  - Title: "Tales From The Crypto"
  - Subtitle: (if applicable)
  - Author name
  - Description (compelling, keyword-rich)
  - Keywords (7 max, blockchain-related)
  - Categories (Fiction > Science Fiction, Technology)

#### 4. Upload Content

- **Manuscript**: Upload `Tales-From-The-Crypto.epub`
- **Cover**: Upload cover image
- **Preview**: Use KDP Previewer to check formatting

#### 5. Pricing & Rights

- Select territories for rights
- Choose pricing (suggest $2.99-$9.99 for 70% royalty)
- Set promotional pricing if desired

#### 6. Publish

- Review all details
- Click "Publish Your Kindle eBook"
- Wait 24-72 hours for review and publication

---

## 6. Iterative Improvement Cycle

### The KDP Iteration Loop

This workflow is designed for continuous improvement:

```
┌─────────────────────────────────────┐
│  1. Write/Update Chapter Content   │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  2. Create/Update Illustrations     │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  3. Run convert-ebook.sh Script     │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  4. Review Generated EPUB           │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  5. Upload to KDP (New/Update)      │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  6. Gather Feedback & Analytics     │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  7. Make Improvements & Iterate ←───┘
└─────────────────────────────────────┘
```

### Version Control Strategy

1. **Git Tags for Versions**
   ```bash
   git tag -a v1.0 -m "First KDP publication"
   git push origin v1.0
   ```

2. **Branch Strategy**
   - `main`: Published versions
   - `dev`: Work in progress
   - `illustrations`: Artist branch

3. **Commit Messages**
   ```
   [CHAPTER] Updated Episode 2 with feedback
   [ILLUST] Added new blockchain diagram
   [KDP] Generated v1.1 for republication
   ```

### Improvement Checklist

Before each new iteration:

- [ ] Reader feedback incorporated
- [ ] Typos and errors corrected
- [ ] New illustrations added
- [ ] Enhanced explanations for complex topics
- [ ] Updated statistics or examples
- [ ] Improved chapter flow
- [ ] Refreshed metadata and keywords

### Analytics to Track

- **Sales**: Units sold per month
- **KDP Reads**: Pages read (KU/KOLL)
- **Reviews**: Star ratings and feedback
- **Conversion**: Preview-to-purchase ratio

### When to Update

Consider republishing when:

- Major content improvements made (20%+ changed)
- New chapters added
- Significant illustration updates
- Reader feedback addresses critical issues
- Quarterly refresh for SEO and visibility

---

## Quick Reference Commands

```bash
# Generate eBook
./convert-ebook.sh

# Add new chapter
cp chapters/template.md chapters/Episode-N-Title.md

# Commit changes
git add .
git commit -m "[KDP] Updated chapters for v1.1"
git push

# Create version tag
git tag -a v1.1 -m "KDP Update - Enhanced illustrations"
git push origin v1.1
```

---

## Support and Resources

### KDP Resources

- [KDP Help Center](https://kdp.amazon.com/en_US/help)
- [KDP Community Forums](https://kdp.amazon.com/en_US/community)
- [Kindle Create Tool](https://www.amazon.com/Kindle-Create/b?node=18292298011)

### Pandoc Documentation

- [Pandoc User Guide](https://pandoc.org/MANUAL.html)
- [EPUB Specifications](http://idpf.org/epub/30)

### Markdown Resources

- [Markdown Guide](https://www.markdownguide.org/)
- [GitHub Flavored Markdown](https://github.github.com/gfm/)

---

## Contributing

See main repository README.md for contributor guidelines and the complete KDP Iteration workflow.

---

**Last Updated**: 2025-10-29  
**Version**: 1.0  
**Maintainer**: Tales From The Crypto Project Team
