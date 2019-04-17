@echo OFF
:: ampy port env var
set AMPY_PORT=%1
set MACHINE=%2
set DEMO=%3

IF /I "%MACHINE%"=="ESP8266" ( set IS_SUPPORT=TRUE)
IF /I "%MACHINE%"=="ES32" ( set IS_SUPPORT=TRUE)
IF /I "%MACHINE%"=="RPi" ( set IS_SUPPORT=TRUE)

IF /I "%IS_SUPPORT%"=="TRUE" (
    :: DEMO
    echo [test : %DEMO%]
    CALL :fn_put ../codes/DEMO/%DEMO%.py, %DEMO%.py
    :: lib
    echo [ put libs ...]
    CALL :fn_put ../src/%MACHINE%/config_lora.py, config_lora.py
    IF /I "%MACHINE%"=="RPi" (
        CALL :fn_put ../codes/controller/controller_rpi.py, controller_rpi.py
    ) ELSE (
        CALL :fn_put ../codes/controller/controller_esp.py, controller_esp.py
    )
    CALL :fn_put ../codes/controller/controller.py, controller.py
    CALL :fn_put ../codes/sx127x/sx127x.py, sx127x.py
    :: test
    echo [ put test ...]
    CALL :fn_put boot.py, boot.py
    IF /I "%DEMO%"=="LoRaSender" ( set TEST=test_sender)
    IF /I "%DEMO%"=="LoRaReceiver" ( set TEST=test_receiver)
    IF EXIST %TEST%.py (
    CALL :fn_put main.py, main.py
    CALL :fn_put "%TEST%.py", test.py
    ) ELSE (
        echo ** incorect DEMO file **
    )
) ELSE (
    echo ** MACHINE %MACHINE% is not support **
)
:: list files in the port
@echo [list files]
ampy ls -r

PAUSE

:: Start Function Definition
EXIT /B %ERRORLEVEL%

:: [function] : ampy put
:fn_put
IF EXIST %~1 (
    ampy put %~1 %~2
    echo %~1 "-->" %~2
) ELSE (
    echo ** file no exist: %~1 **
)
EXIT /B 0