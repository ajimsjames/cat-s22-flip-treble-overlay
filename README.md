# Cat S22 Flip Treble Framework Overlay (RRO)

This repository contains the standalone **Runtime Resource Overlay (RRO)** for the **Cat S22 Flip** (`armeabi-v7a`, Snapdragon 215 / QM215).

When running **Generic System Images (GSIs)** (Android 11 through Android 15+ / VoltageOS, LineageOS, PixelExperience, PHH-Treble), this overlay configures Android's `framework-res` (`android`) to properly recognize and drive the physical flip phone hardware.

---

## 🎯 Configurations Overlaid

| Config Key | Value | Purpose |
| :--- | :--- | :--- |
| `config_inCallPowerBehavior` | `2` | Configures Red End Call key (`KEY_POWER` on `qpnp_pon`) to immediately hang up calls. |
| `config_endcallBehavior` | `true` | Enables end-call handling on hardware power events. |
| `config_lidKeyboardAccessibility` | `0` | Disables keyboard access restrictions when lid is closed. |
| `config_lidNavigationAccessibility` | `0` | Disables navigation access restrictions when lid is closed. |
| `config_lidOpenRotation` | `-1` | Prevents rotation lock when opening the flip. |
| `config_lidControlsSleep` | `1` | Tells Android framework to trigger sleep when flip closes. |
| `config_lidControlsScreenOff` | `1` | Tells Android display controller to turn off screen on lid close. |
| `config_showNavigationBar` | `false` | Disables software navigation bar (Cat S22 has physical D-pad/keys). |
| `rounded_corner_radius` | `0dp` | Removes virtual rounded corner rendering for native rectangular LCD. |
| `config_defaultRefreshRate` | `60` | Hardware refresh rate clamp to 60Hz. |

---

## 📦 Installation on Any GSI

1. **Mount System as Read-Write / via Magisk / Root:**
   ```bash
   adb root
   adb remount
   ```
2. **Copy to System Overlays:**
   ```bash
   adb push treble-overlay-cat-s22-flip.apk /system/product/overlay/
   adb shell chmod 0644 /system/product/overlay/treble-overlay-cat-s22-flip.apk
   ```
3. **Reboot:**
   ```bash
   adb reboot
   ```

---

## 🛠️ Building from Source

Requirements:
- Android SDK Build-Tools (`aapt2`)
- Java Runtime (`java`)

Run:
```bash
./build.sh
```
The output APK is generated at `treble-overlay-cat-s22-flip.apk`.
