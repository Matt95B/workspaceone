# Report on available biometric devices present on Windows via a PowerShell script.
# In Workspace ONE UEM console, create a sensor and paste the below code into the code field.

# Name: win_biometric_device
# Run: System context

$biometricDevices = Get-CimInstance -ClassName Win32_PnPEntity | Where-Object { $_.PNPClass -eq 'Biometric' -and $_.Present }

$devicesArray = New-Object System.Collections.ArrayList

if ($biometricDevices) {
    foreach ($device in $biometricDevices) {
        [void]$devicesArray.Add($device.Description)
    }
    $output = $devicesArray -join ","
    Write-Output $output
} else {
    Write-Output "No biometric devices"
}