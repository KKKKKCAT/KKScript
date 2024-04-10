#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
PLAIN='\033[0m'

# 定义函数来安装socat和服务
install_socat_service() {
    # 1. 安装socat
    echo "正在安装socat..."
    sudo apt install socat -y

    # 询问是否为公开仓库
    read -p "GitHub仓库是公开的吗？(y/n): " is_public
    if [[ $is_public == "n" ]]; then
        # 输入GitHub Token
        read -sp "Enter your GitHub Token: " github_token
        echo ""
        token_header="Authorization: token $github_token"
    else
        github_token=""  # 确保这个变量在脚本中被清空
        token_header=""
    fi

    # 输入GitHub文件URL
    read -p "Enter the GitHub URL for socat_update.sh: " github_url

    # 2. 创建systemd服务文件
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

    # 3. 下载并设置socat_wrapper.sh
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

    # 根据用户输入的信息创建update_socat_wrapper.sh脚本
    echo "Creating update_socat_wrapper.sh script..."
    update_script_path="/usr/local/bin/update_socat_wrapper.sh"
    sudo bash -c "cat > $update_script_path" <<EOF
#!/bin/bash

# 该脚本用于定期更新socat_wrapper.sh
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
    
    # 添加定时任务
    echo "Adding cron job for periodic updates..."
    add_cron_job

    sudo systemctl start socat_combined.service
}


# 定义添加定时任务的函数
add_cron_job() {
    # 定义定时任务命令
    cron_command="/bin/bash /usr/local/bin/update_socat_wrapper.sh"
    
    # 检查定时任务是否已存在，使用 grep -F 和精确匹配整个命令
    if sudo crontab -l | grep -Fq "$cron_command"; then
        echo "定时任务已存在。"
    else
        # 添加定时任务，确保只有一个实例
        (sudo crontab -l 2>/dev/null | grep -vF "$cron_command"; echo "0 2 * * * $cron_command") | sudo crontab -
        echo "定时任务已添加。"
    fi
}


# 定义移除定时任务的函数
remove_cron_job() {
    # 定义定时任务命令
    cron_command="/bin/bash /usr/local/bin/update_socat_wrapper.sh"
    
    # 移除定时任务，确保匹配整行
    (sudo crontab -l | grep -vF "$cron_command") | sudo crontab -
    echo "定时任务已移除。"
}


# 定义移除功能
remove_socat_service() {
    echo "正在移除socat服务..."
    sudo systemctl stop socat_combined.service
    sudo systemctl disable socat_combined.service
    sudo rm /etc/systemd/system/socat_combined.service
    sudo systemctl daemon-reload
    sudo systemctl reset-failed
    
    # 移除更新脚本和socat_wrapper脚本
    sudo rm /usr/local/bin/update_socat_wrapper.sh
    sudo rm /usr/local/bin/socat_wrapper.sh
    
    # 调用移除定时任务的函数
    remove_cron_job
    
    echo "socat服务和相关定时任务已移除。"
}

# 更新主菜单
echo "#############################################################"
echo -e ""
echo -e "                   ${RED}Socat 一键安装脚本${PLAIN}"
echo -e "  ${GREEN}作者${PLAIN}: ${YELLOW}KKKKKCAT${PLAIN}"
echo -e "  ${GREEN}博客${PLAIN}: ${YELLOW}https://kkcat.blog${PLAIN}"
echo -e "  ${GREEN}GitHub 项目${PLAIN}: ${YELLOW}https://github.com/KKKKKCAT/KKScript/tree/main/script/socat${PLAIN}"
echo -e "  ${GREEN}Telegram 频道${PLAIN}: ${YELLOW}https://t.me/kkkkkcat${PLAIN}"
echo -e ""
echo "#############################################################"
echo -e ""

echo -e "${GREEN}请选择操作：${PLAIN}"
echo "1) 安装socat服务"
echo "2) 启动socat服务"
echo "3) 停止socat服务"
echo "4) 设置开机自启socat服务"
echo "5) 检查socat服务状态"
echo -e "6) ${RED}移除socat服务${PLAIN}"
echo "7) 添加定时更新任务"
echo -e "8) ${RED}移除定时更新任务${PLAIN}"
read -p "输入选择（1-8）: " action

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
