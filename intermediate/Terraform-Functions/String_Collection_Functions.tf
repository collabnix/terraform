#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*    Terraform Functions - String and Collection Functions       *#
#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#


#--------------------------------------------------------------------------------------------------------------------
# lower()
# Converts all cased letters in the given string to lowercase.
# Syntax: lower(string)
#--------------------------------------------------------------------------------------------------------------------


variable "lower_var" {
    description     =   "Example of lower function in Terraform"
    type            =   string
    default         =   "COLLABNIX"
}

output "lower-output" {
    description     =   "Print the variable in lowercase"
    value           =   lower(var.lower_var)
}


#--------------------------------------------------------------------------------------------------------------------
# upper()
# Converts all cased letters in the given string to uppercase.
# Syntax: upper(string)
#--------------------------------------------------------------------------------------------------------------------

variable "upper_var" {
    description     =   "Example of upper function in Terraform"
    type            =   string
    default         =   "collabnix"
}

output "upper-output" {
    description     =   "Print the variable in uppercase"
    value           =   upper(var.upper_var)
}


#--------------------------------------------------------------------------------------------------------------------
# split() --> 
# Produces a list by dividing a given string at all occurrences of a given separator.
# Syntax: split(delimiter, string)
#--------------------------------------------------------------------------------------------------------------------

variable "split_var" {
    description     =   "Example of split function in Terraform"
    type            =   string
    default         =   "collabnix,terraform,aws,azure,gpc"
}

output "split-output" {
    description     =   "Print the output of split function"
    value           =   split(",",var.split_var)
}


#--------------------------------------------------------------------------------------------------------------------
# replace()
# Searches a given string for another given substring, and replaces each occurrence with a given replacement string.
# Syntax: replace(string, search, replace)
#--------------------------------------------------------------------------------------------------------------------

variable "replace_var" {
    description     =   "Example of replace function in Terraform"
    type            =   string
    default         =   "us-east-1"
}

output "replace-output" {
    description     =   "Print the output of replace function"
    value           =   replace(var.replace_var, "east", "west")
}


#--------------------------------------------------------------------------------------------------------------------
# substr()
# Extracts a substring from a given string by offset and length.
# Syntax: substr(string, offset, length)
#--------------------------------------------------------------------------------------------------------------------

variable "substr_var" {
    description     =   "Example of replace function in Terraform"
    type            =   string
    default         =   "collabnix"
}

output "substr-output" {
    description     =   "Print the output of replace function"
    value           =   substr(var.substr_var, 1, 3)
}


#--------------------------------------------------------------------------------------------------------------------
# concat() 
# Takes two or more lists and combines them into a single list. 
# Syntax: concat(list1,list2,list3,...)
#--------------------------------------------------------------------------------------------------------------------


variable "list1" {
    description     =   "Example of concat function in Terraform"
    type            =   list(string)
    default         =   ["collbnix","is"]
}

variable "list2" {
    description     =   "Example of concat function in Terraform"
    type            =   list(string)
    default         =   ["an","awesome","group"]
}

output "concat-output" {
    description     =   "Print the output of concat function"
    value           =   concat(var.list1,var.list2)
}


#--------------------------------------------------------------------------------------------------------------------
# distinct() 
# Takes a list and returns a new list with any duplicate elements removed. 
# Syntax: distinct(list)
#--------------------------------------------------------------------------------------------------------------------


variable "distinct_var" {
    description     =   "Example of distinct function in Terraform"
    type            =   list(string)
    default         =   ["aws","aws","azure","gcp","aws","azure","k8s"]
}

output "distinct-output" {
    description     =   "Print the output of distinct function"
    value           =   distinct(var.distinct_var)
}


#--------------------------------------------------------------------------------------------------------------------
# element() 
# Retrieves a single element from a list.
# Syntax: element(list,index)
#--------------------------------------------------------------------------------------------------------------------

variable "element_var" {
    description     =   "Example of element function in Terraform"
    type            =   list(string)
    default         =   ["collabnix", "aws", "azure", "gcp", "k8s"]
}

output "element-output" {
    description     =   "Map the index with its value"
    value           =   {
        0         =       element(var.element_var, 0)
        1         =       element(var.element_var, 1)
        2         =       element(var.element_var, 2)
        3         =       element(var.element_var, 3)
        4         =       element(var.element_var, 4)
    }
}


#--------------------------------------------------------------------------------------------------------------------
# join()
# Produces a string by concatenating together all elements of a given list of strings with the given delimiter.
# Syntax: join(delimiter,list)
#--------------------------------------------------------------------------------------------------------------------

