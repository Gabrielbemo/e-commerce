$services = @("config-server", "customer", "discovery", "order", "payment", "notification", "product", "gateway")

# Variável para rastrear erros
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
    Write-Host "❌ Ocorreu um erro em pelo menos um serviço!"
    exit 1
} else {
    Write-Host "✅ Todos os serviços foram compilados com sucesso!"
    exit 0
}
