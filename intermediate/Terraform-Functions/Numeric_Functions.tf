#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#*    Terraform Functions - Numeric Functions                     *#
#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#


#--------------------------------------------------------------------------------------------------------------------
# abs()
# returns the absolute value of the given number. In other words, if the number is zero or positive then it is returned as-is, but if it is negative then it is multiplied by -1 to make it positive before returning it.
# Syntax: abs(number)
#--------------------------------------------------------------------------------------------------------------------


output "abs-output" {
    description     =   "Print the output of abs function"
    value           =   {
        "positive"   =   abs(13)
        "zero"       =   abs(0)
        "negative"   =   abs(-482)
        "float"      =   abs(-13.25)
    }
}

# Interesting Observation: if you uncomment the below output, Terraform will crash because it cant serialize infinity(1/0) as Json.

// output "tf-crash" {
//     value = abs(1/0)
//  }


#--------------------------------------------------------------------------------------------------------------------
# ceil()
# Returns the closest whole number that is greater than or equal to the given value, which may be a fraction.
# Syntax: ceil(number)
#--------------------------------------------------------------------------------------------------------------------


output "ceil-output" {
    description     =   "Print the output of ceil function"
    value           =   {
        "op1"       =   ceil(13)
        "op2"       =   ceil(13.0)
        "op3"       =   ceil(13.1)
        "op4"       =   ceil(13.99999)
    }
}


#--------------------------------------------------------------------------------------------------------------------
# floor()
# Returns the closest whole number that is less than or equal to the given value, which may be a fraction.
# Syntax: floor(number)
#--------------------------------------------------------------------------------------------------------------------


output "floor-output" {
    description     =   "Print the output of floor function"
    value           =   {
        "op1"       =   floor(13)
        "op2"       =   floor(13.0)
        "op3"       =   floor(13.1)
        "op4"       =   floor(13.99999)
    }
}


#--------------------------------------------------------------------------------------------------------------------
# log()
# Returns the logarithm of a given number in a given base.
# Syntax: log(number, base)
#--------------------------------------------------------------------------------------------------------------------


output "log-output" {
    description     =   "Print the output of log function"
    value           =   {
        "op1"       =   log(10,2)
        "op2"       =   log(16,4)
    }
}

#--------------------------------------------------------------------------------------------------------------------
# max()
# Takes one or more numbers and returns the greatest number from the set.
# Syntax: max(number1, number2, ...)
#--------------------------------------------------------------------------------------------------------------------


output "max-output" {
    description     =   "Print the output of max function"
    value           =   max(13, 25, 0, 1325, 482, 27, 19)
}


#--------------------------------------------------------------------------------------------------------------------
# min()
# Takes one or more numbers and returns the smallest number from the set.
# Syntax: min(number1, number2, ...)
#--------------------------------------------------------------------------------------------------------------------


output "min-output" {
    description     =   "Print the output of min function"
    value           =   min(13, 25, 1325, 482, 27, 19)
}

#--------------------------------------------------------------------------------------------------------------------
# pow()
# Calculates an exponent, by raising its first argument to the power of the second argument.
# Syntax: pow(number1, number2)
#--------------------------------------------------------------------------------------------------------------------


output "pow-output" {
    description     =   "Print the output of pow function"
    value           =   {
        "op1"       =   pow(13,2)
        "op2"       =   pow(5,0)
        "op3"       =   pow(0,5)
        "op4"       =   pow(0,0)
    }
}

#--------------------------------------------------------------------------------------------------------------------
# signum()
# Determines the sign of a number, returning a number between -1 and 1 to represent the sign.
# Syntax: signum(number)
#--------------------------------------------------------------------------------------------------------------------


output "signum-output" {
    description     =   "Print the output of signum function"
    value           =   {
        "op1"       =   signum(0)
        "op2"       =   signum(13)
        "op3"       =   signum(-13)
    }
}