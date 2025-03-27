$services = @("config-server", "customer", "discovery", "order", "payment", "notification", "product", "gateway")

$buildFailed = $false

foreach ($service in $services) {
    $servicePath = "./services/$service"

    if (Test-Path $servicePath) {
        Write-Host "🚀 Building $service (Skipping Tests)..."
        Set-Location -Path $servicePath

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
