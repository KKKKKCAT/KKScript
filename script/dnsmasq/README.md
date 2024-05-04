# KKScript - Dnsmasq 一鍵安裝腳本v1.0.0 (04/05/2024更新)

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

1. **一鍵腳本**
   ```bash
   wget https://github.com/KKKKKCAT/KKScript/raw/main/script/socat/dnsmasq-install.sh && bash dns.sh
