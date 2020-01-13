#!/bin/bash

# Download necessary packages
dpkg --add-architecture i386
apt-get update
apt-get install --no-install-recommends -y \
	ca-certificates \
	cabextract \
	net-tools \
	novnc \
	passwd \
	procps \
	sudo \
	supervisor \
	wget \
	wine \
	wine32 \
	wine64 \
	x11vnc \
	xauth \
	xvfb \
	unzip
ln -s /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html

# Download Winetricks
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -O /usr/bin/winetricks
chmod +x /usr/bin/winetricks

# Add server user
useradd -mrU torch-server

# Copy supervisord.conf
cp supervisord.conf /opt/torch-server/supervisord.conf
chown torch-server:torch-server /opt/torch-server/supervisord.conf

# Setup Wine environment and install dependencies as server user
sudo -i -u torch-server bash << EOF
	winetricks sound=disabled
	winetricks vd=800x600
	winetricks windowmanagermanaged=n
	W_OPT_UNATTENDED=1 WINEPREFIX=/home/torch-server/.wine xvfb-run winetricks \
		arial \
		dotnet462 \
		vcrun2013 \
		vcrun2017 \
	2>/dev/null
EOF

# Install Torch server
./update.sh
