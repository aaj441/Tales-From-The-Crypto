#!/bin/bash

################################################################################
# Tales From The Crypto - KDP eBook Automation Script
# 
# This script automates the conversion of markdown chapters into a 
# KDP-ready EPUB eBook using Pandoc.
#
# Usage: ./convert-ebook.sh [OPTIONS]
# Options:
#   --epub     Generate EPUB only (default)
#   --mobi     Generate MOBI for Kindle
#   --all      Generate both EPUB and MOBI
#   --verbose  Show detailed output
#   --help     Show this help message
################################################################################

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default configuration
GENERATE_EPUB=true
GENERATE_MOBI=false
VERBOSE=false

# Project metadata
TITLE="Tales From The Crypto"
SUBTITLE="A Blockchain Narrative"
AUTHOR="Tales From The Crypto Project"
PUBLISHER="Independent"
LANGUAGE="en-US"
COVER_IMAGE="cover.png"
OUTPUT_EPUB="Tales-From-The-Crypto.epub"
OUTPUT_MOBI="Tales-From-The-Crypto.mobi"

# Directories
CHAPTERS_DIR="chapters"
OUTPUT_DIR="output"
TEMP_DIR="temp_build"

################################################################################
# Helper Functions
################################################################################

print_header() {
    echo -e "${BLUE}"
    echo "═══════════════════════════════════════════════════════════════"
    echo "  Tales From The Crypto - KDP eBook Generator"
    echo "═══════════════════════════════════════════════════════════════"
    echo -e "${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ ERROR: $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

print_step() {
    echo -e "${BLUE}▶ $1${NC}"
}

show_help() {
    cat << EOF
Usage: ./convert-ebook.sh [OPTIONS]

Options:
  --epub      Generate EPUB only (default)
  --mobi      Generate MOBI for Kindle  
  --all       Generate both EPUB and MOBI
  --verbose   Show detailed output
  --help      Show this help message

Examples:
  ./convert-ebook.sh              # Generate EPUB
  ./convert-ebook.sh --all        # Generate both formats
  ./convert-ebook.sh --verbose    # Show detailed output

EOF
    exit 0
}

################################################################################
# Parse Command Line Arguments
################################################################################

while [[ $# -gt 0 ]]; do
    case $1 in
        --epub)
            GENERATE_EPUB=true
            GENERATE_MOBI=false
            shift
            ;;
        --mobi)
            GENERATE_EPUB=false
            GENERATE_MOBI=true
            shift
            ;;
        --all)
            GENERATE_EPUB=true
            GENERATE_MOBI=true
            shift
            ;;
        --verbose)
            VERBOSE=true
            shift
            ;;
        --help|-h)
            show_help
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            ;;
    esac
done

################################################################################
# Check Prerequisites
################################################################################

check_dependencies() {
    print_step "Checking dependencies..."
    
    if ! command -v pandoc &> /dev/null; then
        print_error "Pandoc is not installed"
        echo "  Install with: sudo apt-get install pandoc (Linux) or brew install pandoc (macOS)"
        exit 1
    fi
    print_success "Pandoc found: $(pandoc --version | head -n1)"
    
    if [[ $GENERATE_MOBI == true ]]; then
        if ! command -v ebook-convert &> /dev/null; then
            print_error "Calibre (ebook-convert) is not installed"
            echo "  Install with: sudo apt-get install calibre (Linux) or brew install calibre (macOS)"
            exit 1
        fi
        print_success "Calibre found"
    fi
}

################################################################################
# Setup Directories
################################################################################

setup_directories() {
    print_step "Setting up directories..."
    
    # Create output directory
    mkdir -p "$OUTPUT_DIR"
    print_success "Output directory ready: $OUTPUT_DIR"
    
    # Create temp directory
    rm -rf "$TEMP_DIR"
    mkdir -p "$TEMP_DIR"
    print_success "Temporary build directory created"
}

################################################################################
# Collect Chapter Files
################################################################################

