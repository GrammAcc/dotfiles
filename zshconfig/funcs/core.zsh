# Perform a diff between two JSON files. ${1} is original, ${2} is changed.
jsondiff () {
	diff <(cat ${1} | jq) <(cat ${2} | jq)
}

# Find and replace all occurences of string ${1} with string ${2} in all files with extension ${3} recursively from the current directory
findreplace () {
    sed -i -- "s/${1}/${2}/g" **/*${3}(.^D)
}

# Start podman container with specified compose file.
podtestup () {
    podman-compose -f ${1} up --build --force-recreate --remove-orphans --no-cache --detach
}
