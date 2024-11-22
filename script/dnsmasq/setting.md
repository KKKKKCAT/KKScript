### **新增區域的完整教學**

如果您想新增 **SG 區域** 和 **Tiktok 區域** 的配置，可以參照現有代碼結構，直接在 `declare -A dns_domains` 區塊中加入新的區域及其域名清單。以下是完整的代碼增補：

具體相關域名可參考：https://github.com/1-stream/1stream-public-utils/blob/main/stream.list.json

---

#### **修改的代碼部分**

```bash
dns_domains["SG"]="
mewatch.sg
starhubgo.com
failoverstarhub.akamaized.net
scvm1sc0-ssm.anycast.nagra.com
starhubtvplus.com
"

dns_domains["Tiktok"]="
byteoversea.com
ibytedtos.com
ipstatp.com
muscdn.com
musical.ly
tiktok.com
tik-tokapi.com
tiktokcdn.com
tiktokv.com
"
```

將上述代碼插入 `declare -A dns_domains` 區塊內適當位置，完整結構如下：

---

#### **完整的新增區域代碼結構**

```bash
declare -A dns_domains
dns_domains["TW"]="
...
"
dns_domains["JP"]="
...
"
dns_domains["HK"]="
...
"
dns_domains["Disney_Netflix"]="
...
"
dns_domains["ChatGPT"]="
...
"
dns_domains["SG"]="
mewatch.sg
starhubgo.com
failoverstarhub.akamaized.net
scvm1sc0-ssm.anycast.nagra.com
starhubtvplus.com
"

dns_domains["Tiktok"]="
byteoversea.com
ibytedtos.com
ipstatp.com
muscdn.com
musical.ly
tiktok.com
tik-tokapi.com
tiktokcdn.com
tiktokv.com
"
```

---

#### **後續的代碼調整**

新增後，還需要對以下代碼段進行修改，確保新區域可以被正常使用：

---

### **1. 區域選擇邏輯**

在 `case` 區塊中新增對 **SG** 和 **Tiktok** 的支持：

#### 修改代碼

```bash
# 驗證區域選擇，並生成 DNS 配置
case $region_choice in
    1) selected_region="TW";;
    2) selected_region="JP";;
    3) selected_region="HK";;
    4) selected_region="SG";;  # 新增 SG 區域選擇
    5) selected_region="Tiktok";;  # 新增 Tiktok 區域選擇
    6) selected_region="Disney_Netflix";;
    7) selected_region="ChatGPT";;
    *) echo -e "${BIRed}選擇的區域無效，請重新運行腳本。${NC}"; exit 1;;
esac
```

---

### **2. 區域選擇介面**

新增界面顯示選項，讓使用者可以選擇 **SG** 和 **Tiktok**：

#### 修改代碼

```bash
echo -e ""
echo -e "${BIWhite}請選擇 DNS 區域:${NC}"
echo -e "${BIYellow}1. 台灣 (TW)${NC}"
echo -e "${BIBlue}2. 日本 (JP)${NC}"
echo -e "${BIYellow}3. 香港 (HK)${NC}"
echo -e "${BIBlue}4. 新加坡 (SG)${NC}"  # 新增 SG 選項
echo -e "${BIYellow}5. Tiktok${NC}"        # 新增 Tiktok 選項
echo -e "${BIBlue}6. Disney+/Netflix${NC}"
echo -e "${BIYellow}7. ChatGPT${NC}"
echo -e ""
read -p "輸入選擇（例如：1）或按 Enter 取消: " region_choice
```

---

### **3. 顯示當前 DNS 配置**

新增對 **SG** 和 **Tiktok** 的顯示支持：

#### 修改代碼

```bash
if [ -f /etc/dnsmasq.conf ]; then
    tw_dns=$(grep 'kktv.me' /etc/dnsmasq.conf | cut -d '/' -f 4)
    jp_dns=$(grep 'dmm.co.jp' /etc/dnsmasq.conf | cut -d '/' -f 4)
    hk_dns=$(grep 'viu.tv' /etc/dnsmasq.conf | cut -d '/' -f 4)
    sg_dns=$(grep 'mewatch.sg' /etc/dnsmasq.conf | cut -d '/' -f 4)  # 新增 SG DNS 顯示
    tiktok_dns=$(grep 'tiktok.com' /etc/dnsmasq.conf | cut -d '/' -f 4)  # 新增 Tiktok DNS 顯示
    disney_dns=$(grep 'netflix.com' /etc/dnsmasq.conf | cut -d '/' -f 4)
    chatgpt_dns=$(grep 'openai.com' /etc/dnsmasq.conf | cut -d '/' -f 4)
else
    tw_dns=""
    jp_dns=""
    hk_dns=""
    sg_dns=""
    tiktok_dns=""
    disney_dns=""
    chatgpt_dns=""
fi

echo -e "${BICyan}TW DNS：${NC}${BIWhite}${tw_dns}${NC}"
echo -e "${BICyan}JP DNS：${NC}${BIWhite}${jp_dns}${NC}"
echo -e "${BICyan}HK DNS：${NC}${BIWhite}${hk_dns}${NC}"
echo -e "${BICyan}SG DNS：${NC}${BIWhite}${sg_dns}${NC}"  # 顯示 SG DNS
echo -e "${BICyan}Tiktok DNS：${NC}${BIWhite}${tiktok_dns}${NC}"  # 顯示 Tiktok DNS
echo -e "${BICyan}Disney+/Netflix DNS：${NC}${BIWhite}${disney_dns}${NC}"
echo -e "${BICyan}ChatGPT DNS：${NC}${BIWhite}${chatgpt_dns}${NC}"
```

---

### **效果展示**

新增後，操作選項將如下所示：

#### 選擇界面效果

```bash
請選擇 DNS 區域:
1. 台灣 (TW)
2. 日本 (JP)
3. 香港 (HK)
4. 新加坡 (SG)
5. Tiktok
6. Disney+/Netflix
7. ChatGPT
```

#### 顯示 DNS 配置效果

```bash
TW DNS：8.8.8.8
JP DNS：8.8.4.4
HK DNS：1.1.1.1
SG DNS：192.168.1.1
Tiktok DNS：203.0.113.1
Disney+/Netflix DNS：8.8.8.8
ChatGPT DNS：1.1.1.1
```

---

### **結語**

這樣可以完整地支持 **SG** 和 **Tiktok** 區域的配置及使用，並保證用戶在操作時有清晰的選擇與結果顯示。如果還有其他需求，歡迎繼續交流！
