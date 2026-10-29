$ErrorActionPreference = 'Stop'
$finaciRoot = Split-Path -Parent $PSScriptRoot
Push-Location $finaciRoot
try {
  flutter build web --release --dart-define=API_BASE=/api
  if ($LASTEXITCODE -ne 0) { throw 'Flutter web build failed.' }
  $finaciPublic = Join-Path $finaciRoot 'mock_server/public'
  New-Item -ItemType Directory -Path $finaciPublic -Force | Out-Null
  Copy-Item -Path (Join-Path $finaciRoot 'build/web/*') -Destination $finaciPublic -Recurse -Force
  Write-Output 'Ready: npx vercel --cwd mock_server --prod'
} finally {
  Pop-Location
}
