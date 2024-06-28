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

vod-playout-abematv.akamaized.net
live-playout-abematv.akamaized.net
streaming-api-cf.p-c2-x.abema-tv.com

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
IGreen="\033[0;92m"

# Bold High Intensity
BIBlack="\033[1;90m"
BIRed="\033[1;91m"
BIGreen="\033[1;92m"
BIYellow="\033[1;93m"
BIBlue="\033[1;94m"
BIPurple="\033[1;95m"
BICyan="\033[1;96m"
BIWhite="\033[1;97m"

On_ICyan="\033[0;106m"
On_IWhite="\033[0;107m"
On_IRed="\033[0;101m" 

NC='\033[0m' # No Color

show_info() {
    echo -e ""
    echo -e "  ${On_Yellow}Dnsmasq 一鍵安裝腳本v1.0.2 (29/06/2024更新) ${NC}"
    echo -e ""
    echo -e "  ${BIGreen}作者${NC}: ${BIYellow}KKKKKCAT${NC}"
    echo -e "  ${BIGreen}博客${NC}: ${BIYellow}https://kkcat.blog${NC}"
    echo -e "  ${BIGreen}GitHub 項目${NC}: ${BIYellow}https://github.com/KKKKKCAT/KKScript/tree/main/script/dnsmasq${NC}"
    echo -e "  ${BIGreen}Telegram 頻道${NC}: ${BIYellow}https://t.me/kkkkkcat${NC}"
    echo -e ""
    echo -e "  ${BIWhite} /\_/\ ${NC}"
    echo -e "  ${BIWhite}( o.o )${NC}"
    echo -e "  ${BIWhite} > ^ <${NC}"
    echo -e "${On_ICyan}                                                      ${NC}"
    echo -e ""
    echo -e "${BICyan}系統 DNS：${NC}${BIWhite}$(grep 'nameserver' /etc/resolv.conf | awk '{ print $2 }' | tr '\n' ' ')${NC}"
    if [ -f /etc/dnsmasq.conf ]; then
        tw_dns=$(grep 'kktv.me' /etc/dnsmasq.conf | cut -d '/' -f 4)
        jp_dns=$(grep 'dmm.co.jp' /etc/dnsmasq.conf | cut -d '/' -f 4)
        hk_dns=$(grep 'viu.tv' /etc/dnsmasq.conf | cut -d '/' -f 4)
        disney_dns=$(grep 'netflix.com' /etc/dnsmasq.conf | cut -d '/' -f 4)
        chatgpt_dns=$(grep 'openai.com' /etc/dnsmasq.conf | cut -d '/' -f 4)
    else
        tw_dns=""
        jp_dns=""
        hk_dns=""
        disney_dns=""
        chatgpt_dns=""
    fi

    echo -e "${BICyan}TW DNS：${NC}${BIWhite}${tw_dns}${NC}"
    echo -e "${BICyan}JP DNS：${NC}${BIWhite}${jp_dns}${NC}"
    echo -e "${BICyan}HK DNS：${NC}${BIWhite}${hk_dns}${NC}"
    echo -e "${BICyan}Disney+/Netflix DNS：${NC}${BIWhite}${disney_dns}${NC}"
    echo -e "${BICyan}ChatGPT DNS：${NC}${BIWhite}${chatgpt_dns}${NC}"

    echo -e ""
    echo -e "${On_IWhite}                                                      ${NC}"
}

clear
show_info
echo -e ""
echo -e "${BIWhite}請選擇操作:${NC}"
echo -e "${BIYellow}1.${NC} ${IGreen}安裝 dnsmasq${NC}"
echo -e "${BIYellow}2.${NC} ${IGreen}配置 dnsmasq${NC}"
echo -e "${BIYellow}3.${NC} ${IGreen}啟動 dnsmasq${NC}"
echo -e "${BIRed}4.${NC} ${On_IRed}停止 dnsmasq${NC}"
echo -e "${BIYellow}5.${NC} ${IGreen}重啟 dnsmasq${NC}"
echo -e "${BIRed}6.${NC} ${On_IRed}卸載 dnsmasq${NC}"
read -p "輸入選擇（例如：1）: " action

case $action in
    1)
        # 安裝 dnsmasq
        echo "正在安裝 dnsmasq..."
        apt-get update && apt-get -y install dnsmasq
        echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" > /etc/resolv.dnsmasq.conf

        sudo rm /etc/resolv.conf
        sudo touch /etc/resolv.conf
        
        sudo bash -c 'echo -e "nameserver 127.0.0.1\nnameserver 1.1.1.1" > /etc/resolv.conf'
        chattr +i /etc/resolv.conf

        systemctl unmask dnsmasq
        systemctl enable dnsmasq
        systemctl start dnsmasq
        ;;
    2)
        # 配置 dnsmasq
        echo -e ""
        echo -e "${BIWhite}請選擇 DNS 區域:${NC}"
        echo -e "${BIYellow}1. 台灣 (TW)${NC}"
        echo -e "${BIBlue}2. 日本 (JP)${NC}"
        echo -e "${BIYellow}3. 香港 (HK)${NC}"
        echo -e "${BIBlue}4. Disney+/Netflix${NC}"
        echo -e "${BIYellow}5. ChatGPT${NC}"
        echo -e ""
        read -p "輸入選擇（例如：1）或按 Enter 取消: " region_choice

        if [ -z "$region_choice" ]; then
            echo -e "${BIRed}沒有輸入選擇，操作已取消。${NC}"
            exit 0
        fi

        echo "輸入 DNS IP 地址 (例如：8.8.8.8) 或按 Enter 刪除舊設置:"
        read dns_ip

        # 驗證區域選擇，並生成 DNS 配置
        case $region_choice in
            1) selected_region="TW";;
            2) selected_region="JP";;
            3) selected_region="HK";;
            4) selected_region="Disney_Netflix";;
            5) selected_region="ChatGPT";;
            *) echo -e "${BIRed}選擇的區域無效，請重新運行腳本。${NC}"; exit 1;;
        esac

        if [ -f /etc/dnsmasq.conf ]; then
            echo -e "${BIRed}刪除與所選區域相關的舊 DNS 設置${NC}"
            for domain in ${dns_domains[$selected_region]}
            do
                sed -i "/server=\/$domain\/tcp\//d" /etc/dnsmasq.conf
            done
        else
            echo "配置文件 /etc/dnsmasq.conf 不存在，跳過刪除操作。"
        fi

        if [ -n "$dns_ip" ]; then
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
            systemctl restart dnsmasq
        else
            echo "所有與所選區域相關的 DNS 設置已刪除，未添加新配置。"
        fi
        ;;
    3)
        # 啟動 dnsmasq
        echo "正在啟動 dnsmasq..."
        systemctl start dnsmasq
        ;;
    4)
        # 停止 dnsmasq
        echo "正在停止 dnsmasq..."
        systemctl stop dnsmasq
        ;;
    5)
        # 重啟 dnsmasq
        echo "正在重啟 dnsmasq..."
        systemctl restart dnsmasq
        ;;
    6)
        # 卸載 dnsmasq
        echo "正在卸載 dnsmasq..."
        chattr -i /etc/resolv.conf
        systemctl stop dnsmasq
        apt-get remove -y dnsmasq
        rm /etc/resolv.dnsmasq.conf
        rm /etc/dnsmasq.conf
        sudo rm /etc/resolv.conf
        sudo touch /etc/resolv.conf
        sudo bash -c 'echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" > /etc/resolv.conf'
        ;;
    *)
        echo -e "${BIRed}沒有輸入選擇，操作已取消。${NC}"
        exit 1
        ;;
esac

