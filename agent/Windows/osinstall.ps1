function Get-WindowsFullVersion 
{
    try 
    {
        $oSVersion = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
        $fullVersion = '{0}.{1}' -f $oSVersion.CurrentBuild, $oSVersion.UBR
        return $fullVersion
    }
    catch 
    {
        # Write-Error "Failed to get Windows version. Error: $_"
        return $null
    }
}
function Get-OSInformation 
{
    try 
    {
        $os = Get-WmiObject -Class Win32_OperatingSystem
        $installDate = $os.ConvertToDateTime($os.InstallDate)
        $installDateFormatted = $installDate.ToString('yyyy-MM-dd HH:mm:ss') #Format for OCS
        $osInformation = @{
            InstallDate     = $installDateFormatted
            CodeSet         = $os.CodeSet
            CountryCode     = $os.CountryCode
            OSLanguage      = $os.OSLanguage
            CurrentTimeZone = $os.CurrentTimeZone
            Locale          = $os.Locale
        }
        return $osInformation
    }
    catch 
    {
        # Write-Error -Message "Failed to get OS information. Error: $_"
        return $null
    }
}

$osInfo = Get-OSInformation
$fullOsVersion = Get-WindowsFullVersion

$xml += "<OSINSTALL>`n"
$xml += '<INSTDATE>' + $osInfo.InstallDate + "</INSTDATE>`n"
$xml += '<BUILDVER>' + $fullOsVersion + "</BUILDVER>`n"
$xml += '<CODESET>' + $osInfo.CodeSet + "</CODESET>`n"
$xml += '<COUNTRYCODE>' + $osInfo.CountryCode + "</COUNTRYCODE>`n"
$xml += '<OSLANGUAGE>' + $osInfo.OSLanguage + "</OSLANGUAGE>`n"
$xml += '<CURTIMEZONE>' + $osInfo.CurrentTimeZone + "</CURTIMEZONE>`n"
$xml += '<LOCALE>' + $osInfo.Locale + "</LOCALE>`n"
$xml += '</OSINSTALL>'

# [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::WriteLine($xml)