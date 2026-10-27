# Cat S22 Flip Treble Framework Overlay

A production-grade Runtime Resource Overlay (RRO) specifically crafted for the **Cat S22 Flip** running modern Treble Generic System Images (GSIs) such as Android 14 and Android 15 (e.g. VoltageOS, LineageOS, PixelExperience).

## Key Capabilities & Fixes

1. **Cellular IMS & VoLTE 4G Calling Persistence:**
   - Forces the presence of VoLTE / 4G calling settings even across factory resets:
     - `config_carrier_volte_available = true`
     - `config_device_volte_available = true`
     - `config_carrier_wfc_ims_available = true` (Wi-Fi Calling)
     - `config_dynamic_bind_ims = true`
   - Integrates with Qualcomm CAF IMS stack automatically without manual toggle requirements in Treble App.

2. **2.8-Inch Display & UI Optimization:**
   - **Eliminates On-Screen Navigation Bar:** Cat S22 Flip features physical hardware keypad buttons (Back, Home, App Switch). Disables software navbar (`config_showNavigationBar = false` and `navigation_bar_height = 0dp`), recovering over 70 vertical pixels across all apps.
   - **Compact Status Bar:** Replaces oversized system status bars with a proportional `20dp` height that fits the small 480x640 display without eating 15-20% of the screen.
   - **Corner Bounds:** Removes unnecessary artificial rounded display corner cutouts (`rounded_corner_radius = 0dp`).

3. **Physical Keypad & D-Pad Navigation:**
   - Enables high-visibility focus highlight (`config_defaultFocusHighlightEnabled = true`) for intuitive navigation across textboxes, lists, and toggles using the physical directional D-pad.
   - Notifies Android InputMethodManager that a permanent hardware keyboard and menu keys are present (`config_hasPermanentMenuKey = true`, `config_hasKeyboard = true`).
   - Enables native physical keypress audio click feedback (`config_sendAudioWhenHardwareKeyboardUsed = true`).

4. **Flip / Lid & Hardware In-Call Button Behavior:**
   - Configures Hall sensor lid sleep/wake (`config_lidControlsSleep = 1`).
   - Programs hardware End Call button (☎ / ⏻) to immediately hang up calls (`config_inCallPowerBehavior = 2`, `config_endcallBehavior = true`).

## Building

```bash
bash build.sh
```

Outputs the signed overlay APK: `treble-overlay-cat-s22-flip.apk`

## Installation

### Method 1: System Image Integration (Permanent Across Factory Resets)
Place the APK directly in your GSI system partition:
```bash
/system/product/overlay/treble-overlay-cat-s22-flip.apk
```
Set permissions to `0644` (`chmod 644`) and SELinux label `u:object_r:system_file:s0`.

### Method 2: Live Installation via ADB
```bash
adb install -r treble-overlay-cat-s22-flip.apk
adb shell cmd overlay enable --user 0 me.phh.treble.overlay.cats22flip
```
