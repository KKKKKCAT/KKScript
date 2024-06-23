#!/bin/bash

# 定義版本號
DDNS_GO_VERSION="6.6.3"

# 停止並禁用現有的 ddns-go 服務（如果存在）
sudo systemctl stop ddns-go
sudo systemctl disable ddns-go

# 刪除舊版本
sudo rm -f /usr/local/bin/ddns-go

# 下載 ddns-go
wget https://github.com/jeessy2/ddns-go/releases/download/v${DDNS_GO_VERSION}/ddns-go_${DDNS_GO_VERSION}_linux_x86_64.tar.gz -O /tmp/ddns-go.tar.gz

# 解壓
tar -zxvf /tmp/ddns-go.tar.gz -C /tmp

# 移動到 /usr/local/bin
sudo mv /tmp/ddns-go /usr/local/bin/ddns-go

# 添加執行權限
sudo chmod +x /usr/local/bin/ddns-go

# 啟用 ddns-go 服務
sudo systemctl enable ddns-go

echo "DDNS-Go 已安裝並設置為系統服務。"

# 顯示使用說明
echo "配置文件默認路徑為：/root/.ddns_go_config.yaml"
echo "使用命令進行服務管理："
echo "ddns-go -s (install|uninstall|restart)"

