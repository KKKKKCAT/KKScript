# GCP Instance Manager 安裝教學

## 安裝步驟

1. 安裝 gcloud CLI：
```bash
# 安裝依賴
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo

# 添加 Google Cloud 公鑰和套件源
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# 安裝 SDK
sudo apt-get update
sudo apt-get install google-cloud-sdk
```

2.驗證安裝：
```bash
gcloud version
```

---

1. 基本功能：
   - 管理指定區域 (asia-east1-c) 的 GCP 虛擬機實例
   - 自動檢查實例狀態並啟動未運行的實例
   - 提供詳細的執行日誌

2. 主要組件：
   - 認證管理：使用服務帳號認證文件訪問 GCP
   - 狀態檢查：檢查每個實例的運行狀態
   - 自動重試：啟動失敗時自動重試（預設 3 次）
   - 日誌記錄：所有操作都有詳細日誌

3. 安全特性：
   - 錯誤處理：包含完整的錯誤處理機制
   - 超時控制：啟動操作有超時保護
   - 認證檢查：自動驗證服務帳號權限

4. 運行要求：
   - 需要安裝 gcloud CLI 工具
   - 需要有效的 GCP 服務帳號認證文件
   - 服務帳號需要適當的 GCP 權限

5. 維護特性：
   - 可配置的重試次數和等待時間
   - 容易修改的配置參數
   - 詳細的日誌輸出方便調試

6. 使用場景：
   - 適合定期排程執行（如 crontab）
   - 適合作為維護腳本使用
   - 適合自動化運維場景
