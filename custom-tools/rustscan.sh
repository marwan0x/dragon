mkdir -p /opt/rustscan
wget $(curl -s https://api.github.com/repos/RustScan/RustScan/releases/latest | jq -r '(.assets[].browser_download_url | select(. | contains("_amd64.deb")))') -O /opt/rustscan/rustscan_latest.deb
dpkg -i /opt/rustscan/rustscan_latest.deb
