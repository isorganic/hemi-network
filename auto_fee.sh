#!/bin/bash

# Konfigurasi awal
export POPM_BTC_PRIVKEY= (GANTI DENGA PRIVAT KEY TANPA TANDA KURUNG)
export POPM_BFG_URL=wss://testnet.rpc.hemi.network/v1/ws/public

INSTANCE_ID=$1  # ID unik untuk setiap instance mining
PID_FILE="popmd_$INSTANCE_ID.pid"  # File PID khusus untuk instance ini

# Fungsi untuk mendapatkan high priority fee dari API Mempool.space Testnet
get_high_priority_fee() {
    response=$(curl -s https://mempool.space/testnet/api/v1/fees/recommended)
    fee=$(echo "$response" | jq -r '.fastestFee' 2>/dev/null)

    # Validasi jika fee adalah angka
    if [[ "$fee" =~ ^[0-9]+$ ]]; then
        echo "$fee"
    else
        echo ""
    fi
}

# Loop untuk memperbarui fee setiap 10 menit
while true; do
    # Ambil fee prioritas tinggi (fastestFee)
    HIGH_PRIORITY_FEE=$(get_high_priority_fee)
    
    if [[ -n "$HIGH_PRIORITY_FEE" ]]; then
        # Set fee ke lingkungan
        export POPM_STATIC_FEE="$HIGH_PRIORITY_FEE"
        echo "$(date): Updated POPM_STATIC_FEE to $POPM_STATIC_FEE sat/vB for instance $INSTANCE_ID"
        
        # Hentikan hanya instance ini jika berjalan
        if [[ -f "$PID_FILE" ]]; then
            kill "$(cat "$PID_FILE")" 2>/dev/null
            rm -f "$PID_FILE"
        fi

        # Jalankan instance popmd baru untuk ID ini
        ./popmd &
        echo $! > "$PID_FILE"  # Simpan PID ke file
    else
        echo "$(date): Failed to fetch fee for instance $INSTANCE_ID. Retrying in 10 minutes."
    fi
    
    # Tunggu 10 menit sebelum pengecekan ulang
    sleep 600
done

