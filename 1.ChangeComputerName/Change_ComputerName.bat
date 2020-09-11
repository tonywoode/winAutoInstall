@ECHO OFF

set /p PC="Enter New Machine Name: "
IF NOT DEFINED PC (exit)

..\Elevation\elevate wmic path win32_computersystem where "Name='%computername%'" CALL rename name='%PC%'