# KKScript - Socat一鍵管理腳本 （11/04/2024 更新)

Socat 是一個在 Linux 系統上運行的多功能命令行工具，它的名字是"SOcket CAT"的縮寫。Socat 主要用於在兩個連接點之間建立雙向通信，並且支援多種不同的通信協議，包括 TCP、UDP、IPv4、IPv6、SSL、TLS、PROXY 等等。它的功能非常強大，可以幫助用戶在系統間進行數據傳輸、端口轉發、加密通信等。

![](https://raw.githubusercontent.com/KKKKKCAT/KKScript/main/script/socat/socat1.jpg)



## 用法

安裝時需要準備 ```socat_wrapper.sh```，使用了公開Github鏈結和私有Github倉庫模式，如果使用私有Github倉庫請預先準備 "Personal access token" (Settings/Developer Settings)，並開啟 "repo Full control of private repositories"

```socat_wrapper.sh``` 範本：
```
https://raw.githubusercontent.com/KKKKKCAT/KKScript/main/script/socat/socat_wrapper.sh
```

### 1. 私有倉庫模式
```nano ~/.bashrc```

```
export GITHUB_TOKEN=您的token
export GITHUB_URL=您的倉庫URL (https://api.github.com/repos/KKKKKCAT/KKScript/contents/script/socat/socat_wrapper.sh)
```

```
source ~/.bashrc
```

### 1. 公開倉庫/連結模式
```nano ~/.bashrc```
```
export GITHUB_URL=您的倉庫URL (https://raw.githubusercontent.com/KKKKKCAT/KKScript/main/script/socat/socat_wrapper.sh)
```
```
source ~/.bashrc
```

### 2. 安裝
```
wget https://github.com/KKKKKCAT/KKScript/raw/main/script/socat/socat.sh && bash socat.sh
```

### 命令：
```
1) 安裝socat服務
2) 啓動socat服務
3) 停止socat服務
4) 設置開機自啓socat服務
5) 檢查socat服務狀態
6) 移除socat服務
7) 下載並更新socat_wrapper.sh
8) 添加定時更新任務
9) 移除定時更新任務
```

### 在腳本中使用的文件包括：
```
/etc/systemd/system/socat_combined.service

/usr/local/bin/update_socat_wrapper.sh

/usr/local/bin/socat_wrapper.sh
```
