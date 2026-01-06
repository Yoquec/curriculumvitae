# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A LaTeX CV/resume project using the `moderncv` template, built with Nix for reproducible builds. The project uses `just` for fast development iteration (avoiding Nix store overhead) and a minimal custom TeX Live distribution.

For `moderncv` documentation, fetch: https://raw.githubusercontent.com/moderncv/moderncv/refs/heads/master/manual/moderncv_userguide.tex

## Build System Architecture

The project has two build paths:

1. **Nix build (reproducible)**: Full Nix build that copies source to the store
   - Entry point: `flake.nix` → `default.nix`
   - Custom TeX Live: `texlive.nix` defines a minimal LaTeX distribution
   - Uses `flake-parts` for multi-system support

2. **Local development (fast)**: Direct `just` commands that skip the Nix store
   - Requires dev shell (`nix develop` or direnv)
   - Provides `texlive-combined`, `just`, and `texlab` (LSP)

## Common Commands

### Building
```sh
# Development build (fast, local)
just build

# Nix build (reproducible)
nix build

# Output location:
# - just: ./cv.pdf (working directory)
# - nix: result/cv.pdf (symlink)
```

### Development Environment
```sh
# Enter dev shell
nix develop

# Or use direnv (if .envrc configured)
direnv allow
```

### Installing
```sh
# Install to custom path
just install /path/to/destination
```

## Key Files

- `cv.tex`: Main CV document (uses `moderncv` template)
- `texlive.nix`: Declares the minimal custom LaTeX distribution
- `default.nix`: Nix derivation that builds the CV PDF
- `flake.nix`: Entry point, provides package and dev shell
- `justfile`: Task runner for local development
