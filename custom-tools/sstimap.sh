git clone https://github.com/vladko312/SSTImap /opt/SSTImap
pip install -r /opt/SSTImap/requirements.txt --break-system-packages
echo "alias sstimap='/opt/SSTImap/sstimap.py'" >> /root/.zshrc
