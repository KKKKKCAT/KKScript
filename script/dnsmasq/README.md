# KKScript - Dnsmasq 一鍵安裝腳本v1.0.5 (22/11/2024更新)

|||
| -------- | ---------- |
|![](https://raw.githubusercontent.com/KKKKKCAT/KKScript/main/script/dnsmasq/dnsmasq.png)|![](https://raw.githubusercontent.com/KKKKKCAT/KKScript/main/script/dnsmasq/kkcatttt.jpg)|

這個 Bash 腳本提供了一個簡便的方法來安裝、配置和管理 Dnsmasq 服務。它包括多個操作選項，如安裝、配置、啟動、停止、重啟以及卸載 Dnsmasq。

## 功能簡介

- **安裝 Dnsmasq**：自動從官方倉庫安裝 Dnsmasq。
- **配置 Dnsmasq**：根據用戶需求配置不同的 DNS 解析區域。
- **啟動/停止/重啟**：控制 Dnsmasq 服務的運行狀態。
- **卸載 Dnsmasq**：從系統中完全移除 Dnsmasq 服務和配置文件。

## 環境要求

- 適用於大多數基於 Debian 的 Linux 發行版。
- 需要 root 權限。

## 安裝和使用

1. **安裝dnsmasq**
   ```bash
   apt install dnsmasq

3. **一鍵腳本**
   ```bash
   wget https://raw.githubusercontent.com/KKKKKCAT/KKScript/main/script/dnsmasq/dns.sh && bash dns.sh


## 腳本選項

當運行腳本後，將出現以下選項：

- `1`：安裝 Dnsmasq
- `2`：配置 Dnsmasq
- `3`：啟動 Dnsmasq
- `4`：停止 Dnsmasq
- `5`：重啟 Dnsmasq
- `6`：卸載 Dnsmasq

## 例子

**安裝 Dnsmasq**

選擇 `1` 會自動更新系統包列表，安裝 Dnsmasq，並配置默認的 DNS 解析文件。

**配置 Dnsmasq**

選擇 `2` 後，根據提示輸入所需配置的 DNS 區域和 IP 地址。支持的區域包括台灣、日本、香港、Disney+/Netflix 和 ChatGPT。

## 維護者

- **KKKKKCAT**
  - 博客：[https://kkcat.blog](https://kkcat.blog)
  - GitHub：[https://github.com/KKKKKCAT/KKScript/tree/main/script/dnsmasq](https://github.com/KKKKKCAT/KKScript/tree/main/script/dnsmasq)
  - Telegram：[https://t.me/kkkkkcat](https://t.me/kkkkkcat)

## 版本歷史

- v1.0.0 (04/05/2024)：初始發布版本。
- v1.0.1 (15/06/2024)：Abema解鎖新加了"vod-playout-abematv.akamaized.net" & "live-playout-abematv.akamaized.net" 不然有些直播或影片會看不到
- v1.0.3 (21/11/2024)：新增TW friday.tw
- v1.0.5 (22/11/2024)：新增SG區(meWATCH, Starhub TV+)、新增Tiktok區、新增TVBAnywhere+區、新增HBO Max區、加入Hotstar相關域名到Netflix/Disney+區、舊有HK區中的mytvsuper相關域名更正以分開mytvsuper與新增TVBAnywhere+(需要刪除/etc/dnsmasq.conf重新配置一次dns)
