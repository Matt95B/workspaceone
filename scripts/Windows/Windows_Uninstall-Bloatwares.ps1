# Remove bloatwares that are pre-installed in Windows
# In Workspace ONE UEM console, create a script and paste the below code into the code field.

# Name: Uninstall Bloatwares
# Run: System context

<#
************************
Preparation work to update the $AppPatterns array
Run the below commands on a factory restored PC to get a full list of Appx that are pre-installed in Windows and then decide which one you want to remove. Paste the app name in the $AppPatterns array below.

$ListOfApps = Get-AppxPackage -AllUsers
$ListOfApps | Select-Object -Property Name, PackageFullName
************************
#>

# Retrieve all installed Appx packages for all users
$ListOfApps = Get-AppxPackage -AllUsers

# Define app patterns to match against. "*" could be used as wildcard characters.
$AppPatterns = @(
    "Microsoft.Xbox*",
    "Microsoft.MicrosoftSolitaire*",
    "Microsoft.Zune*",
    "Microsoft.Skype*"
)

# Loop through patterns and remove matching packages
foreach ($pattern in $AppPatterns) {
    # Show which apps match the pattern
    Write-Host "Looking for apps matching: $pattern"

    $AppsToRemove = $ListOfApps | Where-Object { $_.PackageFullName -like $pattern }
    
    # Remove matching apps
    if ($AppsToRemove) {
        foreach ($app in $AppsToRemove) {
            Write-Host "Removing: $($app.PackageFullName)"
            Remove-AppxPackage -Package $app.PackageFullName -ErrorAction SilentlyContinue
        }
    } else {
        Write-Host "No apps found for pattern: $pattern"
    }
}