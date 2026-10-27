#!/bin/bash
set -e

AAPT2="/home/aju/Android/Sdk/build-tools/35.0.0/aapt2"
ANDROID_JAR="/home/aju/Android/Sdk/platforms/android-33/android.jar"
SIGNAPK_JAR="/home/aju/Android/Cat/treble_app/signapk/signapk.jar"
PEM="/home/aju/Android/Cat/treble_app/keys/platform.x509.pem"
PK8="/home/aju/Android/Cat/treble_app/keys/platform.pk8"
OUT_DIR="build"

mkdir -p "$OUT_DIR"

echo "Compiling resources..."
"$AAPT2" compile --dir overlay/res -o "$OUT_DIR/resources.zip"

echo "Linking overlay APK..."
"$AAPT2" link -o "$OUT_DIR/treble-overlay-cat-s22-flip-unsigned.apk" \
    -I "$ANDROID_JAR" \
    --manifest overlay/AndroidManifest.xml \
    "$OUT_DIR/resources.zip"

echo "Signing APK with test platform key..."
LD_LIBRARY_PATH="/home/aju/Android/Cat/treble_app/signapk/" java -jar "$SIGNAPK_JAR" "$PEM" "$PK8" \
    "$OUT_DIR/treble-overlay-cat-s22-flip-unsigned.apk" \
    "treble-overlay-cat-s22-flip.apk"

echo "Successfully built treble-overlay-cat-s22-flip.apk!"
ls -lh treble-overlay-cat-s22-flip.apk
