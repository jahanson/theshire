param(
  [switch]$Verbose
)

if ($Verbose) {
  $VerbosePreference = "Continue"
}

$pluginPath = "$env:APPDATA\helm\plugins\helm-diff\bin"
$binaryPath = "$pluginPath\diff.exe"
$latestRelease = "https://github.com/databus23/helm-diff/releases/latest/download/helm-diff-windows-amd64.tgz"
$tempFile = "$env:TEMP\helm-diff.tgz"

function Update-HelmDiff {
  try {
    Write-Verbose "Checking for existing installation..."
    if (Test-Path $binaryPath) {
      Write-Host "Found existing helm-diff installation. Updating..."

      # Download latest release
      Write-Verbose "Downloading latest release..."
      try {
        Invoke-WebRequest -Uri $latestRelease -OutFile $tempFile -ErrorAction Stop
      }
      catch {
        Write-Error "Failed to download helm-diff: $_"
        exit 1
      }

      # Extract and move new binary
      Write-Verbose "Extracting new binary..."
      try {
        tar -xf $tempFile -C $pluginPath "diff/bin/diff.exe"
        Move-Item "$pluginPath\diff\bin\diff.exe" $pluginPath -Force
        Remove-Item -Path "$pluginPath\diff" -Recurse -Force
      }
      catch {
        Write-Error "Failed to extract and move binary: $_"
        exit 1
      }

      # Cleanup
      Write-Verbose "Cleaning up temporary files..."
      Remove-Item $tempFile -ErrorAction SilentlyContinue

      Write-Host "helm-diff successfully updated at: $binaryPath"
      helm diff version
      exit 0
    }
    else {
      Write-Verbose "No existing installation found. Proceeding with new installation."
    }
  }
  catch {
    Write-Error "Update failed: $_"
    exit 1
  }
}

# Main script execution
Update-HelmDiff

# If no existing installation found, proceed with new installation
Write-Verbose "Installing helm-diff..."
try {
  New-Item -ItemType Directory -Force -Path $pluginPath | Out-Null

  # Download latest release
  Write-Verbose "Downloading latest release..."
  try {
    Invoke-WebRequest -Uri $latestRelease -OutFile $tempFile -ErrorAction Stop
  }
  catch {
    Write-Error "Failed to download helm-diff: $_"
    exit 1
  }

  # Extract and move binary
  Write-Verbose "Extracting binary..."
  try {
    tar -xf $tempFile -C $pluginPath "diff/bin/diff.exe"
    Move-Item "$pluginPath\diff\bin\diff.exe" $pluginPath -Force
    Remove-Item -Path "$pluginPath\diff" -Recurse -Force
  }
  catch {
    Write-Error "Failed to extract and move binary: $_"
    exit 1
  }

  # Cleanup
  Write-Verbose "Cleaning up temporary files..."
  Remove-Item $tempFile -ErrorAction SilentlyContinue

  Write-Host "helm-diff successfully installed at: $binaryPath"
  helm diff version
}
catch {
  Write-Error "Installation failed: $_"
  exit 1
}
