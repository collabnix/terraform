# Installing Terraform on Linux

A binary distribution is avaialble for all environments. Let's grab the latest version of it for linux.

```
$ wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
```

Then unzip the archieve,

```
$ unzip terraform_0.12.26_linux_amd64.zip
```

Check the executable permission on the binary, if it's not executable, make it executable using the below commmand,

```
$ chmod +x terraform
```

Finally make sure that terrform is avaiable in PATH. So, let's move the binary into `/usr/local/bin` directroy,

```
$ sudo mv terraform /usr/local/bin
```

Now you are ready to run terraform commands. Open up a new termnal and run a command terraform and enter,

```
$ terraform
```

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

