function Get-DecryptedString() {
  param (
      $Encrypted,
      [string]$salt="SaltCrypto", 
      [string]$init="PassKeeper", 
      [switch]$arrayOutput,
      [string]$Passphrase
  )

  if (!$Passphrase) {  
    $Passphrase = Read-Host "Enter a Passphrase"
  }
  # https://gallery.technet.microsoft.com/PowerShell-Script-410ef9df
  if($Encrypted -is [string])
  { 
      $Encrypted = [Convert]::FromBase64String($Encrypted) 
  } 

  $r = New-Object System.Security.Cryptography.RijndaelManaged 

  [byte[]]$pass = [Text.Encoding]::UTF8.GetBytes($Passphrase) 
  [byte[]]$salt = [Text.Encoding]::UTF8.GetBytes($salt) 

  $r.Key = (New-Object Security.Cryptography.PasswordDeriveBytes $pass, $salt, "SHA1", 5).GetBytes(32) #256/8 
  $r.IV = (New-Object Security.Cryptography.SHA1Managed).ComputeHash( [Text.Encoding]::UTF8.GetBytes($init) )[0..15] 
  $d = $r.CreateDecryptor() 
  $ms = New-Object IO.MemoryStream @(,$Encrypted) 
  $cs = New-Object Security.Cryptography.CryptoStream $ms,$d,"Read" 
  $sr = New-Object IO.StreamReader $cs 
  $text = $sr.ReadToEnd()
  $sr.Close() 
  $cs.Close() 
  $ms.Close() 
  $r.Clear()
  
  return $text
}