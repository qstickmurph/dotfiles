# Set flags
while getopts "hvf" flag; do
 case $flag in
   h) echo -e "usage: $0 [-h] [-v]
\t-h Prints the help menu
\t-v Verbose mode
\t-f Force"
exit;
   ;;
   v) # Handle the -v flag
   VERBOSE=true
   ;;
   f) # Handle the -f flag
   FORCE=true
   ;;
 esac
done

# Declare dotfile folder system mapping
declare -A baseFolders
baseFolders['home']="."
baseFolders['config']=".config"

for baseFolder in "${!baseFolders[@]}"; do
    cd $baseFolder;
    for file in $(find . -mindepth 1 -maxdepth 1 -printf "%f\n"); do
        targetFile="$PWD/$file"
        destinationFile="$HOME/${baseFolders[$baseFolder]}/$file"
        ln -Ts ${FORCE:+-f} $targetFile $destinationFile
        if [[ "$VERBOSE" = true ]]; then
            echo "Linked $destinationFile to $targetFile"
        fi
    done
    cd $OLDPWD;
done
