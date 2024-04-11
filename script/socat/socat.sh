#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
PLAIN='\033[0m'

# 定義函數來安裝socat和服務
install_socat_service() {
    echo "正在安裝socat..."
    sudo apt install socat -y

    # 如果GITHUB_URL環境變量已設置，則使用它；否則，請求用戶輸入
    if [[ -z "$GITHUB_URL" ]]; then
        read -p "Enter the GitHub URL for socat_update.sh: " github_url
    else
        github_url="$GITHUB_URL"
        echo "Using GitHub URL from environment variable: $GITHUB_URL"
    fi

    # 詢問是否為公開倉庫
    read -p "GitHub倉庫是公開的嗎？(y/n): " is_public
    if [[ $is_public == "n" ]]; then
        # 如果GITHUB_TOKEN環境變量已設置，則使用它；否則，請求用戶輸入
        if [[ -z "$GITHUB_TOKEN" ]]; then
            read -sp "Enter your GitHub Token: " github_token
            echo ""
        else
            github_token="$GITHUB_TOKEN"
            echo "Using GitHub Token from environment variable."
        fi
        token_header="Authorization: token $github_token"
    else
        token_header=""
    fi

    # 創建systemd服務文件
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

    # 下载并设置socat_wrapper.sh
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

    sudo chmod +x /usr/local/bin/socat_wrapper.sh
    echo "socat_wrapper.sh has been downloaded and made executable."
    
    # 添加定時任務
    echo "Adding cron job for periodic updates..."
    add_cron_job

    sudo systemctl daemon-reload
    sudo systemctl start socat_combined.service
    
}

download_wrapper() {
    local github_url
    local token_header=""

    if [[ -z "$GITHUB_URL" ]]; then
        read -p "Enter the GitHub URL for socat_update.sh: " github_url
    else
        github_url="$GITHUB_URL"
        echo "Using GitHub URL from environment variable: $GITHUB_URL"
    fi

    if [[ -n "$GITHUB_TOKEN" ]]; then
        token_header="Authorization: token $GITHUB_TOKEN"
    fi

    echo "Downloading socat_wrapper.sh from GitHub..."
    if [[ -n $token_header ]]; then
        sudo curl -H "$token_header" \
             -H 'Accept: application/vnd.github.v3.raw' \
             -L "$github_url" \
             -o /usr/local/bin/socat_wrapper.sh
    else
        sudo curl -H 'Accept: application/vnd.github.v3.raw' \
             -L "$github_url" \
             -o /usr/local/bin/socat_wrapper.sh
    fi

    sudo chmod +x /usr/local/bin/socat_wrapper.sh
    echo "socat_wrapper.sh has been downloaded and made executable."
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

    unset GITHUB_TOKEN
    unset GITHUB_URL

    sudo systemctl daemon-reload
    
    echo "socat服務和相關定時任務已移除。"
}

execute_task() {
    case $1 in
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
            download_wrapper
            ;;
        *)
            echo -e "${RED}無效輸入...${PLAIN}"
            ;;
    esac
}

if [[ $# -eq 0 ]]; then
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
    echo "7) 下載並更新socat_wrapper.sh"
    read -p "輸入選擇（1-7）: " action
    execute_task $action
else
    execute_task $1
fi


