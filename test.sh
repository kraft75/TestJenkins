#!/bin/bash

# Führt das Programm aus
./main

# Überprüft den Rückgabewert des Programms
if [ $? -eq 0 ]; then
    echo "Test passed!"
else
    echo "Test failed!"
    exit 1
fi

