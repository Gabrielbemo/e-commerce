$services = @("config-server", "customer", "discovery", "order", "payment", "notification", "product", "gateway")

foreach ($service in $services) {
    $servicePath = "./services/$service"

        if (Test-Path $servicePath) {
            Write-Host "Building $service..."
            Set-Location -Path $servicePath
            ../../mvnw clean package -DskipTests
            Set-Location -Path ../..
        } else {
            Write-Host "Skipping $service (Directory not found)"
        }
}
