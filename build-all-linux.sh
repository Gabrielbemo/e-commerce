#!/bin/bash

if [ ! -d "./services" ]; then
    echo "❌ ERROR: ./services directory not found!"
    exit 1
fi

services=($(ls -d ./services/*/ | xargs -n 1 basename))

build_failed=false

for service in "${services[@]}"; do
    servicePath="./services/$service"

    if [ -d "$servicePath" ]; then
        echo "🚀 Building $service (Skipping Tests)..."
        cd "$servicePath"

        if [ ! -f "./mvnw" ]; then
            echo "⚠️ Skipping $service (mvnw not found)"
            cd ../..
            continue
        fi

        ./mvnw clean package -DskipTests
        if [ $? -ne 0 ]; then
            echo "❌ Build failed for $service"
            build_failed=true
        fi

        cd ../..
    else
        echo "⚠️ Skipping $service (Directory not found)"
    fi
done

if [ "$build_failed" = true ]; then
    echo "❌ An error occurred in at least one service"
    exit 1
else
    echo "✅ All services have been compiled successfully!"
    exit 0
fi
