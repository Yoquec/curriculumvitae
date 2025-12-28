# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
nix build         # Builds cv.pdf in result/ directory
nix develop       # Enter dev shell (provides texlive, texlab)
```

## Development Environment

Uses Nix flakes for reproducible builds. Enter the dev shell with `nix develop` (or automatically via direnv).

## Project Structure

- **flake.nix** - Defines Nix flake with custom texlive package set and dev shell
- **default.nix** - Build derivation that compiles cv.tex to PDF
- **cv.tex** - Main CV document

The build uses `pdflatex -interaction=nonstopmode` for non-interactive compilation. Output is placed in `result/cv.pdf`.
