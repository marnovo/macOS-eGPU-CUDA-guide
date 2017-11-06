
# Selects the right xcode for normal usage or CUDA usage

PS3='xcode version selector: '
options=("Xcode latest (9.0)" "Xcode 8.3.3 (CUDA)" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Xcode latest (9.0)")
            echo "you chose: Xcode latest (9.0)"
            sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
            ;;
        "Xcode 8.3.3 (CUDA)")
            echo "you chose: Xcode 8.3.3 (CUDA)"
            sudo xcode-select -s /Applications/Xcode_8.3.3.app/Contents/Developer
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

cd /Developer/NVIDIA/CUDA-9.0