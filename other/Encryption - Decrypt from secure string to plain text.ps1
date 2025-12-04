# Source: https://learn.microsoft.com/de-de/powershell/module/microsoft.powershell.security/convertfrom-securestring?view=powershell-7.5
# Define the file paths and AES key
$encryptedFilePath = "PATHTOEXPORT"
$decryptedFilePath = "PATHTODECRYPTEDFILE"
$aesKeyBase64 = "AES KEY BASE64"

# Convert the Base64 key to a byte array
$aesKey = [Convert]::FromBase64String($aesKeyBase64)

# Read the encrypted content from the file
$encryptedContent = Get-Content -Path $encryptedFilePath -Raw

# Convert the encrypted content to a secure string
$secureString = $encryptedContent | ConvertTo-SecureString -Key $aesKey

# Convert the secure string back to plain text
$plainText = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureString)
)

# Save the decrypted text to the file
Set-Content -Path $decryptedFilePath -Value $plainText

Write-Output "Decryption complete. File saved at: $decryptedFilePath"
