# 🐧 Ubuntu GUI on Termux (XFCE + VNC)

Run a **full Ubuntu Linux desktop environment** on Android using **Termux**, **XFCE**, and **VNC** — no root required.

This project provides a **one-click installer script** that:

* Installs Ubuntu only once
* Configures XFCE desktop
* Sets up TigerVNC server
* Is safe to re-run anytime
* Works well even on low-RAM devices

---

## ✨ Features

* ✅ One-time automatic setup
* 🔁 Re-runnable (no duplicate installs)
* 🖥️ XFCE desktop (fast & lightweight)
* 🔐 Password-protected VNC access
* 📱 Works on most Android phones
* ❌ No root required

---

## 📦 Requirements

* Android 8 or higher
* **Termux** (latest version recommended)
* Minimum ~2 GB free storage
* Stable internet connection

---

## 🚀 Installation (Copy & Paste)

Open **Termux** and run the following commands:

```bash
pkg update -y && pkg upgrade -y
pkg install git -y
git clone https://github.com/Analyst-abdul/Ubuntu-termux.git
cd Ubuntu-termux
chmod +x install-ubuntu-gui.sh
./install-ubuntu-gui.sh
```

⏳ **First installation may take several minutes** depending on your internet speed.

---

## ✅ After Installation

When the script finishes, you will see:

```
INSTALLATION SUCCESSFUL!
```

Ubuntu is now installed and configured.
The VNC server is **not running by default** to save RAM and avoid confusion.

---

## 🔑 How to Login to Ubuntu (Terminal Only)

```bash
proot-distro login ubuntu
```

Exit Ubuntu:

```bash
exit
```

---

## ▶️ How to Start the GUI (VNC Server)

```bash
proot-distro login ubuntu -- vncserver -localhost no :1
```

If successful, you will see:

```
New Xtigervnc server on port 5901
```

---

## ⏹️ How to Stop the GUI (Kill VNC Server)

```bash
proot-distro login ubuntu -- vncserver -kill :1
```

---

## 📱 How to View the Desktop (VNC Viewer)

### Step 1: Install VNC Viewer

Download **RealVNC Viewer** from Play Store:

👉 [https://play.google.com/store/apps/details?id=com.realvnc.viewer.android](https://play.google.com/store/apps/details?id=com.realvnc.viewer.android)

---

### Step 2: Create a New Connection

Open the VNC Viewer app and add a new connection with:

* **Address:** `localhost:5901`
* **Password:** `123456`

(Username is not required)

---

### Step 3: Connect 🎉

You should now see the **Ubuntu XFCE Desktop** running on your Android device.

---

## ⚠️ Important Notes

* Keep **Termux running** while using VNC
* Do not swipe Termux away from recent apps
* If the screen is black, restart the VNC server

---

## 🔁 Restart VNC Server (If Needed)

```bash
proot-distro login ubuntu -- vncserver -kill :1
proot-distro login ubuntu -- vncserver -localhost no :1
```

---

## 🧹 Uninstall Ubuntu (Optional)

```bash
proot-distro remove ubuntu
```

---

## ❤️ Credits

* Termux Project
* Ubuntu Project
* TigerVNC
* XFCE Desktop Environment

---

## 📜 License

MIT License
Free to use, modify, and share.

---

⭐ **If this project helped you, please give it a star on GitHub!**
