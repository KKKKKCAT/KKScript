#!/bin/bash

install_realm() {
    # 安裝必要的依賴
    sudo apt-get update
    sudo apt-get install -y wget curl git build-essential

    # 安裝 Rust 工具鏈
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env

    # 下載並構建 Realm
    git clone https://github.com/zhboner/realm
    cd realm
    cargo build --release
    sudo mv target/release/realm /usr/bin/realm
    cd ..
    rm -rf realm

    # 創建配置目錄
    sudo mkdir /etc/realm

    # 創建 systemd 服務單元文件
    sudo tee /etc/systemd/system/realm.service > /dev/null <<EOL
[Unit]
Description=realm
After=network-online.target
Wants=network-online.target systemd-networkd-wait-online.service

[Service]
Type=simple
User=root
Restart=on-failure
RestartSec=5s
WorkingDirectory=/etc/realm
ExecStart=/usr/bin/realm -c /etc/realm/config.toml

[Install]
WantedBy=multi-user.target
EOL

    # 重新加載 systemd 並啟用服務
    sudo systemctl daemon-reload
    sudo systemctl enable realm --now

    echo "Realm 已經成功安裝並配置為開機自啟動服務。"
}

configure_toml() {
    echo "[log]" | sudo tee /etc/realm/config.toml > /dev/null
    echo "level = \"debug\"" | sudo tee -a /etc/realm/config.toml > /dev/null
    echo "" | sudo tee -a /etc/realm/config.toml > /dev/null
    echo "[network]" | sudo tee -a /etc/realm/config.toml > /dev/null
    echo "use_udp = true" | sudo tee -a /etc/realm/config.toml > /dev/null
    echo "" | sudo tee -a /etc/realm/config.toml > /dev/null

    while true; do
        read -p "輸入本地端口 (port): " local_port
        read -p "輸入遠程 IP:Port (格式: ip:port): " remote_ip_port

        echo "[[endpoints]]" | sudo tee -a /etc/realm/config.toml > /dev/null
        echo "listen = \"0.0.0.0:${local_port}\"" | sudo tee -a /etc/realm/config.toml > /dev/null
        echo "remote = \"${remote_ip_port}\"" | sudo tee -a /etc/realm/config.toml > /dev/null
        echo "" | sudo tee -a /etc/realm/config.toml > /dev/null

        read -p "是否要添加更多的 endpoints? (y/n): " add_more
        if [[ "$add_more" != "y" ]]; then
            break
        fi
    done

    sudo systemctl restart realm
    echo "TOML 配置已更新並重啟 Realm 服務。"
}

edit_toml() {
    if [[ -f /etc/realm/config.toml ]]; then
        # 讀取現有的 endpoints
        endpoints=($(grep -oP 'listen\s*=\s*"\K[^"]+' /etc/realm/config.toml))
        remotes=($(grep -oP 'remote\s*=\s*"\K[^"]+' /etc/realm/config.toml))
        
        for i in "${!endpoints[@]}"; do
            echo "Endpoint $((i+1)):"
            echo "  本地端口: ${endpoints[i]}"
            echo "  遠程 IP:Port: ${remotes[i]}"

            read -p "輸入新的本地端口 (留空保持原值): " local_port
            read -p "輸入新的遠程 IP:Port (留空保持原值): " remote_ip_port

            local_port=${local_port:-${endpoints[i]}}
            remote_ip_port=${remote_ip_port:-${remotes[i]}}

            # 更新配置文件
            sed -i "0,/listen = \"${endpoints[i]}\"/s//listen = \"${local_port}\"/" /etc/realm/config.toml
            sed -i "0,/remote = \"${remotes[i]}\"/s//remote = \"${remote_ip_port}\"/" /etc/realm/config.toml
        done

        sudo systemctl restart realm
        echo "TOML 配置已編輯並重啟 Realm 服務。"
    else
        echo "找不到配置文件 /etc/realm/config.toml"
    fi
}

check_status() {
    sudo systemctl status realm
}

remove_realm() {
    sudo systemctl stop realm
    sudo systemctl disable realm
    sudo rm /usr/bin/realm
    sudo rm -r /etc/realm
    sudo rm /etc/systemd/system/realm.service
    sudo systemctl daemon-reload
    echo "Realm 已經成功移除。"
}

echo "請選擇一個選項："
echo "1. 安裝 Realm (包括開機自啟)"
echo "2. 配置 TOML"
echo "3. 編輯現有 TOML"
echo "4. 查看 Realm 狀態"
echo "5. 完整移除 Realm"
read -p "輸入選項 (1-5): " choice

case $choice in
    1)
        install_realm
        ;;
    2)
        configure_toml
        ;;
    3)
        edit_toml
        ;;
    4)
        check_status
        ;;
    5)
        remove_realm
        ;;
    *)
        echo "無效選項，請輸入 1 到 5 之間的數字。"
        ;;
esac
