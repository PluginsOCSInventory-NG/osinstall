'----------------------------------------------------------
' Plugin for OCS Inventory NG 2.x
' Script : Retrieve Windows installation informations
' Version : 1.01
' Date : 21/04/2018
' Author : Stephane PAUTREL (acb78.com)
'----------------------------------------------------------
' OS checked [X] on	32b	64b	(Professionnal edition)
'	Windows XP		[X]
'	Windows Vista	[X]	[X]
'	Windows 7		[X]	[X]
'	Windows 8.1		[X]	[X]
'	Windows 10		[X]	[X]
'	Windows 2k8R2		[X]
'	Windows 2k12R2		[X]
'	Windows 2k16		[X]
' ---------------------------------------------------------
' NOTE : No checked on Windows 8
' ---------------------------------------------------------
On Error Resume Next

Const HKEY_LOCAL_MACHINE = &H80000002

Dim objWMIService, dtmConvertedDate, colOperatingSystems, objOperatingSystem
Dim dtmInstallDate, strRegistry, BuildVersion

Set dtmConvertedDate = CreateObject("WbemScripting.SWbemDateTime")
Set oReg = GetObject("winmgmts:root\default:StdRegProv")
Set objWMIService = GetObject("winmgmts:root\cimv2")
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

	' Add Windows XP compatibility (short version)
	If (IsNull(BuildVersion)) Then
		BuildVersion = objOperatingSystem.Version
	End If
	
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