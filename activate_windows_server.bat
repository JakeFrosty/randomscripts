@echo off
REM ---------------------------------------------------------------------------
REM Script Name: activate_windows_server.bat
REM Description: This script activates various versions of Windows Server.
REM Note: This script is meant to run without a pre-included KMS server.
REM       The user is expected to have their own KMS IP/Host provided to the variable "KMSSRV"
REM Author: JakeFrosty
REM ---------------------------------------------------------------------------

REM supply with your own KMS host/ip
SET KMSSRV=

call admin_Check

SET WinSRV2025DC=D764K-2NDRG-47T6Q-P8T8W-YP6DF
SET WinSRV2025STD=TVRH6-WHNXV-R9WG3-9XRFY-MY832
SET WinSRV2025DCAZURE=XGN3F-F394H-FD2MY-PP6FD-8MCRC
SET WinSRV2022DC=WX4NM-KYWYW-QJJR4-XV3QB-6VM33
SET WinSRV2022STD=VDYBN-27WPP-V4HQT-9VMD4-VMK7H
SET WinSRV2019DC=WMDGN-G9PQG-XVVXX-R3X43-63DFG
SET WinSRV2019STD=N69G4-B89J2-4G8F4-WWYCC-J464C
SET WinSRV2019ES=WVDHN-86M7X-466P6-VHXV7-YY726
SET WinSRV2016DC=CB7KF-BWN84-R7R2Y-793K2-8XDDG
SET WinSRV2016STD=WC2BQ-8NRM3-FDDYY-2BFGV-KHKQY
SET WinSRV2012R2DC=W3GGN-FT8W3-Y4M27-J84CP-Q3VJ9
SET WinSRV2012R2STD=D2N9P-3P6X9-2R39C-7RTCD-MDVJX

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
	if "%KMSSRV%"=="" (
		echo [Error: KMSSRV is not set. Please set the KMSSRV variable and try again.]
		GOTO End
	)
	echo Your Windows Version:
	for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value') do (
		set "OSName=%%i"
	)
	if not defined OSName (
		echo [Error: Unable to retrieve OS name.]
		GOTO End
	)
	for /f "tokens=* delims= " %%i in ("%OSName%") do set OSName=%%i
	echo MODIFIED= %OSName%

	if "%OSName%"=="Microsoft Windows Server 2025 Datacenter" (
		SET WINVER=%WinSRV2025DC%
		SET EDITION=ServerDatacenter
	) else if "%OSName%"=="Microsoft Windows Server 2025 Standard" (
		SET WINVER=%WinSRV2025STD%
		SET EDITION=ServerStandard
	) else if "%OSName%"=="Microsoft Windows Server 2025 Datacenter: Azure Edition" (
		SET WINVER=%WinSRV2025DCAZURE%
		SET EDITION=ServerDatacenter
	) else if "%OSName%"=="Microsoft Windows Server 2022 Datacenter" (
		SET WINVER=%WinSRV2022DC%
		SET EDITION=ServerDatacenter
	) else if "%OSName%"=="Microsoft Windows Server 2022 Standard" (
		SET WINVER=%WinSRV2022STD%
		SET EDITION=ServerStandard
	) else if "%OSName%"=="Microsoft Windows Server 2019 Datacenter" (
		SET WINVER=%WinSRV2019DC%
		SET EDITION=ServerDatacenter
	) else if "%OSName%"=="Microsoft Windows Server 2019 Standard" (
		SET WINVER=%WinSRV2019STD%
		SET EDITION=ServerStandard
	) else if "%OSName%"=="Microsoft Windows Server 2019 Essentials" (
		SET WINVER=%WinSRV2019ES%
		SET EDITION=ServerStandard
	) else if "%OSName%"=="Microsoft Windows Server 2016 Datacenter" (
		SET WINVER=%WinSRV2016DC%
		SET EDITION=ServerDatacenter
	) else if "%OSName%"=="Microsoft Windows Server 2016 Standard" (
		SET WINVER=%WinSRV2016STD%
		SET EDITION=ServerStandard
	) else if "%OSName%"=="Microsoft Windows Server 2012 R2 Datacenter" (
		SET WINVER=%WinSRV2012R2DC%
		SET EDITION=ServerDatacenter
	) else if "%OSName%"=="Microsoft Windows Server 2012 R2 Standard" (
		SET WINVER=%WinSRV2012R2STD%
		SET EDITION=ServerStandard
	) else if "%OSName%"=="Microsoft Windows Server 2025 Datacenter Evaluation" (
		SET WINVER=%WinSRV2025DC%
		SET EDITION=ServerDatacenter
		call :dism_Function
	) else if "%OSName%"=="Microsoft Windows Server 2025 Standard Evaluation" (
		SET WINVER=%WinSRV2025STD%
		SET EDITION=ServerStandard
		call :dism_Function
	) else if "%OSName%"=="Microsoft Windows Server 2025 Datacenter: Azure Edition Evaluation" (
		SET WINVER=%WinSRV2025DCAZURE%
		SET EDITION=ServerDatacenter
		call :dism_Function
	) else if "%OSName%"=="Microsoft Windows Server 2022 Datacenter Evaluation" (
		SET WINVER=%WinSRV2022DC%
		SET EDITION=ServerDatacenter
		call :dism_Function
	) else if "%OSName%"=="Microsoft Windows Server 2022 Standard Evaluation" (
		SET WINVER=%WinSRV2022STD%
		SET EDITION=ServerStandard
		call :dism_Function
	) else if "%OSName%"=="Microsoft Windows Server 2019 Datacenter Evaluation" (
		SET WINVER=%WinSRV2019DC%
		SET EDITION=ServerDatacenter
		call :dism_Function
	) else if "%OSName%"=="Microsoft Windows Server 2019 Standard Evaluation" (
		SET WINVER=%WinSRV2019STD%
		SET EDITION=ServerStandard
		call :dism_Function
	) else if "%OSName%"=="Microsoft Windows Server 2019 Essentials Evaluation" (
		SET WINVER=%WinSRV2019ES%
		SET EDITION=ServerStandard
		call :dism_Function
	) else if "%OSName%"=="Microsoft Windows Server 2016 Datacenter Evaluation" (
		SET WINVER=%WinSRV2016DC%
		SET EDITION=ServerDatacenter
		call :dism_Function
	) else if "%OSName%"=="Microsoft Windows Server 2016 Standard Evaluation" (
		SET WINVER=%WinSRV2016STD%
		SET EDITION=ServerStandard
		call :dism_Function
	) else if "%OSName%"=="Microsoft Windows Server 2012 R2 Datacenter Evaluation" (
		SET WINVER=%WinSRV2012R2DC%
		SET EDITION=ServerDatacenter
		call :dism_Function
	) else if "%OSName%"=="Microsoft Windows Server 2012 R2 Standard Evaluation" (
		SET WINVER=%WinSRV2012R2STD%
		SET EDITION=ServerStandard
		call :dism_Function
	) else (
		echo [Error: Unsupported Windows Server version.]
		GOTO End
	)

	echo %WINVER%
	GOTO :activation_Function

:dism_Function
	:: Convert evaluation edition to full edition
	echo [Notice: The system will require a restart to complete the edition upgrade. Please accept the reboot prompt to proceed.]
	dism /online /set-edition:%EDITION% /productkey:%WINVER% /accepteula
	GOTO :EOF

:activation_Function
	slmgr /upk
	slmgr /cpky
	slmgr /ckms
	slmgr /ipk %WINVER%
	slmgr /skms %KMSSRV%
	slmgr /ato
	echo %WINVER%
:End
	echo:
	echo Press any key to exit
	pause >nul
