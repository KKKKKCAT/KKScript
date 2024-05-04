#!/bin/bash

if [ "$(id -u)" != "0" ]; then
    echo "此腳本需要以 root 權限運行。請使用 sudo。"
    exit 1
fi


declare -A dns_domains
dns_domains["TW"]="
gamer.com.tw
bahamut.com.tw
hinet.net
fbcdn.net
gvt1.com
digicert.com
viblast.com
gamer-cds.cdn.hinet.net
gamer2-cds.cdn.hinet.net


kktv.com.tw
kktv.me
kk.stream


myvideo.net.tw


chocotv.com.tw
line-cdn.net
line-scdn.net
linetv.tw


litv.tv
LiTV.tv
cdn.hinet.net


4gtv.tv
cdn.hinet.net


dcard.tw
elaott.tv
cmail20.com
edu.tw
gov.tw
com.tw
org.tw
org.tw


ofiii.com
ofifreepc.akamaized.net


catchplay.com.tw
catchplay.com
cloudfront.net
akamaized.net


biliapi.com
biliapi.net
bilibili.com
bilibili.tv
bilivideo.com
"
dns_domains["JP"]="
control.kochava.com
d151l6v8er5bdm.cloudfront.net
d1sgwhnao7452x.cloudfront.net
dazn-api.com
dazn.com
dazndn.com
dc2-vodhls-perform.secure.footprint.net
dca-ll-livedazn-dznlivejp.s.llnwi.net
dcalivedazn.akamaized.net
dcblivedazn.akamaized.net
indazn.com
indaznlab.com
intercom.io
logx.optimizely.com
s.yimg.jp
sentry.io


dmm.com
dmm.co.jp
dmm-extension.com
dmmapis.com
videomarket.jp
p-smith.com
vmdash-cenc.akamaized.net
img.vm-movie.jp
bam.nr-data.net


abema.io
abema.tv
abema-tv.com
ds-linear-abematv.akamaized.net
linear-abematv.akamaized.net
ds-vod-abematv.akamaized.net
vod-abematv.akamaized.net
ameba.jp
hayabusa.io
mobile-collector.newrelic.com
vod-abematv.akamaized.net
bucketeer.jp
abema.adx.promo
hayabusa.media


dmc.nico
nicovideo.jp
nimg.jp
socdm.com


telasa.jp
kddi-video.com
videopass.jp
d2lmsumy47c8as.cloudfront.net


paravi.jp


unext.jp
nxtv.jp


hulu.com
huluad.com
huluim.com
hulustream.com
happyon.jp
hulu.jp
hjholdings.jp
streaks.jp
yb.uncn.jp
hulu.hb.omtrdc.net
conviva.com
imrworldwide.com
tealiumiq.com
tiqcdn.com
microad.jp
adsrvr.org
adsmoloco.com
yimg.jp
webantenna.info
doubleclick.net
usergram.info
hjholdings.tv


tver.jp
edge.api.brightcove.com
players.brightcove.net


wowow.co.jp


fujitv.co.jp
stream.ne.jp


radiko.jp
radionikkei.jp
smartstream.ne.jp


clubdam.com


cygames.jp
konosubafd.jp
colorfulpalette.org
cds1.clubdam.com
api.worldflipper.jp


music-book.jp
overseaauth.music-book.jp


gyao.yahoo.co.jp


id.zaq.ne.jp
"



dns_domains["HK"]="
nowe.com
nowestatic.com

viu.tv
viu.com
viu.now.com

bigbigchannel.com.hk
bigbigshop.com
content.jwplatform.com
encoretvb.com
mytvsuper.com
mytvsuperlimited.hb.omtrdc.net
mytvsuperlimited.sc.omtrdc.net
tvb.com
tvb.com.au
tvbanywhere.com
tvbanywhere.com.sg
tvbc.com.cn
tvbeventpower.com.hk
tvbusa.com
tvbweekly.com
tvmedia.net.au
videos-f.jwpsrv.com


hoy.tv
"



dns_domains["Disney_Netflix"]="
e13252.dscg.akamaiedge.net
h-netflix.online-metrix.net
netflix.com.edgesuite.net
cookielaw.org
fast.com
flxvpn.net
netflix.ca
netflix.com
netflix.com.au
netflix.com.edgesuite.net
netflix.net
netflixdnstest0.com
netflixdnstest1.com
netflixdnstest10.com
netflixdnstest2.com
netflixdnstest3.com
netflixdnstest4.com
netflixdnstest5.com
netflixdnstest6.com
netflixdnstest7.com
netflixdnstest8.com
netflixdnstest9.com
netflixinvestor.com
netflixstudios.com
netflixtechblog.com
nflxext.com
nflximg.com
nflximg.net
nflxsearch.net
nflxso.net
nflxvideo.net

disney.api.edge.bamgrid.com
disney-plus.net
disneyplus.com
dssott.com
disneynow.com
disneystreaming.com
cdn.registerdisney.go.com
"

dns_domains["ChatGPT"]="
openai.com
chatgpt.com
cdn.auth0.com
azureedge.net
sentry.io
azurefd.net
intercomcdn.com
intercom.io
identrust.com
challenges.cloudflare.com
ai.com
oaistatic.com
oaiusercontent.com
"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
On_Yellow="\033[43m" 
On_White="\033[47m"

# Bold High Intensity
BIBlack="\033[1;90m"      # Black
BIRed="\033[1;91m"        # Red
BIGreen="\033[1;92m"      # Green
BIYellow="\033[1;93m"     # Yellow
BIBlue="\033[1;94m"       # Blue
BIPurple="\033[1;95m"     # Purple
BICyan="\033[1;96m"       # Cyan
BIWhite="\033[1;97m"      # White

