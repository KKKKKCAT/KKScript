#https://gist.github.com/vratiu/9780109
#!/bin/bash

# Reset
Color_Off="\033[0m"       # Text Reset

# Regular Colors
Black="\033[0;30m"        # Black
Red="\033[0;31m"          # Red
Green="\033[0;32m"        # Green
Yellow="\033[0;33m"       # Yellow
Blue="\033[0;34m"         # Blue
Purple="\033[0;35m"       # Purple
Cyan="\033[0;36m"         # Cyan
White="\033[0;37m"        # White

# Bold
BBlack="\033[1;30m"       # Black
BRed="\033[1;31m"         # Red
BGreen="\033[1;32m"       # Green
BYellow="\033[1;33m"      # Yellow
BBlue="\033[1;34m"        # Blue
BPurple="\033[1;35m"      # Purple
BCyan="\033[1;36m"        # Cyan
BWhite="\033[1;37m"       # White

# Underline
UBlack="\033[4;30m"       # Black
URed="\033[4;31m"         # Red
UGreen="\033[4;32m"       # Green
UYellow="\033[4;33m"      # Yellow
UBlue="\033[4;34m"        # Blue
UPurple="\033[4;35m"      # Purple
UCyan="\033[4;36m"        # Cyan
UWhite="\033[4;37m"       # White

# Background
On_Black="\033[40m"       # Black
On_Red="\033[41m"         # Red
On_Green="\033[42m"       # Green
On_Yellow="\033[43m"      # Yellow
On_Blue="\033[44m"        # Blue
On_Purple="\033[45m"      # Purple
On_Cyan="\033[46m"        # Cyan
On_White="\033[47m"       # White

# High Intensity
IBlack="\033[0;90m"       # Black
IRed="\033[0;91m"         # Red
IGreen="\033[0;92m"       # Green
IYellow="\033[0;93m"      # Yellow
IBlue="\033[0;94m"        # Blue
IPurple="\033[0;95m"      # Purple
ICyan="\033[0;96m"        # Cyan
IWhite="\033[0;97m"       # White

# Bold High Intensity
BIBlack="\033[1;90m"      # Black
BIRed="\033[1;91m"        # Red
BIGreen="\033[1;92m"      # Green
BIYellow="\033[1;93m"     # Yellow
BIBlue="\033[1;94m"       # Blue
BIPurple="\033[1;95m"     # Purple
BICyan="\033[1;96m"       # Cyan
BIWhite="\033[1;97m"      # White

# High Intensity backgrounds
On_IBlack="\033[0;100m"   # Black
On_IRed="\033[0;101m"     # Red
On_IGreen="\033[0;102m"   # Green
On_IYellow="\033[0;103m"  # Yellow
On_IBlue="\033[0;104m"    # Blue
On_IPurple="\033[10;95m"  # Purple
On_ICyan="\033[0;106m"    # Cyan
On_IWhite="\033[0;107m"   # White

# Display all colors and styles
echo -e "Regular Colors:"
echo -e "${Black}Black${Color_Off}"
echo -e "${Red}Red${Color_Off}"
echo -e "${Green}Green${Color_Off}"
echo -e "${Yellow}Yellow${Color_Off}"
echo -e "${Blue}Blue${Color_Off}"
echo -e "${Purple}Purple${Color_Off}"
echo -e "${Cyan}Cyan${Color_Off}"
echo -e "${White}White${Color_Off}"

echo -e "Bold Colors:"
echo -e "${BBlack}Black${Color_Off}"
echo -e "${BRed}Red${Color_Off}"
echo -e "${BGreen}Green${Color_Off}"
echo -e "${BYellow}Yellow${Color_Off}"
echo -e "${BBlue}Blue${Color_Off}"
echo -e "${BPurple}Purple${Color_Off}"
echo -e "${BCyan}Cyan${Color_Off}"
echo -e "${BWhite}White${Color_Off}"

echo -e "Underline Colors:"
echo -e "${UBlack}Black${Color_Off}"
echo -e "${URed}Red${Color_Off}"
echo -e "${UGreen}Green${Color_Off}"
echo -e "${UYellow}Yellow${Color_Off}"
echo -e "${UBlue}Blue${Color_Off}"
echo -e "${UPurple}Purple${Color_Off}"
echo -e "${UCyan}Cyan${Color_Off}"
echo -e "${UWhite}White${Color_Off}"

echo -e "Background Colors:"
echo -e "${On_Black}Black${Color_Off}"
echo -e "${On_Red}Red${Color_Off}"
echo -e "${On_Green}Green${Color_Off}"
echo -e "${On_Yellow}Yellow${Color_Off}"
echo -e "${On_Blue}Blue${Color_Off}"
echo -e "${On_Purple}Purple${Color_Off}"
echo -e "${On_Cyan}Cyan${Color_Off}"
echo -e "${On_White}White${Color_Off}"

echo -e "High Intensity Colors:"
echo -e "${IBlack}Black${Color_Off}"
echo -e "${IRed}Red${Color_Off}"
echo -e "${IGreen}Green${Color_Off}"
echo -e "${IYellow}Yellow${Color_Off}"
echo -e "${IBlue}Blue${Color_Off}"
echo -e "${IPurple}Purple${Color_Off}"
echo -e "${ICyan}Cyan${Color_Off}"
echo -e "${IWhite}White${Color_Off}"

echo -e "Bold High Intensity Colors:"
echo -e "${BIBlack}Black${Color_Off}"
echo -e "${BIRed}Red${Color_Off}"
echo -e "${BIGreen}Green${Color_Off}"
echo -e "${BIYellow}Yellow${Color_Off}"
echo -e "${BIBlue}Blue${Color_Off}"
echo -e "${BIPurple}Purple${Color_Off}"
echo -e "${BICyan}Cyan${Color_Off}"
echo -e "${BIWhite}White${Color_Off}"

echo -e "High Intensity Background Colors:"
echo -e "${On_IBlack}Black${Color_Off}"
echo -e "${On_IRed}Red${Color_Off}"
echo -e "${On_IGreen}Green${Color_Off}"
echo -e "${On_IYellow}Yellow${Color_Off}"
echo -e "${On_IBlue}Blue${Color_Off}"
echo -e "${On_IPurple}Purple${Color_Off}"
echo -e "${On_ICyan}Cyan${Color_Off}"
echo -e "${On_IWhite}White${Color_Off}"
