#!/bin/sh

HOST=`ip route show | head --lines 1 | awk '{print $9}'`
cat $BASE_DIR/../custom-scripts/network-config | sed 's/\[IP-DO-HOST\]/'"$HOST"'/g' > $BASE_DIR/../custom-scripts/S41network-config
cp $BASE_DIR/../custom-scripts/S41network-config $BASE_DIR/target/etc/init.d
chmod +x $BASE_DIR/target/etc/init.d/S41network-config

# Ensure target directories exist
mkdir -p $BASE_DIR/target/usr/bin
mkdir -p $BASE_DIR/target/etc/init.d

# Copy monitor with error checking
if [ -f "$BASE_DIR/../apps/monitor" ]; then
    echo "Copying monitor app..."
    cp $BASE_DIR/../apps/monitor $BASE_DIR/target/usr/bin/monitor
    echo "Copying monitor init.d script..."
    cp $BASE_DIR/../custom-scripts/monitor $BASE_DIR/target/etc/init.d/S50monitor
    chmod +x $BASE_DIR/target/etc/init.d/S50monitor
    echo "Monitor setup complete"
else
    echo "ERROR: monitor app not found at $BASE_DIR/../apps/monitor"
fi
# cp $BASE_DIR/../apps/hello $BASE_DIR/target/usr/bin
# cp $BASE_DIR/../custom-scripts/hello $BASE_DIR/target/etc/init.d/S50hello
# chmod +x $BASE_DIR/target/etc/init.d/S50hello


