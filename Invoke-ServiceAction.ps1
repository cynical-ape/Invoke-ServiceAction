function Invoke-ServiceAction {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$ServiceName,

        [Parameter(Mandatory=$false)]
        [ValidateSet("Start","Stop","Nothing")]
        [string]$Action = "Nothing"
    )

    process {
        # Check if service exists
        $Check = Get-Service $ServiceName -ErrorAction SilentlyContinue
        if ($null -eq $Check) {
            Write-Host "Please provide a valid service name: $ServiceName" -ForegroundColor Red
            return
        }

        $ServiceStatus = $Check.Status

        # Handle actions
        if ($ServiceStatus -eq 'Running' -and $Action -eq "Start") {
            Write-Host "$ServiceName is already running." -ForegroundColor Cyan
        }
        elseif ($ServiceStatus -eq 'Stopped' -and $Action -eq "Start") {
            Write-Host "Starting $ServiceName..." -ForegroundColor Green
            Start-Service -Name $ServiceName
            Write-Host "$ServiceName started successfully." -ForegroundColor Green
        }
        elseif ($ServiceStatus -eq 'Stopped' -and $Action -eq "Stop") {
            Write-Host "$ServiceName is already stopped." -ForegroundColor Cyan
        }
        elseif ($ServiceStatus -eq 'Running' -and $Action -eq "Stop") {
            Write-Host "Stopping $ServiceName..." -ForegroundColor Yellow
            Stop-Service -Name $ServiceName
            Write-Host "$ServiceName stopped successfully." -ForegroundColor Yellow
        }
        elseif ($Action -eq "Nothing") { 
            Write-Host "$ServiceName is $ServiceStatus ... No action selected." -ForegroundColor Yellow
        }
        else {
            Write-Host "Invalid action or service status combination for $ServiceName." -ForegroundColor Red
        }
    }
}

# Pipeline usage example
"Spooler", "wuauserv", "bits" | ForEach-Object { Invoke-ServiceAction $_ -Action Nothing }