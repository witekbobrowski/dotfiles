#!/bin/bash

# Base logging function
function log() {
    echo -e "$1"
}

# Specialized logging methods

function info() {
    log "[💚] $1"
}

function warning() {
    log "[💛] $1"
}

function error() {
    log "[💔] $1"
}

