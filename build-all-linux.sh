#!/bin/bash

services=("config-server", "customer", "discovery", "order", "payment", "notification", "product", "gateway")

for service in "${services[@]}"; do
    servicePath="./services/$service"

    if [ -d "$servicePath" ]; then
        echo "🚀 Building $service (Skipping Tests)..."
        cd "$servicePath"
        ../../mvnw clean package -DskipTests
        cd ../..
    else
        echo "Skipping $service (Directory not found)"
    fi
done
