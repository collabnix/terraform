# Installing Terraform on Windows

A binary distribution is avaialble for all environments. Let's grab the latest version of it for windows.

Open up a powershell on your windows machine, cd to a directroy to D drive and create an Terraform directory,

```
PS C:\Users\user>D:
```

Get an exe from the below url, 

```
PS D:\> curl.exe -O https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_windows_amd64.zip
```

Then unzip this archieve, rename a directory to terraform and we will see a single binary file name `terraform` and add it's path into environment variables.

```
PS D:\Terraform> Expand-Archive terraform_0.12.26_windows_amd64.zip
PS D:\> Rename-Item -path .\terraform_0.12.26_windows_amd64\ .\terraform
```

Regarding setting up an environment variable, you can add terraform path in `Path` variable as shown in below screenshot,

![](/images/terraformenv.JPG)

And, your are done. Now open up a terminal and run a command terrform and enter

```
PS D:\terraform> terraform

```

## Verify the installation

Verify that the installation worked by opening a new powershell or cmd session and listing Terraform's available subcommands.

```
PS D:\terraform> terraform -help
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
PS D:\terraform> terraform -help plan
```

## Troubleshoot

If you get an error that terraform could not be found, your PATH environment variable was not set up properly. Please go back and ensure that your Path variable contains the directory where Terraform was installed.

