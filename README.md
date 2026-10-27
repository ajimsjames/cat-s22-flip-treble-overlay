# Cat S22 Flip Treble Overlays

Targeted Runtime Resource Overlays (RRO) engineered specifically for the **Cat S22 Flip** (`armeabi-v7a`, Snapdragon 215 / QM215) running AOSP / Treble GSIs (e.g. VoltageOS / LineageOS Android 13, 14, 15).

---

## 1. Included Overlays

### A. Framework Overlay (`me.phh.treble.overlay.cats22flip`)
- **Target:** `android`
- **Carrier & IMS Overrides:**
  - `config_carrier_volte_available = true`
  - `config_carrier_vt_available = true`
  - `config_carrier_wfc_ims_available = true`
  - `config_device_volte_available = true`
  - `config_device_vt_available = true`
  - `config_device_wfc_ims_available = true`
  - `config_dynamic_bind_ims = true`
- **UI & Display Adaptations:**
  - `config_showNavigationBar = false` (Disables software navigation bar to reclaim screen real-estate for the physical keypad)
  - `navigation_bar_height = 0dp`
  - `status_bar_height_portrait = 20dp` (Ultra-compact status bar for 2.8" 480x640 display)
- **Audio Steps:**
  - `config_audio_vol_steps_call = 25` (Granular call speaker control)
  - `config_audio_vol_steps_music = 30` (Granular media control)

### B. SystemUI Overlay (`me.phh.treble.overlay.cats22flip.systemui`)
- **Target:** `com.android.systemui`
- **Quick Settings Grid Optimization:**
  - `quick_settings_num_columns = 2`
  - `quick_settings_max_rows = 2` (2x2 grid per page, preventing notification cutoff)
  - `quick_settings_paginated_grid_num_rows = 2`
  - `quick_qs_panel_max_rows = 1` (Collapsed shade shows 1 row of 2 tiles)
  - `quick_qs_panel_max_tiles = 2`
- **QS Tile Dimensions:**
  - `qs_tile_height = 50dp` (Sleek, low-profile pill design down from stock 80dp)
  - `qs_tile_padding = 6dp`
  - `qs_tile_margin_horizontal = 4dp`
  - `qs_tile_margin_vertical = 4dp`
  - `qs_tile_text_size = 12sp`
  - `qs_tile_secondary_text_size = 10sp`

---

## 2. Building

Run the automated build script:
```bash
./build.sh
```

Outputs:
- `treble-overlay-cat-s22-flip.apk`
- `treble-overlay-cat-s22-flip-systemui.apk`

---

## 3. Installation

Copy the APKs to `/system/product/overlay/` with permissions `0644`:
```bash
cp treble-overlay-cat-s22-flip*.apk /system/product/overlay/
chmod 644 /system/product/overlay/treble-overlay-cat-s22-flip*.apk
chcon u:object_r:system_file:s0 /system/product/overlay/treble-overlay-cat-s22-flip*.apk
```