variable "join_list" {
    description     =   "Example of join function in Terraform"
    type            =   list(string)
    default         =   ["collabnix","terraform","aws","azure","gpc"]
}

output "join-output" {
    description     =   "Print the output of join function"
    value           =   join("-", var.join_list)
}


#--------------------------------------------------------------------------------------------------------------------
# length()
# Determines the length of a given list, map, or string.
# Syntax: length(value)
#--------------------------------------------------------------------------------------------------------------------

variable "length_str" {
    description     =   "Example of length of a string"
    type            =   string
    default         =   "Collabnix"
}

variable "length_list" {
    description     =   "Example of length of a list"
    type            =   list(string)
    default         =   ["collabnix","terraform","aws","azure","gpc"]
}

variable "length_map" { 
    description     =   "Example of length of a map"
    type            =   map(string)
    default = {
        "aws"       =   1
        "azure"     =   2
        "gcp"       =   3
  }
}

variable "length_null" {
    description     =   "Example of length of a null string"
    type            =   string
    default         =   ""
}

output "length-output" {
    description     =   "Print the output of length function"
    value           =   {
        
        length-string     =   length(var.length_str)
        length-list       =   length(var.length_list)
        length-map        =   length(var.length_map)
        length-null       =   length(var.length_null)
    }
}


#--------------------------------------------------------------------------------------------------------------------
# slice()
# Extracts some consecutive elements from within a list.
# Syntax: slice(list, startindex, endindex)
#--------------------------------------------------------------------------------------------------------------------

variable "slice_var" {
    description     =   "Example of Slice function in Terraform"
    type            =   list(string)
    default         =   ["collabnix","terraform","aws","azure","gpc"]
}

output "slice-output" {
    description     =   "Print the output of Slice function"
    value           =   slice(var.slice_var, 1, 4)
}

#--------------------------------------------------------------------------------------------------------------------
# sort()
# Sorts a list in lexicographical order.
# Syntax: sort(list)
#--------------------------------------------------------------------------------------------------------------------

variable "sort_list1" {
    description     =   "Example of sort function in Terraform"
    type            =   list(string)
    default         =   ["collabnix", "terraform", "aws", "azure", "gpc"]
}

variable "sort_list2" {
    description     =   "Example of Slice function in Terraform"
    type            =   list(string)
    default         =   ["d", "a", "c", "b", ""]
}

variable "sort_list3" {
    description     =   "Example of Slice function in Terraform"
    type            =   list(number)
    default         =   [482, 13, 25, 27, 19]
}

output "sort-outputs" {
    description     =   "Print the output of sort function"
    value           =   {
        sort-list1  =   sort(var.sort_list1)
        sort_list2  =   sort(var.sort_list2)
        sort-list3  =   sort(var.sort_list3)
    }
}


#--------------------------------------------------------------------------------------------------------------------
# lookup()
# Retrieves the value of a single element from a map, given its key. 
# If the given key does not exist, a the given default value is returned instead.
# Syntax:  lookup(map, key, default)
#--------------------------------------------------------------------------------------------------------------------

variable "map1" {
    description     =   "Example of lookup function in Terraform"
    type            =   map(string)
    default         =   {
        "Aws"       =   "Best"
        "Azure"     =   "Better"
        "Gcp"       =   "Good"
    }
}

output "lookup-output" {
    description     =   "Print the output of lookup function"
    value           =   {
        Key_Exists          =   lookup(var.map1, "Azure", "Default") 
        Key_Doesnt_Exist    =   lookup(var.map1, "Oracle", "GettingBetter")
    }
}

#--------------------------------------------------------------------------------------------------------------------
# setproduct()
# setproduct function finds all of the possible combinations of elements from all of the given sets by computing the Cartesian product.
# Syntax: setproduct(sets...)
#--------------------------------------------------------------------------------------------------------------------

output "setproduct-output" {
    description     =   "Print the output of setproduct function"
    value           =   setproduct(["Aws", "Azure", "Gcp"], ["Certified"], ["Associate", "Professional"])
}


#--------------------------------------------------------------------------------------------------------------------
# zipmap()
# Constructs a map from a list of keys and a corresponding list of values.
# Both keyslist and valueslist must be of the same length. keyslist must be a list of strings, while valueslist can be a list of any type.
# Syntax: zipmap(keyslist, valueslist)
#--------------------------------------------------------------------------------------------------------------------

output "zipmap-output" {
    description     =   "Print the output of zipmap function"
    value           =   zipmap(["Aws", "Azure", "Gcp"], [1, 2, 3])
}

