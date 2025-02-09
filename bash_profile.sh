#!/bin/bash

# Define our custom function

get_script_dir() {
    echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
}

tcdp() {
    script_dir="$(get_script_dir)"
    path="$script_dir/../note"
    echo "Changing directory to $path"
    cd "$path"
}

venv() {
	source ./venv/bin/activate
}
