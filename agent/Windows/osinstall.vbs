'----------------------------------------------------------
' Script : Retrieve Windows installation informations (all OS between XP to W10 included)
' Version : 1.0
' Date  : 03/08/2017
' Author : Stéphane PAUTREL
'----------------------------------------------------------
On Error Resume Next

Const HKEY_LOCAL_MACHINE = &H80000002

Dim objWMIService, dtmConvertedDate, colOperatingSystems, objOperatingSystem, dtmInstallDate, strRegistry

Set objWMIService = GetObject("winmgmts:" _
	& "{impersonationLevel=impersonate}!\\.\root\cimv2")

Set dtmConvertedDate = CreateObject("WbemScripting.SWbemDateTime")

Set oReg = GetObject("winmgmts:" _
	& "{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")

Set colItems = objWMIService.ExecQuery( "SELECT * FROM Win32_Processor", , 48 )

For Each objItem in colItems
	ArchiOS = objItem.AddressWidth
	If ArchiOS = "32" Then
		Wow = ""
	ElseIf ArchiOS = "64" Then
		Wow = "WOW6432Node\"
	End If
Next

strRegistry = "SOFTWARE\" & Wow & "Microsoft\Windows NT\CurrentVersion\"
oReg.GetStringValue HKEY_LOCAL_MACHINE, strRegistry, "BuildLabEx", BuildVersion

Set colOperatingSystems = objWMIService.ExecQuery _
	("Select * from Win32_OperatingSystem")

For Each objOperatingSystem in colOperatingSystems
	dtmConvertedDate.Value = objOperatingSystem.InstallDate
	dtmInstallDate = dtmConvertedDate.GetVarDate
	Wscript.Echo _
		"<OSINSTALL>" & VbCrLf &_
		"<INSTDATE>" & dtmInstallDate & "</INSTDATE>" & VbCrLf &_
		"<BUILDVER>" & BuildVersion & "</BUILDVER>" & VbCrLf &_
		"<CODESET>" & objOperatingSystem.CodeSet & "</CODESET>" & VbCrLf &_
		"<COUNTRYCODE>" & objOperatingSystem.CountryCode & "</COUNTRYCODE>" & VbCrLf &_
		"<OSLANGUAGE>" & objOperatingSystem.OSLanguage & "</OSLANGUAGE>" & VbCrLf &_
		"<CURTIMEZONE>" & objOperatingSystem.CurrentTimeZone & "</CURTIMEZONE>" & VbCrLf &_
		"<LOCALE>" & objOperatingSystem.Locale & "</LOCALE>" & VbCrLf &_
		"</OSINSTALL>"
Next