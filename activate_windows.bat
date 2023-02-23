@echo off
:: --------
:: DISCLAIMER: THIS SCRIPT IS MADE FOR HOMELAB PURPOSES ONLY!
:: Any usage outside of educational usage is highly discouraged and illegal.
:: --------

call admin_Check

SET Win10Pro=W269N-WFGWX-YVC9B-4J6C9-T83GX
SET Win10Home=TX9XD-98N7V-6WMQ6-BX7FG-H8Q99
SET Win10Edu=NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
SET Win10Ent=NPPR9-FWDCX-D2C8J-H872K-2YT43
SET Win7Pro=FJ82H-XT6CR-J8D7P-XQJJ2-GPDD4
SET Win7Ent=33PXH-7Y6KF-2VJC9-XBBR8-HVTHH

:admin_Check
	echo Administrative permissions required. Detecting permissions...
	net session >nul 2>&1
	if %errorLevel% == 0 (
		echo:
		echo [Success: Administrative permissions confirmed.]
		echo [Press any key to continue.]
		pause >nul
		goto main_Function
		) else (
		echo:
		echo [Failure: Please run this script as Administrator Account to Proceed.]
		GOTO End
		)
:main_Function
	echo 1. Windows 10/11 Pro
	echo 2. Windows 10/11 Home
	echo 3. Windows 10/11 Education
	echo 4. Windows 10/11 Enterprise
	echo 5. Windows 7 Professional
	echo 6. Windows 7 Enterprise
	echo Your Windows Version:
	wmic os get Caption /value
	CHOICE /C 123456 /M "Enter version according to your windows version: "
	IF ERRORLEVEL 6 SET WINVER=%Win7Ent%
	IF ERRORLEVEL 5 SET WINVER=%Win7Pro%
	IF ERRORLEVEL 4 SET WINVER=%Win10Ent%
	IF ERRORLEVEL 3 SET WINVER=%Win10Edu%
	IF ERRORLEVEL 2 SET WINVER=%Win10Home%
	IF ERRORLEVEL 1 SET WINVER=%Win10Pro%
	GOTO :activation_Function
:activation_Function
	slmgr /upk
	slmgr.vbs /cpky
	slmgr /ckms
	slmgr.vbs /ckms
	slmgr /upk
	slmgr /ipk %WINVER%
	:: IF kms8.msguides.com doesn't work
	:: try these instead:
	:: s9.us.to or kms.teevee.asia
	slmgr /skms kms8.msguides.com
	slmgr /ato
	echo %WINVER%
:End
	echo:
	echo Press any key to exit
	pause >nul
