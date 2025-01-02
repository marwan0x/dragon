# Use the official Kali Linux Rolling image as the base
FROM kalilinux/kali-rolling

# Set the environment variable to skip interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Set the Go environment variables
ENV GOPATH=/usr/local/go
ENV PATH=$PATH:/usr/local/go/bin

# Update the package list and install Kali's meta-packages for all tools
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y

RUN apt-get install -y \
kali-linux-headless \
iputils-ping \
seclists \
jq

RUN apt-get install -y \
gospider \
hakrawler \
xsser \
subfinder \
golang-go \
eyewitness \
--fix-missing

COPY ./custom-tools/ /custom-tools/

RUN custom-tools/evine.sh;\
    custom-tools/rustscan.sh;\
    custom-tools/sstimap.sh;\
    custom-tools/waymore.sh;\
    custom-tools/xsstrike.sh;\
    custom-tools/waybackurls.sh;

RUN rm -rf /custom-tools

RUN apt-get autoremove -y && apt-get autoclean -y

# Set the default command to launch zsh
CMD ["zsh"]
