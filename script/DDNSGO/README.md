# KKScript - DDNS-GO 一鍵腳本v1.0.0 (23/06/2024更新)

### 簡單介紹 DDNS-GO 腳本

#### 什麼是 DDNS-GO？
DDNS-GO 是一個用於動態 DNS（DDNS）的工具。動態 DNS 允許您將動態 IP 地址自動更新到 DNS 服務器，從而使您的域名始終指向正確的 IP 地址，無論您的 IP 地址如何變化。DDNS-GO 專為易於配置和使用而設計，並支持多種 DNS 提供商。

#### 腳本功能概述
這個 Bash 腳本旨在自動化安裝和配置 DDNS-GO，確保它作為系統服務運行。這樣，DDNS-GO 可以在系統啟動時自動啟動，並在任何時候都保持運行。

#### 腳本分步解說
以下是腳本的分步解說：

1. **定義版本號**：
   ```bash
   DDNS_GO_VERSION="6.6.3"
   ```
   定義 DDNS-GO 的版本號。

2. **停止並禁用現有的 ddns-go 服務（如果存在）**：
   ```bash
   sudo systemctl stop ddns-go
   sudo systemctl disable ddns-go
   ```
   停止當前正在運行的 DDNS-GO 服務，並將其從自動啟動列表中移除。

3. **刪除舊版本**：
   ```bash
   sudo rm -f /usr/local/bin/ddns-go
   ```
   刪除舊版本的 DDNS-GO 可執行文件。

4. **下載 DDNS-GO**：
   ```bash
   wget https://github.com/jeessy2/ddns-go/releases/download/v${DDNS_GO_VERSION}/ddns-go_${DDNS_GO_VERSION}_linux_x86_64.tar.gz -O /tmp/ddns-go.tar.gz
   ```
   從 GitHub 下載指定版本的 DDNS-GO。

5. **解壓**：
   ```bash
   tar -zxvf /tmp/ddns-go.tar.gz -C /tmp
   ```
   將下載的壓縮包解壓到臨時目錄。

6. **移動到 /usr/local/bin**：
   ```bash
   sudo mv /tmp/ddns-go /usr/local/bin/ddns-go
   ```
   將 DDNS-GO 可執行文件移動到系統的 bin 目錄中，以便全局可用。

7. **添加執行權限**：
   ```bash
   sudo chmod +x /usr/local/bin/ddns-go
   ```
   為 DDNS-GO 可執行文件添加執行權限。

8. **啟用 DDNS-GO 服務**：
   ```bash
   sudo systemctl enable ddns-go
   ```
   將 DDNS-GO 添加到系統服務，並設置為隨系統啟動自動啟動。

9. **顯示完成信息**：
   ```bash
   echo "DDNS-Go 已安裝並設置為系統服務。"
   echo "配置文件默認路徑為：/root/.ddns_go_config.yaml"
   echo "使用命令進行服務管理："
   echo "ddns-go -s (install|uninstall|restart)"
   ```
   提示用戶 DDNS-GO 已成功安裝並配置為系統服務，並提供配置文件路徑及基本的服務管理命令。

#### 腳本下載
您可以從以下 GitHub 連結下載這個腳本：
```
https://raw.githubusercontent.com/KKKKKCAT/KKScript/main/script/DDNSGO/ddns-go.sh
```

通過這個腳本，您可以輕鬆地安裝和管理 DDNS-GO，使您的 DDNS 設置更加便捷和高效。
