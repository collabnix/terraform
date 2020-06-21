#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#
#*  Terraform Functions - File System Functions  *#
#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#

#--------------------------------------------------------------------------------------------------------------------
# abspath()
# Takes a string containing a filesystem path and converts it to an absolute path. 
# That is, if the path is not absolute, it will be joined with the current working directory.
# Syntax: abspath()
#--------------------------------------------------------------------------------------------------------------------

output "abspath-output" {
    description     =   "Print the output of abspath function"
    value           =   abspath(path.root)
}


#--------------------------------------------------------------------------------------------------------------------
# file()
# Reads the contents of a file at the given path and returns them as a string.
# Syntax: file(path)
#--------------------------------------------------------------------------------------------------------------------

output "file-output" {
    description     =   "Print the output of file function"
    value           =   file("./file1.txt")
}


#--------------------------------------------------------------------------------------------------------------------
# fileexits()
# Determines whether a file exists at a given path.
# Syntax: fileexists(path)
#--------------------------------------------------------------------------------------------------------------------

output "fileexists-output" {
    description     =   "Print the output of fileexists function"
    value           =   {
        "Exists"        =   fileexists("./file1.txt")
        "Doesnt_Exist"  =   fileexists("./nofile.txt")
    }
}

#--------------------------------------------------------------------------------------------------------------------
# pathexpand()
# Takes a filesystem path that might begin with a ~ segment, and if so it replaces that segment with the current user's home directory path.
# Syntax: pathexpand(filenamewithpath)
# More info at https://www.terraform.io/docs/configuration/functions/pathexpand.html
#--------------------------------------------------------------------------------------------------------------------

output "pathexpand-output" {
    description     =   "Print the output of pathexpand function"
    value           =   pathexpand("~/file1.txt")
}

#--------------------------------------------------------------------------------------------------------------------
# templatefile()
# Reads the file at the given path and renders its content as a template using a supplied set of template variables.
# Syntax: templatefile(path, vars)
# More info at https://www.terraform.io/docs/configuration/functions/templatefile.html
#--------------------------------------------------------------------------------------------------------------------

output "templatefile-output" {
    description     =   "Print the output of templatefile function"
    value           =   templatefile("./output.tmpl", {ip_address = "10.0.10.0", port = 443})
}