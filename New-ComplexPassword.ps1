Function New-ComplexPassword {
    <#
    .SYNOPSIS
    Password Generator
    
    .DESCRIPTION
    Password Generator tool to obtain any length and numbers of passwords, 
    adding desired number of special characters, quickly. 
    
    .PARAMETER PasswordLength
    Add a integer value for desired password length
    
    .PARAMETER SpecialCharCount
     Add a integer value for desired number of special characters
    
    .PARAMETER GenerateUserPW
    Enter as many named string or integer values 
    
    .EXAMPLE
    'John','Paul','George','Ringo' | New-ComplexPassword -PasswordLength 10 -SpecialCharCount 2

    1..5 | New-ComplexPassword -PasswordLength 16 -SpecialCharCount 5
    
    .NOTES
    By Graham Beer
    #>
    
    [Cmdletbinding(DefaultParameterSetName='Single')]
        Param(
        [Parameter(ParameterSetName='Single')]
        [Parameter(ParameterSetName='Multiple')]
        [Int]
        $PasswordLength,
        
        [Parameter(ParameterSetName='Single')]
        [Parameter(ParameterSetName='Multiple')]
        [int]
        $SpecialCharCount,

        [Parameter(ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='Multiple')]
        [String[]]
        $GenerateUserPW
        )
    Begin {   
        # The System.Web namespaces contain types that enable browser/server communication
        Add-Type -AssemblyName System.Web 
    }
    Process {
        switch ($PsCmdlet.ParameterSetName) {
            'Single' {
                # GeneratePassword static method: Generates a random password of the specified length
                [System.Web.Security.Membership]::GeneratePassword($PasswordLength, $SpecialCharCount)
            }
            'Multiple' {
                $GenerateUserPW | Foreach {
                    # Custom Object to display results
                    New-Object -TypeName PSObject -Property @{
                        User = $_
                        Password = [System.Web.Security.Membership]::GeneratePassword($PasswordLength, $SpecialCharCount)
                   }
                }
            }
        } # End of Switch
    }
} # End of Function

# Obtain Overload definition
# PS C:\demo> [System.Web.Security.Membership]::GeneratePassword

# OverloadDefinitions
# -------------------
# static string GeneratePassword(int length, int numberOfNonAlphanumericCharacters)

# Example 1
'John','Paul','George','Ringo' | New-ComplexPassword -PasswordLength 10 -SpecialCharCount 2

# Example 2
1..5 | New-ComplexPassword -PasswordLength 16 -SpecialCharCount 5

# Example 3 - quick export, using utf8 to preserve special characters
(1..5 | New-ComplexPassword -PasswordLength 10 -SpecialCharCount 1).Password | Out-File c:\demo\demo2\Passwords.csv -Encoding utf8 -Force

# Perform an input
$i = 0
Get-Content -Path c:\demo\demo2\Passwords.csv | foreach { $i++; "Password for number [$i]: $_"} 