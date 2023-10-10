@echo off
:: Use this script if you have problems with DNS being weird and need a quick way to reset and register your DNS
call admin_Check
:admin_Check
	echo Administrative permissions required. Detecting permissions...
	net session >nul 2>&1
	if %errorLevel% == 0 (
		echo:
		echo [Success: Administrative permissions confirmed.]
		goto main_Function
		) else (
		echo:
		echo [Failure: Please run this script as Administrator Account to Proceed.]
		GOTO End
		)
:main_Function
	ipconfig /flushdns
	ipconfig /registerdns
	GOTO End
:End
	echo:
	echo Script Done, closing in 2 seconds
	timeout 2 > NUL