#!/usr/bin/env bash

set -e

{
    # copy /app/velocity.jar to /proxy/velocity.jar if it doesn't exist
    if [ ! -f /proxy/velocity.jar ]; then
        echo "Velocity jar not found, copying from /app/velocity.jar"
        cp /app/velocity.jar /proxy/velocity.jar
    fi

    exec java \
        -Xms$MEMORYSIZE -Xmx$MEMORYSIZE \
        -XX:+UseG1GC \
        -XX:G1HeapRegionSize=4M \
        -XX:+UnlockExperimentalVMOptions \
        -XX:+ParallelRefProcEnabled \
        -XX:+AlwaysPreTouch \
        -XX:MaxInlineLevel=15 \
        -jar velocity.jar "$@"
}