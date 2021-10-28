#!/usr/bin/env bash

theme="default"
dir="$HOME/.config/rofi/rofi-launchers"

# reference for categories
# https://specifications.freedesktop.org/menu-spec/menu-spec-1.0.html#category-registry
# https://askubuntu.com/questions/674403/when-creating-a-desktop-file-what-are-v`alid-categories

declare -a main_cat=(
    "AudioVideo"
    "Audio"
    "Video"
    "Development"
    "Education"
    "Game"
    "Graphics"
    "Network"
    "Office"
    "Settings"
    "Utility"
)

declare -a additional_cat=(
    "Building"
    "Debugger"
    "IDE"
    "GUIDesigner"
    "Profiling"
    "RevisionControl"
    "Translation"
    "Calendar"
    "ContactManagement"
    "Database"
    "Dictionary"
    "Chart"
    "Email"
    "Finance"
    "FlowChart"
    "PDA"
    "ProjectManagement"
    "Presentation"
    "Spreadsheet"
    "WordProcessor"
    "2DGraphics"
    "VectorGraphics"
    "RasterGraphics"
    "3DGraphics"
    "Scanning"
    "OCR"
    "Photography"
    "Publishing"
    "Viewer"
    "TextTools"
    "DesktopSettings"
    "HardwareSettings"
    "Printing"
    "PackageManager"
    "Dialup"
    "InstantMessaging"
    "Chat"
    "IRCClient"
    "FileTransfer"
    "HamRadio"
    "News"
    "P2P"
    "RemoteAccess"
    "Telephony"
    "TelephonyTools"
    "VideoConference"
    "WebBrowser"
    "WebDevelopment"
    "Midi"
    "Mixer"
    "Sequencer"
    "Tuner"
    "TV"
    "AudioVideoEditing"
    "Player"
    "Recorder"
    "DiscBurning"
    "ActionGame"
    "AdventureGame"
    "ArcadeGame"
    "BoardGame"
    "BlocksGame"
    "CardGame"
    "KidsGame"
    "LogicGame"
    "RolePlaying"
    "Simulation"
    "SportsGame"
    "StrategyGame"
    "Art"
    "Construction"
    "Music"
    "Languages"
    "Science"
    "ArtificialIntelligence"
    "Astronomy"
    "Biology"
    "Chemistry"
    "ComputerScience"
    "DataVisualization"
    "Economy"
    "Electricity"
    "Geography"
    "Geology"
    "Geoscience"
    "History"
    "ImageProcessing"
    "Literature"
    "Math"
    "NumericalAnalysis"
    "MedicalSoftware"
    "Physics"
    "Robotics"
    "Sports"
    "ParallelComputing"
    "Amusement"
    "Archiving"
    "Compression"
    "Electronics"
    "Emulator"
    "Engineering"
    "FileTools"
    "FileManager"
    "TerminalEmulator"
    "Filesystem"
    "Monitor"
    "Security"
    "Accessibility"
    "Calculator"
    "Clock"
    "TextEditor"
    "Documentation"
    "Core"
    "KDE"
    "GNOME"
    "GTK"
    "Qt"
    "Motif"
    "Java"
    "ConsoleOnly"
)

declare -a reserved_cat=(
    "Screensaver"
    "TrayIcon"
    "Applet"
    "Shell"
)

# declare -a categories=(
#     "Main"
#     "Additional"
#     "Reserved"
# )

# category=$(printf '%s\n' "${categories[@]}" | rofi -dmenu -p "Select category:" -theme "$dir/theme.rasi")

# case "$category" in
#     "Main")
#         temp="main_cat[@]"
#         ;;
#     "Additional")
#         temp="additional_cat[@]"
#         ;;
#     "Reserved")
#         temp="reserved_cat[@]"
#         ;;
#     *)
#         exit 1
#         ;;
# esac

# subcategory=$(printf '%s\n' "${!temp}" | rofi -dmenu -i -p "Select category:" -theme "$dir/theme.rasi")

allcategories=( "${main_cat[@]}" "${additional_cat[@]}" "${reserved_cat[@]}" )
subcategory=$(printf '%s\n' "${allcategories[@]}" | rofi -dmenu -i -p "Category:" -theme "$dir/theme.rasi")

if [ -z "$subcategory" ]; then
    exit 1
fi

rofi -no-lazy-grab -show drun -modi drun -drun-categories "$subcategory" -theme "$dir/$theme"
