#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "🔹 Updating Termux..."
pkg update -y && pkg upgrade -y

echo "🔹 Checking required Termux packages..."

install_pkg() {
    if pkg list-installed | grep -q "^$1/"; then
        echo "✅ $1 already installed"
    else
        echo "📦 Installing $1..."
        pkg install -y $1
    fi
}

install_pkg proot-distro
install_pkg x11-repo

echo "🔹 Checking Ubuntu installation..."

UBUNTU_ROOT="$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu"

if [ -d "$UBUNTU_ROOT" ]; then
    echo "✅ Ubuntu already installed, skipping"
else
    echo "📦 Installing Ubuntu..."
    proot-distro install ubuntu
fi

echo "🔹 Configuring Ubuntu GUI & VNC..."

proot-distro login ubuntu -- bash << 'EOF'
set -e

echo "🔹 Updating Ubuntu..."
apt update -y && apt upgrade -y

install_apt() {
    if dpkg -s "$1" >/dev/null 2>&1; then
        echo "✅ $1 already installed"
    else
        echo "📦 Installing $1"
        apt install -y $1
    fi
}

install_apt xfce4
install_apt xfce4-goodies
install_apt tigervnc-standalone-server
install_apt dbus-x11
install_apt nano

echo "🔹 Setting up VNC..."

mkdir -p ~/.vnc

if [ ! -f ~/.vnc/xstartup ]; then
cat << 'EOT' > ~/.vnc/xstartup
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4 &
EOT
chmod +x ~/.vnc/xstartup
echo "✅ xstartup created"
else
echo "✅ xstartup already exists"
fi

if [ ! -f ~/.config/tigervnc/passwd ]; then
echo "🔐 Setting VNC password (123456)"
printf "123456\n123456\nn\n" | vncpasswd
else
echo "✅ VNC password already set"
fi

echo "🔹 Starting VNC server once for verification..."
vncserver -localhost no :1

echo "🔹 Stopping VNC server..."
vncserver -kill :1

echo "🔹 Ubuntu setup completed. Exiting Ubuntu..."
exit
EOF

echo ""
echo "✅ INSTALLATION SUCCESSFUL!"
echo ""
echo "📌 MANUAL USAGE GUIDE"
echo "────────────────────────────"
echo "👉 Login to Ubuntu:"
echo "   proot-distro login ubuntu"
echo ""
echo "👉 Start VNC server:"
echo "   proot-distro login ubuntu -- vncserver -localhost no :1"
echo ""
echo "👉 Kill VNC server:"
echo "   proot-distro login ubuntu -- vncserver -kill :1"
echo ""
echo "👉 Open VNC Viewer and connect to:"
echo "   localhost:5901"
echo ""
echo "⚠️ Keep Termux running while using VNC"
echo "🎉 DONE!"

