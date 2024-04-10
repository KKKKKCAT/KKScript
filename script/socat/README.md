# KKScript - Socat一鍵管理腳本

Socat 是一個在 Linux 系統上運行的多功能命令行工具，它的名字是"SOcket CAT"的縮寫。Socat 主要用於在兩個連接點之間建立雙向通信，並且支援多種不同的通信協議，包括 TCP、UDP、IPv4、IPv6、SSL、TLS、PROXY 等等。它的功能非常強大，可以幫助用戶在系統間進行數據傳輸、端口轉發、加密通信等。

### 安裝
```
wget https://github.com/KKKKKCAT/KKScript/raw/main/script/socat/socat.sh && bash socat.sh
```

### 用法

安裝時需要準備 ```socat_wrapper.sh```，使用了公開Github鏈結和私有Github倉庫模式，如果使用私有Github倉庫請預先準備 "Personal access token" (Settings/Developer Settings)，並開啟 "repo Full control of private repositories"

範本：
```
https://raw.githubusercontent.com/KKKKKCAT/KKScript/main/script/socat/socat_wrapper.sh
```

```
安裝socat服務: 安裝 Socat 並建立 systemd 服務。
啟動socat服務: 啟動 Socat 服務。
停止socat服務: 停止 Socat 服務。
設定開機自啟動 socat服務: 設定 Socat 服務開機自啟動。
檢查socat服務狀態: 查看 Socat 服務的運作狀態。
移除socat服務: 停止、停用 Socat 服務，並移除相關檔案。
新增定時更新任務: 新增定時任務以定期更新 Socat 腳本。
移除定時更新任務: 移除定時任務，停止 Socat 腳本的定期更新。
```

### 在腳本中使用的文件包括：
```
/etc/systemd/system/socat_combined.service

/usr/local/bin/update_socat_wrapper.sh

/usr/local/bin/socat_wrapper.sh
```
