function Connect-SqlDatabase() { 
  param (     
    [object]$SqlInstance, 
    [string]$DatabaseName,   
    [string]$UserName
  )

  $server = New-Object Microsoft.SqlServer.Management.SMO.server $SqlInstance		 
  $server.ConnectionContext.ApplicationName = 'Mitch tools'

  # $Credential = Get-Credential -UserName $UserName -Message "say friend and enter"

  try { 
    # if ( $Credential.UserName -ne $null ) {
    #   $username = ($Credential.username).TrimStart("\")
    #   $server.ConnectionContext.LoginSecure = $false
    #   $server.ConnectionContext.Set_login($username)
    #   $server.ConnectionContext.set_SecurePassword($Credential.Password)			
    # }    
    $server.ConnectionContext.Connect()
  } catch {
      $message = $_.Exception.InnerException.InnerException
      $message = $message.ToString()
      $message = ($message -Split '-->')[0]
      $message = ($message -Split 'at System.Data.SqlClient')[0]
      $message = ($message -Split 'at System.Data.ProviderBase')[0]
      throw "Can't connect to $SqlInstance`: $message "
  }	

  return $server.Databases[$Databasename]
}