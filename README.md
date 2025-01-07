## Instalasi
1. Clone repository:
   ```bash
   git clone https://github.com/isorganic/hemi-network.git
2. masuk ke dc repository :
   ```bash
   cd hemi-network
3. download last version CLI Miner hemi, liat di https://github.com/hemilabs/heminetwork/releases/. Saya contohkan pake v0.8.0 :
   ```bash
   https://github.com/hemilabs/heminetwork/releases/download/v0.8.0/heminetwork_v0.8.0_linux_amd64.tar.gz
4. Lalu ekstrak file cli miner yang sudah di download :
   ```bash
   tar -xfv heminetwork_v0.8.0_linux_amd64.tar.gz
5. Masuk ke cd CLI Miner
   ```bash
   cd heminetwork_v0.8.0_linux_amd64
6. Langkah selanjutnya copy file fetchig fee
   ```bash
   cp hemi-network/auto-fee.sh .
7. Setelah itu edit file auto-fee.sh
   ```bash
   nano auto-fee.sh
tambahkan privat key di ```export POPM_BTC_PRIVKEY= (GANTI DENGA PRIVAT KEY TANPA TANDA KURUNG)``` 
lalu setting waktu auto teching fee di ``` sleep 600 ``` sesuikan keinginan, satuan dalam second/detik
9. Run CLI Miner
```bash
chmod ./auto-fee.sh && ./auto-fee.sh

