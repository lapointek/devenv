# Development Environment Setup

The script automates the setup of my personal development environment on Arch Linux. It installs system utilities, development tools, and configures services.

## Features

- Automated system update
- Auto detect and skip preinstalled packages
- Installation of the Paru AUR helper
- Update of user directories and mirror list
- Package installation:
  - System utilities
  - Desktop applications
  - Development utilities
  - Fonts
  - Media application
  - Office application

## Requirements

    - Arch Linux installation
    - Git

## Installation

1. Clone this repository:

```
$ git clone https://github.com/lapointek/devenv.git

cd devenv
```

2. Run the setup script:

```
./run.sh
```

3. Follow the script prompts.

4. Reboot your system after the setup has completed.

## Acknowledgments

Thanks to https://github.com/typecraft-dev/crucible, which helped me in creating this automated script.
