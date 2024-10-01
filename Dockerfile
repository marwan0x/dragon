# Use the official Kali Linux Rolling image as the base
FROM kalilinux/kali-rolling

# Set the environment variable to skip interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install Kali's meta-packages for all tools
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get install -y kali-linux-headless && \
    apt-get clean

RUN apt-get install -y iputils-ping
RUN apt-get install -y gobuster
RUN apt-get install -y seclists

# Set the default command to launch zsh
CMD ["zsh"]

