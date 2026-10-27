#!/bin/bash
set -e

AAPT2="/home/aju/Android/Sdk/build-tools/35.0.0/aapt2"
ANDROID_JAR="/home/aju/Android/Sdk/platforms/android-33/android.jar"
SYSTEMUI_APK="/tmp/SystemUI.apk"
SETTINGS_APK="/tmp/Settings.apk"
SIGNAPK_JAR="/home/aju/Android/Cat/treble_app/signapk/signapk.jar"
PEM="/home/aju/Android/Cat/treble_app/keys/platform.x509.pem"
PK8="/home/aju/Android/Cat/treble_app/keys/platform.pk8"
OUT_DIR="build"

mkdir -p "$OUT_DIR"

echo "=== 1. Building Framework Overlay (android) ==="
"$AAPT2" compile --dir overlay/res -o "$OUT_DIR/framework-resources.zip"
"$AAPT2" link -o "$OUT_DIR/treble-overlay-cat-s22-flip-unsigned.apk" \
    -I "$ANDROID_JAR" \
    --manifest overlay/AndroidManifest.xml \
    "$OUT_DIR/framework-resources.zip"

LD_LIBRARY_PATH="/home/aju/Android/Cat/treble_app/signapk/" java -jar "$SIGNAPK_JAR" "$PEM" "$PK8" \
    "$OUT_DIR/treble-overlay-cat-s22-flip-unsigned.apk" \
    "treble-overlay-cat-s22-flip.apk"

echo "=== 2. Building SystemUI Overlay (com.android.systemui) ==="
"$AAPT2" compile --dir systemui-overlay/res -o "$OUT_DIR/systemui-resources.zip"
"$AAPT2" link -o "$OUT_DIR/treble-overlay-cat-s22-flip-systemui-unsigned.apk" \
    -I "$SYSTEMUI_APK" \
    -I "$ANDROID_JAR" \
    --manifest systemui-overlay/AndroidManifest.xml \
    "$OUT_DIR/systemui-resources.zip"

LD_LIBRARY_PATH="/home/aju/Android/Cat/treble_app/signapk/" java -jar "$SIGNAPK_JAR" "$PEM" "$PK8" \
    "$OUT_DIR/treble-overlay-cat-s22-flip-systemui-unsigned.apk" \
    "treble-overlay-cat-s22-flip-systemui.apk"

echo "=== 3. Building Settings Overlay (com.android.settings) ==="
"$AAPT2" compile --dir settings-overlay/res -o "$OUT_DIR/settings-resources.zip"
"$AAPT2" link -o "$OUT_DIR/treble-overlay-cat-s22-flip-settings-unsigned.apk" \
    -I "$SETTINGS_APK" \
    -I "$ANDROID_JAR" \
    --manifest settings-overlay/AndroidManifest.xml \
    "$OUT_DIR/settings-resources.zip"

LD_LIBRARY_PATH="/home/aju/Android/Cat/treble_app/signapk/" java -jar "$SIGNAPK_JAR" "$PEM" "$PK8" \
    "$OUT_DIR/treble-overlay-cat-s22-flip-settings-unsigned.apk" \
    "treble-overlay-cat-s22-flip-settings.apk"

echo "=== Build Complete ==="
ls -lh treble-overlay-cat-s22-flip*.apk
