# Installing Terraform on MacOS

Homebrew is a free and open-source package management system for Mac OS X. Install the Terraform formula from the terminal.

```
$ brew install terraform
```

NOTE: Homebrew and the Terraform formula are NOT directly maintained by HashiCorp. The latest version of Terraform is always available by manual installation.

## Verify the installation

Verify that the installation worked by opening a new terminal session and listing Terraform's available subcommands.

```
$ terraform -help
```

```
Usage: terraform [-version] [-help] <command> [args]
```

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.
##...

Add any subcommand to terraform -help to learn more about what it does and available options.

```
$ terraform -help plan
```

## Troubleshoot

If you get an error that terraform could not be found, your PATH environment variable was not set up properly. Please go back and ensure that your PATH variable contains the directory where Terraform was installed.

## Enable tab completion

If you use either bash or zsh you can enable tab completion for Terraform commands. To enable autocomplete, run the following command and then restart your shell.

```
$ terraform -install-autocomplete
```
