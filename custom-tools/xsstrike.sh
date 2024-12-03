git clone https://github.com/s0md3v/XSStrike.git /opt/XSStrike
pip install -r /opt/XSStrike/requirements.txt --break-system-packages
echo "alias xsstrike='python /opt/XSStrike/xsstrike.py'" >> /root/.zshrc
