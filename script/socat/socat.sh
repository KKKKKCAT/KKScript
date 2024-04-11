#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
PLAIN='\033[0m'

# 定義函數來安裝socat和服務
install_socat_service() {
    # 1. 安装socat
    echo "正在安装socat..."
    sudo apt install socat -y

    github_token="$GITHUB_TOKEN"
    github_url="$GITHUB_URL"

    # 詢問是否為公開倉庫
    read -p "GitHub倉庫是公開的嗎？(y/n): " is_public
    if [[ $is_public == "n" ]]; then
        # 输入GitHub Token
        read -sp "Enter your GitHub Token: " github_token
        echo ""
        token_header="Authorization: token $github_token"
    else
        github_token=""
        token_header=""
    fi

    # 輸入GitHub文件URL
    read -p "Enter the GitHub URL for socat_update.sh: " github_url

    # 2. 創建systemd服務文件
    service_file="/etc/systemd/system/socat_combined.service"
    echo "Creating systemd service file at ${service_file}..."
    sudo bash -c "cat > ${service_file}" <<EOF
[Unit]
Description=Socat Combined Port Forwarding Service

[Service]
ExecStart=/usr/local/bin/socat_wrapper.sh
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

    # 3. 下載並設置socat_wrapper.sh
    echo "Downloading socat_wrapper.sh from GitHub..."
    if [[ -n $token_header ]]; then
        sudo curl -H "$token_header" \
             -H 'Accept: application/vnd.github.v3.raw' \
             -L $github_url \
             -o /usr/local/bin/socat_wrapper.sh
    else
        sudo curl -H 'Accept: application/vnd.github.v3.raw' \
             -L $github_url \
             -o /usr/local/bin/socat_wrapper.sh
    fi

    # 根據用戶輸入的信息創建update_socat_wrapper.sh腳本
    echo "Creating update_socat_wrapper.sh script..."
    update_script_path="/usr/local/bin/update_socat_wrapper.sh"
    sudo bash -c "cat > $update_script_path" <<EOF
#!/bin/bash

# 該腳本用於定期更新socat_wrapper.sh
echo "Updating socat_wrapper.sh from GitHub..."
if [[ -n "$github_token" ]]; then
    sudo curl -H "Authorization: token $github_token" \
         -H 'Accept: application/vnd.github.v3.raw' \
         -L $github_url \
         -o /usr/local/bin/socat_wrapper.sh
else
    sudo curl -H 'Accept: application/vnd.github.v3.raw' \
         -L $github_url \
         -o /usr/local/bin/socat_wrapper.sh
fi

sudo chmod +x /usr/local/bin/socat_wrapper.sh

echo "socat_wrapper.sh has been updated."
EOF

    sudo chmod +x $update_script_path
    echo "update_socat_wrapper.sh script has been created and made executable."

    sudo chmod +x /usr/local/bin/socat_wrapper.sh
    echo "socat_wrapper.sh has been downloaded and made executable."
    
    # 添加定時任務
    echo "Adding cron job for periodic updates..."
    add_cron_job

    sudo systemctl start socat_combined.service
}


# 定義添加定時任務的函數
add_cron_job() {
    # 定義定時任務命令
    cron_command="/bin/bash /usr/local/bin/update_socat_wrapper.sh"
    
    # 檢查定時任務是否已存在，使用 grep -F 和精確匹配整個命令
    if sudo crontab -l | grep -Fq "$cron_command"; then
        echo "定時任務已存在。"
    else
        # 添加定時任務，確保只有一個實例
        (sudo crontab -l 2>/dev/null | grep -vF "$cron_command"; echo "0 2 * * * $cron_command") | sudo crontab -
        echo "定時任務已添加。"
    fi
}


# 定義移除定時任務的函數
remove_cron_job() {
    # 定義定時任務命令
    cron_command="/bin/bash /usr/local/bin/update_socat_wrapper.sh"
    
    # 移除定時任務，確保匹配整行
    (sudo crontab -l | grep -vF "$cron_command") | sudo crontab -
    echo "定時任務已移除。"
}


# 定義移除功能
remove_socat_service() {
    echo "正在移除socat服務..."
    sudo systemctl stop socat_combined.service
    sudo systemctl disable socat_combined.service
    sudo rm /etc/systemd/system/socat_combined.service
    sudo systemctl daemon-reload
    sudo systemctl reset-failed
    
    # 移除更新腳本和socat_wrapper腳本
    sudo rm /usr/local/bin/update_socat_wrapper.sh
    sudo rm /usr/local/bin/socat_wrapper.sh
    
    # 調用移除定時任務的函數
    remove_cron_job
    
    echo "socat服務和相關定時任務已移除。"
}

# 更新主菜單
echo "#############################################################"
echo -e ""
echo -e "                   ${RED}Socat 一鍵安裝腳本${PLAIN}"
echo -e "  ${GREEN}作者${PLAIN}: ${YELLOW}KKKKKCAT${PLAIN}"
echo -e "  ${GREEN}博客${PLAIN}: ${YELLOW}https://kkcat.blog${PLAIN}"
echo -e "  ${GREEN}GitHub 項目${PLAIN}: ${YELLOW}https://github.com/KKKKKCAT/KKScript/tree/main/script/socat${PLAIN}"
echo -e "  ${GREEN}Telegram 頻道${PLAIN}: ${YELLOW}https://t.me/kkkkkcat${PLAIN}"
echo -e ""
echo "#############################################################"
echo -e ""

echo -e "${GREEN}請選擇操作：${PLAIN}"
echo "1) 安裝socat服務"
echo "2) 啓動socat服務"
echo "3) 停止socat服務"
echo "4) 設置開機自啓socat服務"
echo "5) 檢查socat服務狀態"
echo -e "6) ${RED}移除socat服務${PLAIN}"
echo "7) 添加定時更新任務"
echo -e "8) ${RED}移除定時更新任務${PLAIN}"
read -p "輸入選擇（1-8）: " action

case $action in
    1)
        install_socat_service
        ;;
    2)
        sudo systemctl restart socat_combined.service
        ;;
    3)
        sudo systemctl stop socat_combined.service
        ;;
    4)
        sudo systemctl enable socat_combined.service
        ;;
    5)
        sudo systemctl status socat_combined.service
        ;;
    6)
        remove_socat_service
        ;;
    7)
        add_cron_job
        ;;
    8)
        remove_cron_job
        ;;
    *)
        echo -e "${RED}无效输入...${PLAIN}"
        ;;
esac
