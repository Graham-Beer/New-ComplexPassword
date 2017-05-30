# New-ComplexPassword
Script to generate a single or multiple complex passwords

This is a handy little script to create a single or multiple complex passwords. 
I found the need on a recent project to generate and pass a list of random complex passwords for many new users
to the admin team. 
 By making use of System.Web.Security.Membership class I could call the static method GeneratePassword, which takes two
integer parameters. Refering to the MSDN documentation, it explains the usage of both parameters and the output value:


*length*
*Type: System.Int32*
> The number of characters in the generated password. The length must be between 1 and 128 characters. 
numberOfNonAlphanumericCharacters
*Type: System.Int32*
> The minimum number of non-alphanumeric characters (such as @, #, !, %, &, and so on) in the generated password.
*Return Value*
> Type: System.String
*A random password of the specified length.*

To generate a single password simple pass the password length and number of special characters required:
```New-ComplexPassword -PasswordLength 8 -SpecialCharCount 1```

To generate multiple passwords, pass strings or integers across the pipeline:
```PS > 1,2,3,4 | New-ComplexPassword -PasswordLength 16 -SpecialCharCount 5```
```PS > 'John','Paul','George','Ringo' | New-ComplexPassword -PasswordLength 10 -SpecialCharCount 2```
