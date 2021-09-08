FROM debian:stable

MAINTAINER Jaime Roque <email@email.com>
LABEL Description="Debian (Stable)" Version="1.0"

# Install packages without prompting the user to answer any questions
ENV DEBIAN_FRONTEND noninteractive 

# Install packages
RUN echo "deb http://http.us.debian.org/debian stable main contrib non-free" >> /etc/apt/sources.list
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils
RUN apt-get update && apt-get install -y \
# apt-utils \
locales \
lsb-release \
mesa-utils \
git \
subversion \
vim-nox \
nano \
terminator \
xterm \
wget \
curl \
htop \
libssl-dev \
build-essential \
dbus-x11 \
mariadb-server \
software-properties-common \
gdb valgrind && \
apt-get clean && rm -rf /var/lib/apt/lists/*


# Locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8


# Terminator Config
RUN mkdir -p /root/.config/terminator/
COPY assets/terminator_config /root/.config/terminator/config 

# VIM Config
COPY assets/vim_config /root/.vimrc 

# Start MariaDB service
RUN service mariadb start

# Entry script - This will also run terminator
COPY assets/entrypoint_setup.sh /
ENTRYPOINT ["/entrypoint_setup.sh"]

# ---
CMD ["terminator"]
