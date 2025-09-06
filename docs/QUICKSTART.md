# Quickstart

Get up and running with the documentation framework in under 5 minutes.

## Prerequisites

- Git
- Text editor
- Terminal/command line access

## Installation

### Option 1: One-line remote setup (recommended)

```bash
# In your project directory
curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate | bash
```

### Option 2: Manual setup

1. Download the generator:

   ```bash
   curl -sSL https://raw.githubusercontent.com/mitchellfyi/documentation/main/generate -o generate
   chmod +x generate
   ```

2. Run the interactive setup:

   ```bash
   ./generate
   ```

3. Follow the prompts to create your `docs/context.yaml`

## What you get

- ✅ **README.md** - Professional, demo-first documentation
- ✅ **docs/context.yaml** - Machine-readable project metadata
- ✅ **docs/ structure** - Standard documentation scaffold
- ✅ **Clear next steps** - Guidance for customisation

## Next steps

1. **Customise your README** - Replace `[placeholder]` text with project-specific details
2. **Add content to docs/** - Fill in the documentation scaffold files
3. **Add a LICENSE** - Choose an appropriate licence for your project
4. **Set up quality gates** - Add linting and formatting (see [CONFIGURATION.md](CONFIGURATION.md))

## Getting help

- Check [USAGE.md](USAGE.md) for detailed examples
- Review [INSTALL.md](INSTALL.md) for installation options
- Open an issue on GitHub for support

## Quick validation

Verify your setup works:

```bash
# Check that README was generated
ls -la README.md

# Verify docs structure exists
ls -la docs/

# Look for remaining placeholders to customise
grep -r "\[.*\]" README.md
```

You should see a clean README.md and a docs/ directory with your context.yaml file.
