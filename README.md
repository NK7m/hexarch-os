# HexArch OS 🎮💣

HexArch OS is a next-generation, Arch-based Linux distribution crafted for pentesting professionals, cybersecurity enthusiasts, hackers, and developers who demand the very best in performance, flexibility, and aesthetics. Drawing inspiration from industry-leading distributions like Kali Linux, BlackArch, and Garuda Linux, HexArch OS is engineered to deliver a seamless, powerful, and visually stunning experience—right out of the box.

> **Are you a hacker, developer, or digital explorer? HexArch OS is your playground.**
> 
> Unlock the full potential of your hardware, automate your workflow, and dive deep into security research or software development with a system that never gets in your way. Whether you’re building, breaking, or gaming, HexArch OS is the ultimate toolkit for those who live on the edge of technology.

---

## 🚀 What is HexArch OS?

HexArch OS is not just another Arch spin. It is a complete transformation toolkit and curated experience that turns any vanilla Arch Linux installation into a fully branded, performance-optimized, and security-focused operating system. Whether you are a penetration tester, a competitive gamer, or a power user who wants it all, HexArch OS is designed to be your ultimate platform.

---

## ✨ Key Features

- **Pentesting Ready:**
  - Flexible toolkit selection: None, Minimal, or Full (with BlackArch repository integration for thousands of tools).
  - Access to hundreds of security, forensics, and penetration testing utilities.
  - Modular installer lets you choose exactly what you need.

- **Gaming Optimized:**
  - Pre-installed with the latest gaming essentials: `gamemode`, `mangohud`, `wine-staging`, `lutris`, `steam`, and Vulkan drivers for both native and Windows games.
  - Option to install the Zen kernel for maximum FPS and system responsiveness.
  - Tweaked system parameters and services for low latency and high throughput.

- **Customizable Desktop Experience:**
  - Choose your preferred Desktop Environment or Window Manager: Hyprland (Wayland), GNOME, or KDE Plasma.
  - All environments are pre-configured for performance and visual appeal.
  - Custom branding throughout: boot animation, GRUB theme, login screen, system menus, and more.

- **Automated, Modular Installer Script:**
  - Clean, interactive Bash script to convert any Arch Linux installation into HexArch OS.
  - Modular design: each step is optional and user-driven.
  - Automatically configures and enables essential services (NetworkManager, display manager, gamemoded, etc.).
  - Applies all branding, system tweaks, and package installations in one go.

- **Professional Branding:**
  - Easy-to-use folder structure for dropping in your own logos, themes, and animations.
  - Custom ASCII logo for neofetch, so your system always shows off its HexArch pride.
  - Consistent branding across boot, login, and desktop environments.

- **Community Driven & Open Source:**
  - Built with transparency and collaboration in mind.
  - Contributions, suggestions, and pull requests are always welcome!

---

## 📁 Folder Structure

Organize your custom branding and assets as follows:

```
branding/
  boot/
    plymouth/           # Your custom Plymouth theme (folder)
    grub/               # Your custom GRUB theme (folder)
  os-logo/
    login/              # Login screen logo (e.g. PNG)
    menu/               # Menu logo/icons (e.g. PNG)
  neofetch/
    hexarch_logo.txt    # ASCII logo for HexArch OS (for neofetch)
```

- **Plymouth:** Place your custom boot animation/theme here.
- **GRUB:** Place your custom GRUB theme here.
- **os-logo/login:** Place your login screen logo(s) here.
- **os-logo/menu:** Place your menu/system icon(s) here.
- **neofetch:** Place your ASCII logo for neofetch here.

---

## 🛠️ How to Use

1. **Install Arch Linux** as you normally would, using your preferred method (manual, script, or installer).
2. **Clone this repository** to your Arch system:
   ```bash
   git clone https://github.com/nk7m/hexarch-os.git
   cd hexarch-os
   ```
3. **Place your custom branding files** in the `branding/` directory as shown above.
4. **Run the installer script as root:**
   ```bash
   chmod +x convert-to-hexarch.sh
   sudo ./convert-to-hexarch.sh
   ```
5. **Follow the interactive prompts** to select your pentesting tools, desktop environment, and other options.
6. **Reboot** and enjoy your new HexArch OS experience!

---

## 🎮 Gaming & Security, Without Compromise

HexArch OS is built for users who want the flexibility and bleeding-edge power of Arch Linux, but with the convenience, polish, and focus of a professional security and gaming platform. Whether you are a pentester, a gamer, or both, HexArch OS gives you the tools and performance you need—without compromise.

- **Performance Tweaks:**
  - Zen kernel option for lower latency and better gaming.
  - Gamemode and Mangohud for real-time performance boosts and monitoring.
  - Optimized systemd and kernel parameters for gaming and security.

- **Security Tools:**
  - Minimal or full BlackArch integration for thousands of tools.
  - Easy updates and package management via pacman.

- **Aesthetics:**
  - Custom boot, login, and desktop branding.
  - Beautiful, modern themes for every environment.

---

## 💡 Why Choose HexArch OS?

- **All-in-One:** No need to choose between a gaming distro and a pentesting distro—HexArch OS is both.
- **Modular:** Only install what you need. No bloat, no unnecessary packages.
- **Cutting Edge:** Always up-to-date with the latest Arch packages and security patches.
- **Customizable:** Make it truly yours with easy branding and theming.
- **Community:** Built by and for the open-source community.

---

## 🤝 Contributing

Contributions are welcome! If you have ideas, bug reports, or want to add new features, please open an issue or submit a pull request. Help us make HexArch OS even better for everyone.

---

## 🙏 Credits

Made with passion by **Naitik Upadhyay**.

Special thanks to the open-source community and the projects that inspired HexArch OS, including Arch Linux, BlackArch, Kali Linux, Garuda Linux, and all the developers who make Linux great.

---

## 📜 License

HexArch OS is released under the MIT License. See [LICENSE](LICENSE) for details.

---

## 📷 Screenshots

*Coming soon! Show off your HexArch OS desktop and share your setup with the community!*

---

## 📣 Stay Connected

- [GitHub Issues](https://github.com/NK7m/hexarch-os/issues)
- [Discussions](https://github.com/NK7m/hexarch-os/discussions)
- [Instagram](https://instagram.com/naitik_7m) *(add your social links!)*

---

> "HexArch OS: Where security meets performance, and gaming meets freedom."
