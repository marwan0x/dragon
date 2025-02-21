# Use the official Kali Linux image as the base
# Using kali-last-release as the base image to make the build easier to cache 
FROM kalilinux/kali-last-release

# Set the environment variable to skip interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Set the Go environment variables
ENV GOPATH=/usr/local/go
ENV PATH=$PATH:/usr/local/go/bin

# Update the package list and install Kali's meta-packages for all tools
RUN apt-get update && \
    apt-get upgrade -y

# Main tools
RUN apt-get install -y \
    kali-system-cli \
    7zip \
    amass \
    bind9-dnsutils \
    dnsenum \
    dnsrecon \
    ffuf \
    hydra \
    iproute2 \
    iputils-ping \
    netcat-openbsd \
    nikto \
    nmap \
    openvpn \
    php \
    metasploit-framework \
    neovim \
    python-is-python3 \
    python3-pip \
    sqlmap \
    wafw00f \
    whatweb \
    whois \
    wordlists \
    wpscan \
    --fix-missing

# Extra tools
RUN apt-get install -y \
    seclists \
    jq \
    gospider \
    hakrawler \
    xsser \
    subfinder \
    golang-go \
    eyewitness \
    --fix-missing

COPY ./custom-tools/ /custom-tools/

# Custom tools
RUN custom-tools/evine.sh;\
    custom-tools/rustscan.sh;\
    custom-tools/sstimap.sh;\
    # custom-tools/waymore.sh;\
    custom-tools/xsstrike.sh;\
    custom-tools/waybackurls.sh;\
    rm -rf /custom-tools

RUN apt-get autoremove -y && apt-get autoclean -y

RUN go install -v github.com/tomnomnom/anew@master && \
    go install github.com/tomnomnom/assetfinder@master && \
    go install github.com/tomnomnom/httprobe@master && \
    go install github.com/tomnomnom/fff@master

# Create a group and user with UID 1000 and GID 1000
RUN groupadd -g 1000 w1nt3r && \
    useradd -m -u 1000 -g w1nt3r -s /bin/zsh w1nt3r

# Install sudo and grant w1nt3r full privileges
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/* && \
    echo "w1nt3r ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN chown -R w1nt3r:w1nt3r /home/w1nt3r/
# Switch to the new user
USER w1nt3r

# Set the default command to launch zsh
CMD ["zsh"]
