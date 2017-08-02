On Error Resume Next

Dim objWMIService, dtmConvertedDate, colOperatingSystems, objOperatingSystem, dtmInstallDate

Set objWMIService = GetObject("winmgmts:" _
	& "{impersonationLevel=impersonate}!\\.\root\cimv2")

Set dtmConvertedDate = CreateObject("WbemScripting.SWbemDateTime")

Set colOperatingSystems = objWMIService.ExecQuery _
	("Select * from Win32_OperatingSystem")

For Each objOperatingSystem in colOperatingSystems
	dtmConvertedDate.Value = objOperatingSystem.InstallDate
	dtmInstallDate = dtmConvertedDate.GetVarDate
	Wscript.Echo _
		"<OSINSTALL>" & VbCrLf &_
		"<INSTDATE>" & dtmInstallDate & "</INSTDATE>" & VbCrLf &_
		"</OSINSTALL>"
Next