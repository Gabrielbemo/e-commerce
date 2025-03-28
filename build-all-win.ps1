$services = @("config-server", "customer", "discovery", "order", "payment", "notification", "product", "gateway")

$buildFailed = $false

foreach ($service in $services) {
    $servicePath = "./services/$service"

    if (Test-Path $servicePath) {
        Write-Host "🚀 Building $service (Skipping Tests)..."
        Set-Location -Path $servicePath

        # Etapa para remover containers e imagens Docker antigas antes de criar novas
        Write-Host "🧹 Checking for old Docker containers and images for $service..."

        # Verifica e remove containers em execução
        $containers = docker ps -q -f "name=e-commerce-$service"
        if ($containers) {
            Write-Host "🛑 Stopping old Docker containers for e-commerce-$service..."
            docker stop $containers
            Write-Host "🚫 Old containers stopped for e-commerce-$service."
        } else {
            Write-Host "⚠️ No running containers found for e-commerce-$service."
        }

        # Remove containers parados (se existirem)
        $stoppedContainers = docker ps -aq -f "name=e-commerce-$service"
        if ($stoppedContainers) {
            Write-Host "🗑️ Removing stopped Docker containers for e-commerce-$service..."
            docker rm $stoppedContainers
            Write-Host "🗑️ Old containers removed for e-commerce-$service."
        }

        # Verifica e remove as imagens Docker com o prefixo "e-commerce-"
        $oldImages = docker images -q "e-commerce-$service"
        if ($oldImages) {
            Write-Host "🧹 Removing old Docker images for e-commerce-$service..."
            docker rmi -f $oldImages
            Write-Host "🗑️ Old images for e-commerce-$service removed."
        } else {
            Write-Host "⚠️ No old images found for e-commerce-$service. Skipping removal."
        }

        # Verifica se o mvnw existe antes de executar
        if (Test-Path "./mvnw") {
            & ../../mvnw clean package -DskipTests
            if ($LASTEXITCODE -ne 0) {
                Write-Host "❌ Build failed for $service"
                $buildFailed = $true
            }
        } else {
            Write-Host "⚠️ Skipping $service (mvnw not found)"
        }

        Set-Location -Path ../..
    } else {
        Write-Host "⚠️ Skipping $service (Directory not found)"
    }
}

# Mensagem final
if ($buildFailed) {
    Write-Host "❌ An error occurred in at least one service!"
    exit 1
} else {
    Write-Host "✅ All services have been compiled successfully!"
    exit 0
}