collect_chapters() {
    print_step "Collecting chapter files..."
    
    if [[ ! -d "$CHAPTERS_DIR" ]]; then
        print_error "Chapters directory not found: $CHAPTERS_DIR"
        exit 1
    fi
    
    # Find all markdown files in chapters directory
    CHAPTER_FILES=($(find "$CHAPTERS_DIR" -name "*.md" | sort))
    
    if [[ ${#CHAPTER_FILES[@]} -eq 0 ]]; then
        print_error "No chapter files found in $CHAPTERS_DIR"
        exit 1
    fi
    
    print_success "Found ${#CHAPTER_FILES[@]} chapter files:"
    for file in "${CHAPTER_FILES[@]}"; do
        echo "    - $(basename "$file")"
    done
}

################################################################################
# Combine Chapters
################################################################################

combine_chapters() {
    print_step "Combining chapters into single manuscript..."
    
    COMBINED_FILE="$TEMP_DIR/manuscript.md"
    
    # Add title page
    cat > "$COMBINED_FILE" << EOF
---
title: "$TITLE"
subtitle: "$SUBTITLE"
author: "$AUTHOR"
publisher: "$PUBLISHER"
lang: "$LANGUAGE"
rights: "© $(date +%Y) $AUTHOR. All rights reserved."
---

# $TITLE

## $SUBTITLE

By $AUTHOR

---

EOF
    
    # Append each chapter
    for file in "${CHAPTER_FILES[@]}"; do
        if [[ $VERBOSE == true ]]; then
            print_info "Adding: $(basename "$file")"
        fi
        echo "" >> "$COMBINED_FILE"
        cat "$file" >> "$COMBINED_FILE"
        echo "" >> "$COMBINED_FILE"
        echo "---" >> "$COMBINED_FILE"
        echo "" >> "$COMBINED_FILE"
    done
    
    print_success "Chapters combined: $COMBINED_FILE"
}

################################################################################
# Create Metadata File
################################################################################

create_metadata() {
    print_step "Creating metadata file..."
    
    METADATA_FILE="$TEMP_DIR/metadata.yaml"
    
    cat > "$METADATA_FILE" << EOF
---
title: "$TITLE"
subtitle: "$SUBTITLE" 
author: "$AUTHOR"
publisher: "$PUBLISHER"
lang: "$LANGUAGE"
date: "$(date +%Y-%m-%d)"
rights: "© $(date +%Y) $AUTHOR. All rights reserved."
keywords:
  - blockchain
  - cryptocurrency
  - fiction
  - technology
  - narrative
  - bitcoin
  - decentralization
description: |
  Tales From The Crypto is a narrative exploration of blockchain technology,
  told through engaging episodes, scenarios, and architectural deep-dives.
  Perfect for readers who want to understand cryptocurrency and blockchain
  through storytelling.
---
EOF
    
    print_success "Metadata created"
}

################################################################################
# Generate EPUB
################################################################################

generate_epub() {
    print_step "Generating EPUB file..."
    
    EPUB_PATH="$OUTPUT_DIR/$OUTPUT_EPUB"
    
    # Pandoc command with options
    PANDOC_CMD="pandoc \
        --from markdown \
        --to epub3 \
        --output \"$EPUB_PATH\" \
        --metadata-file=\"$TEMP_DIR/metadata.yaml\" \
        --toc \
        --toc-depth=2 \
        --epub-chapter-level=1"
    
    # Add cover if exists
    if [[ -f "$COVER_IMAGE" ]]; then
        PANDOC_CMD="$PANDOC_CMD --epub-cover-image=\"$COVER_IMAGE\""
        print_info "Cover image included: $COVER_IMAGE"
    fi
    
    PANDOC_CMD="$PANDOC_CMD \"$TEMP_DIR/manuscript.md\""
    
    if [[ $VERBOSE == true ]]; then
        print_info "Running: $PANDOC_CMD"
    fi
    
    # Execute pandoc
    eval $PANDOC_CMD
    
    if [[ -f "$EPUB_PATH" ]]; then
        FILE_SIZE=$(du -h "$EPUB_PATH" | cut -f1)
        print_success "EPUB generated successfully: $EPUB_PATH ($FILE_SIZE)"
    else
        print_error "EPUB generation failed"
        exit 1
    fi
}

################################################################################
# Generate MOBI
################################################################################

generate_mobi() {
    print_step "Generating MOBI file for Kindle..."
    
    EPUB_PATH="$OUTPUT_DIR/$OUTPUT_EPUB"
    MOBI_PATH="$OUTPUT_DIR/$OUTPUT_MOBI"
    
    if [[ ! -f "$EPUB_PATH" ]]; then
        print_error "EPUB file not found. Generate EPUB first."
        exit 1
    fi
    
    # Convert EPUB to MOBI using Calibre
    ebook-convert "$EPUB_PATH" "$MOBI_PATH" \
        --title "$TITLE" \
        --authors "$AUTHOR" \
        --publisher "$PUBLISHER" \
        --language "$LANGUAGE" \
        --output-profile kindle
    
    if [[ -f "$MOBI_PATH" ]]; then
        FILE_SIZE=$(du -h "$MOBI_PATH" | cut -f1)
        print_success "MOBI generated successfully: $MOBI_PATH ($FILE_SIZE)"
    else
        print_error "MOBI generation failed"
        exit 1
    fi
}

################################################################################
# Cleanup
################################################################################

cleanup() {
    print_step "Cleaning up temporary files..."
    rm -rf "$TEMP_DIR"
    print_success "Cleanup complete"
}

################################################################################
# Generate Summary
################################################################################

generate_summary() {
    echo ""
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}  eBook Generation Complete!${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
    echo "Output files:"
    
    if [[ -f "$OUTPUT_DIR/$OUTPUT_EPUB" ]]; then
        echo "  📚 EPUB: $OUTPUT_DIR/$OUTPUT_EPUB"
    fi
    
    if [[ -f "$OUTPUT_DIR/$OUTPUT_MOBI" ]]; then
        echo "  📱 MOBI: $OUTPUT_DIR/$OUTPUT_MOBI"
    fi
    
    echo ""
    echo "Next steps:"
    echo "  1. Review the generated eBook file(s)"
    echo "  2. Test on e-reader devices/apps"
    echo "  3. Upload to KDP at https://kdp.amazon.com"
    echo "  4. See kdp-production/README.md for detailed KDP instructions"
    echo ""
}

################################################################################
# Main Execution
################################################################################

main() {
    print_header
    
    check_dependencies
    setup_directories
    collect_chapters
    combine_chapters
    create_metadata
    
    if [[ $GENERATE_EPUB == true ]]; then
        generate_epub
    fi
    
    if [[ $GENERATE_MOBI == true ]]; then
        generate_mobi
    fi
    
    cleanup
    generate_summary
}

# Run main function
main
