#!/bin/bash

# 設置變量
PROJECT_ID="xxxxxxxxxxx"
ZONE="xxxxxxxxx"
CREDENTIALS_FILE="你的憑證文件路徑.json"
LOG_FILE="/var/log/gcp_instance_manager.log"
MAX_RETRIES=3
SLEEP_INTERVAL=5

# 記錄函數
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# 檢查依賴
check_dependencies() {
    if ! command -v gcloud &> /dev/null; then
        log_message "錯誤: 未安裝 gcloud CLI"
        exit 1
    fi
}

# 設置認證
setup_credentials() {
    if [ ! -f "$CREDENTIALS_FILE" ]; then
        log_message "錯誤: 找不到憑證文件 $CREDENTIALS_FILE"
        exit 1
    fi
    
    export GOOGLE_APPLICATION_CREDENTIALS="$CREDENTIALS_FILE"
    if ! gcloud auth activate-service-account --key-file="$CREDENTIALS_FILE" 2>/dev/null; then
        log_message "錯誤: 認證失敗，請檢查憑證文件"
        exit 1
    fi
    log_message "成功啟用服務帳號認證"
}

# 獲取實例狀態
get_instance_status() {
    local instance_name="$1"
    gcloud compute instances describe "$instance_name" \
        --zone="$ZONE" \
        --project="$PROJECT_ID" \
        --format="get(status)" 2>/dev/null
}

# 啟動實例
start_instance() {
    local instance_name="$1"
    local retry_count=0
    
    while [ $retry_count -lt $MAX_RETRIES ]; do
        log_message "正在啟動實例 $instance_name"
        
        if gcloud compute instances start "$instance_name" \
            --zone="$ZONE" \
            --project="$PROJECT_ID" \
            --quiet 2>/dev/null; then
            
            # 等待實例完全啟動
            for i in {1..12}; do # 最多等待 60 秒
                status=$(get_instance_status "$instance_name")
                if [ "$status" = "RUNNING" ]; then
                    log_message "實例 $instance_name 已成功啟動"
                    return 0
                fi
                sleep 5
            done
        fi
        
        retry_count=$((retry_count + 1))
        [ $retry_count -lt $MAX_RETRIES ] && sleep $SLEEP_INTERVAL
    done
    
    log_message "錯誤: 無法啟動實例 $instance_name 經過 $MAX_RETRIES 次嘗試"
    return 1
}

# 處理實例
process_instances() {
    local total_instances=0
    local success_count=0
    
    log_message "正在檢查區域: $ZONE 的實例"
    
    # 獲取區域內的所有實例
    local instances
    instances=$(gcloud compute instances list \
        --project="$PROJECT_ID" \
        --zones="$ZONE" \
        --format="value(name)" 2>/dev/null)
    
    if [ -z "$instances" ]; then
        log_message "在區域 $ZONE 中未找到任何實例"
        return 0
    fi
    
    # 處理每個實例
    for instance in $instances; do
        total_instances=$((total_instances + 1))
        log_message "檢查實例: $instance"
        
        status=$(get_instance_status "$instance")
        if [ "$status" != "RUNNING" ]; then
            if start_instance "$instance"; then
                success_count=$((success_count + 1))
            fi
        else
            log_message "實例 $instance 已在運行中"
            success_count=$((success_count + 1))
        fi
    done
    
    log_message "處理完成: 總實例數 $total_instances, 成功處理 $success_count 個實例"
}

# 主程序
main() {
    log_message "開始執行 GCP 實例管理腳本 (區域: $ZONE)"
    check_dependencies
    setup_credentials
    process_instances
    log_message "腳本執行完成"
}

# 執行主程序
main