On_ICyan="\033[0;106m"    # Cyan
On_IWhite="\033[0;107m"

NC='\033[0m' # No Color

show_info() {
    # echo -e "${On_ICyan}                                                      ${NC}"
    echo -e ""
    echo -e "  ${On_Yellow}Dnsmasq 一鍵安裝腳本v1.0.0 (04/05/2024更新) ${NC}"
    echo -e ""
    echo -e "  ${BIGreen}作者${NC}: ${BIYellow}KKKKKCAT${NC}"
    echo -e "  ${BIGreen}博客${NC}: ${BIYellow}https://kkcat.blog${NC}"
    echo -e "  ${BIGreen}GitHub 項目${NC}: ${BIYellow}https://github.com/KKKKKCAT/KKScript/tree/main/script/${NC}"
    echo -e "  ${BIGreen}Telegram 頻道${NC}: ${BIYellow}https://t.me/kkkkkcat${NC}"
    echo -e ""
    echo -e "  ${BIWhite} /\_/\ ${NC}"
    echo -e "  ${BIWhite}( o.o )${NC}"
    echo -e "  ${BIWhite} > ^ <${NC}"
    echo -e "${On_ICyan}                                                      ${NC}"
    echo -e ""
    echo -e "${BICyan}默认 DNS：${NC}${BIWhite}$(grep 'nameserver' /etc/resolv.conf | awk '{ print $2 }' | tr '\n' ' ')${NC}"
    echo -e "${BICyan}TW DNS：${NC}${BIWhite}$(grep 'kktv.me' /etc/dnsmasq.conf | cut -d '/' -f 4)${NC}"
    echo -e "${BICyan}JP DNS：${NC}${BIWhite}$(grep 'abema.tv' /etc/dnsmasq.conf | cut -d '/' -f 4)${NC}"
    echo -e "${BICyan}HK DNS：${NC}${BIWhite}$(grep 'viu.tv' /etc/dnsmasq.conf | cut -d '/' -f 4)${NC}" 
    echo -e "${BICyan}Disney+/Netflix DNS：${NC}${BIWhite}$(grep 'netflix.com' /etc/dnsmasq.conf | cut -d '/' -f 4)${NC}"
    echo -e "${BICyan}ChatGPT DNS：${NC}${BIWhite}$(grep 'openai.com' /etc/dnsmasq.conf | cut -d '/' -f 4)${NC}"
    echo -e ""
    echo -e "${On_IWhite}                                                      ${NC}"
}

clear
show_info
echo "請選擇操作:"
echo -e "${YELLOW}1.${NC} ${GREEN}安裝 dnsmasq${NC}"
echo -e "${YELLOW}2.${NC} ${GREEN}配置 dnsmasq${NC}"
echo -e "${YELLOW}3.${NC} ${GREEN}啟動 dnsmasq${NC}"
echo -e "${RED}4.${NC} ${RED}停止 dnsmasq${NC}"
echo -e "${YELLOW}5.${NC} ${GREEN}重啟 dnsmasq${NC}"
echo -e "${RED}6.${NC} ${RED}卸載 dnsmasq${NC}"
read -p "輸入選擇（例如：1）: " action



case $action in
    1)
        # 安装 dnsmasq
        echo "正在安裝 dnsmasq..."
        apt-get update && apt-get -y install dnsmasq
        echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" > /etc/resolv.dnsmasq.conf
        echo -e "nameserver 127.0.0.1\nnameserver 1.1.1.1" > /etc/resolv.conf
        chattr +i /etc/resolv.conf
        ;;
    2)
        # 配置 dnsmasq
        echo "請選擇 DNS 區域:"
        echo "1. 台灣 (TW)"
        echo "2. 日本 (JP)"
        echo "3. 香港 (HK)"
        echo "4. Disney+/Netflix"
        echo "5. ChatGPT"
        read -p "輸入選擇（例如：1）: " region_choice
        echo "輸入 DNS IP 地址 (例如：8.8.8.8):"
        read dns_ip

        # 驗證區域選擇，並生成 DNS 配置
        case $region_choice in
            1) selected_region="TW";;
            2) selected_region="JP";;
            3) selected_region="HK";;
            4) selected_region="Disney_Netflix";;
            5) selected_region="ChatGPT";;
            *) echo "選擇的區域無效，請重新運行腳本。"; exit 1;;
        esac

        config_content=""
        for domain in ${dns_domains[$selected_region]}
        do
            config_content+="server=/$domain/tcp/$dns_ip\n"
        done
        if ! grep -q "resolv-file=/etc/resolv.dnsmasq.conf" /etc/dnsmasq.conf; then
            config_content+="resolv-file=/etc/resolv.dnsmasq.conf\n"
        fi

        echo -e "$config_content" >> /etc/dnsmasq.conf

        echo "正在重啟 dnsmasq..."
        /etc/init.d/dnsmasq restart
        ;;
    3)
        # 啟動 dnsmasq
        echo "正在啟動 dnsmasq..."
        /etc/init.d/dnsmasq start
        ;;
    4)
        # 停止 dnsmasq
        echo "正在停止 dnsmasq..."
        /etc/init.d/dnsmasq stop
        ;;
    5)
        # 重啟 dnsmasq
        echo "正在重啟 dnsmasq..."
        /etc/init.d/dnsmasq restart
        ;;
    6)
        # 卸載 dnsmasq
        echo "正在卸載 dnsmasq..."
        chattr -i /etc/resolv.conf
        /etc/init.d/dnsmasq stop
        apt-get remove -y dnsmasq
        rm /etc/resolv.dnsmasq.conf
        rm /etc/dnsmasq.conf
        echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" > /etc/resolv.conf
        ;;
    *)
        echo "無效選擇。"
        exit 1
        ;;
esac
