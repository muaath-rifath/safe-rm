# Safe RM - Zsh Protection Script

A simple safe `rm` command wrapper for zsh that prevents accidental deletion of your home directory.

## Overview

This script provides a safety wrapper around the `rm` command that:
- Detects when you're attempting to delete your home directory (`~`, `$HOME`, or `.` from home)
- Shows an interactive warning with Yes/No options
- Defaults to "No" (safe option) for maximum safety
- Allows navigation with arrow keys
- Supports Ctrl+C to cancel

## Quick Demo

```bash
$ rm ~
WARNING: Attempting to delete your HOME directory: /home/username
This action is potentially destructive.
Yes   No

# Use arrow keys to select, Enter to confirm
# Default is "No" - just press Enter to abort safely
```

## Installation

Copy the contents of `safe-rm-zsh.sh` and paste it at the end of your `~/.zshrc` file, then add:

```bash
alias rm=safe_rm
```

Reload your configuration: `source ~/.zshrc`

## Testing the Installation

After installation, test that it's working:

```bash
# This should show the warning (safe to test)
rm ~

# This should work normally
rm /tmp/some-file
```

## Usage

### Interactive Controls:
- **Arrow Keys**: Left/Right to select Yes/No
- **Enter**: Confirm selection (defaults to No)
- **Ctrl+C**: Cancel operation

### Protected Paths:
The script protects against deletion of:
- `$HOME` (your home directory)
- `~` (tilde expansion)
- `.` when executed from home directory
- `./` when executed from home directory

## Features

- ✅ Arrow Key Navigation
- ✅ Color Output
- ✅ Path Resolution
- ✅ Ctrl+C Handling

## Uninstalling

To remove safe-rm:

1. Edit your `~/.zshrc` file
2. Remove the safe_rm function code and `alias rm=safe_rm` line
3. Restart your shell or source the config file: `source ~/.zshrc`

## Troubleshooting

### Script not working?
1. Check that the alias is set: `alias rm`
2. Make sure you copied the entire script code correctly
3. Try sourcing your config file manually: `source ~/.zshrc`
4. Restart your shell

### Arrow keys not working?
- The functionality depends on your terminal emulator
- Make sure your terminal supports escape sequences

### Want to bypass the safety check?
Use the full path to rm: `/bin/rm` or `command rm`

## Security Notes

- Scripts only intercept attempts to delete the home directory
- All other `rm` operations pass through unchanged
- Default selection is always "No" (safe option)
- Scripts preserve all original `rm` flags and options
- Use `command rm` or `/bin/rm` to bypass if needed

## Contributing

Feel free to submit issues or pull requests to improve these scripts.


## License

These scripts are provided as-is for educational and safety purposes. Use at your own risk.
