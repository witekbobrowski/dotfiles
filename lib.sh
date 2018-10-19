#!/bin/bash

# Base logging function
function log() {
    echo "$1"
}

# Specialized logging functions

function success() {
    log "💚 $1"
}

function info() {
    log "💙 $1"
}

function warning() {
    log "💛 $1"
}

function error() {
    log "❤️  $1"
}

