# Accumulate Devnet Verifier
Write-Host "== Accumulate Devnet Verifier ==" -ForegroundColor Cyan
Write-Host "Testing devnet health and connectivity..." -ForegroundColor White
Write-Host ""

# Check Docker container
Write-Host "1. Checking Docker container..." -ForegroundColor Yellow
$containerInfo = docker ps 2>$null | findstr "devnet-accumulate-instance"
if ($containerInfo) {
    Write-Host "   Container found and running" -ForegroundColor Green
} else {
    Write-Host "   Container not found or not running" -ForegroundColor Red
}

Write-Host ""

# Check TCP port
Write-Host "2. Testing port 26660..." -ForegroundColor Yellow
$tcpTest = Test-NetConnection -ComputerName "localhost" -Port 26660 -InformationLevel Quiet -WarningAction SilentlyContinue
if ($tcpTest) {
    Write-Host "   Port 26660 is accessible" -ForegroundColor Green
} else {
    Write-Host "   Port 26660 is not accessible" -ForegroundColor Red
}

Write-Host ""

# Test API
Write-Host "3. Testing API..." -ForegroundColor Yellow
$body = '{"jsonrpc":"2.0","id":1,"method":"network-status","params":{}}'
try {
    $response = Invoke-RestMethod -Uri "http://localhost:26660/v3" -Method Post -ContentType "application/json" -Body $body -TimeoutSec 10
    if ($response.result.network.networkName) {
        Write-Host "   API responding correctly" -ForegroundColor Green
        Write-Host "   Network: $($response.result.network.networkName)" -ForegroundColor Cyan
        Write-Host "   Directory Height: $($response.result.directoryHeight)" -ForegroundColor Cyan
    } else {
        Write-Host "   Invalid API response" -ForegroundColor Red
    }
} catch {
    Write-Host "   API call failed" -ForegroundColor Red
}

Write-Host ""
Write-Host "Verification completed!" -ForegroundColor Green
Write-Host "API Endpoint: http://localhost:26660/v3" -ForegroundColor Cyan
Write-Host "Explorer: http://localhost:3002/" -ForegroundColor Cyan