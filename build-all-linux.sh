#!/bin/bash

# Verifica se a pasta services existe
if [ ! -d "./services" ]; then
    echo "❌ ERRO: Diretório ./services não encontrado!"
    exit 1
fi

# Lista automaticamente as pastas dentro de ./services
services=($(ls -d ./services/*/ | xargs -n 1 basename))

# Variável para rastrear erros
build_failed=false

# Percorre os serviços e compila cada um
for service in "${services[@]}"; do
    servicePath="./services/$service"

    if [ -d "$servicePath" ]; then
        echo "🚀 Building $service (Skipping Tests)..."
        cd "$servicePath"

        # Verifica se o mvnw existe dentro do serviço
        if [ ! -f "./mvnw" ]; then
            echo "⚠️ Skipping $service (mvnw not found)"
            cd ../..
            continue
        fi

        # Executa o mvnw local dentro do serviço
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

# Mensagem final
if [ "$build_failed" = true ]; then
    echo "❌ Ocorreu um erro em pelo menos um serviço!"
    exit 1
else
    echo "✅ Todos os serviços foram compilados com sucesso!"
    exit 0
fi
