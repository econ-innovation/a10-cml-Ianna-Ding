#!/bin/bash

# Define file path and root path
file_path="pubnr_cn.txt"
root_path="patents"
per_folder=100

# Function to read numbers from a file
read_numbers() {
    cat "$1"
}

# Function to create folders and files based on the numbers
create_files() {
    local numbers=("$@")
    local folder_paths=()
    local folder_index
    local folder_path
    local file_folder_path
    local file_path
    local idx=0

    mkdir -p "$root_path"

    for number in "${numbers[@]}"; do
        folder_index=$((idx / (per_folder * per_folder)))
        folder_path="${root_path}/Folder_${folder_index}"

        if [[ ! -d "$folder_path" ]]; then
            mkdir -p "$folder_path"
            folder_paths[folder_index]="$folder_path"
        fi

        file_folder_index=$((idx / per_folder))
        file_folder_path="${folder_path}/${file_folder_index}"
        if [[ ! -d "$file_folder_path" ]]; then
            mkdir -p "$file_folder_path"
        fi

        url="https://patents.google.com/patent/${number}"

        file_path="${file_folder_path}/${number}.html"
        curl -k "$url" > "$file_path"

        ((idx++))
    done
}

# Main script execution
IFS=$'\n' read -r -d '' -a numbers < <(read_numbers "$file_path" && printf '\0')
create_files "${numbers[@]}"

