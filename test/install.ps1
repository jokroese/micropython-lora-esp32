param( $PORT, $MACHINE, $DEMO) # cli args

# [function] : ampy put
function fn_put ($source, $dist) {
    if (Test-Path -Path $source) {
        ampy put $source $dist
        Write-Output "$source --> $dist"
    } else {
        Write-Output "** file no exist: $source **"
    }
}

# [function] : get test file name
function get_test($demo) {
    switch ($demo) {
        LoRaSender { return "test_sender" }
        LoRaReceiver { return "test_receiver" }
        LoRaPingPong { return "test_pingpong" }
        Default { return "" }
    }
}

$env:AMPY_PORT = $PORT # set ampy usb serial port as env

# support validation
$IS_SUPPORT = $FALSE
$SUPPORTS = @("ESP8266", "ESP32")
foreach ($s in $SUPPORTS) { 
    if ($MACHINE -eq $s) {$IS_SUPPORT = $TRUE}
}

# start put files
if ($IS_SUPPORT -eq $TRUE) {
    # DEMO
    Write-Output "[test : $DEMO]"
    fn_put ../codes/DEMO/$DEMO.py "$DEMO.py"
    # Lib
    Write-Output "[ put libs ...]"
    fn_put ../src/ESP8266/config_lora.py config_lora.py
    fn_put ../codes/controller/controller_esp.py controller_esp.py
    fn_put ../codes/controller/controller.py controller.py
    fn_put ../codes/sx127x/sx127x.py sx127x.py
    # test
    Write-Output "[ put test ...]"
    fn_put boot.py boot.py
    $TEST = get_test $DEMO
    if(Test-Path -Path "$TEST.py") {
        fn_put main.py main.py
        fn_put test_util.py test_util.py
        fn_put "$TEST.py" test.py
    } else {
        Write-Output "** incorrect DEMO file **"
    }
} else {
    Write-Output "** MACHINE $MACHINE is not support ** "
}

# list files on board
Write-Output "[list files]"
ampy ls -r
