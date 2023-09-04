#!/usr/bin/env bash

set -e

{
    # copy /app/purpur-1.20.1.jar to /server/purpur-1.20.1.jar if it doesn't exist
    if [ ! -f /server/purpur-1.20.1.jar ]; then
        echo "purpur-1.20.1 jar not found, copying from /app/purpur-1.20.1.jar"
        cp /app/purpur-1.20.1.jar /server/purpur-1.20.1.jar
    fi

    # copy /app/eula.txt to /server/eula.txt if it doesn't exist
    if [ ! -f /server/eula.txt ]; then
        echo "eula txt not found, copying from /app/eula.txt"
        cp /app/eula.txt /server/eula.txt
    fi

    exec java \
        -Xms$MEMORYSIZE -Xmx$MEMORYSIZE \
        --add-modules=jdk.incubator.vector \
        -XX:+UseG1GC -XX:+ParallelRefProcEnabled \
        -XX:MaxGCPauseMillis=200 \
        -XX:+UnlockExperimentalVMOptions \
        -XX:+DisableExplicitGC -XX:+AlwaysPreTouch \
        -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 \
        -XX:InitiatingHeapOccupancyPercent=15 \
        -XX:G1MixedGCLiveThresholdPercent=90 \
        -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 \
        -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 \
        -Dusing.aikars.flags=https://mcflags.emc.gs \
        -Daikars.new.flags=true -XX:G1NewSizePercent=30 \
        -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M \
        -XX:G1ReservePercent=20 \
        -jar purpur-1.20.1.jar "$@"
}