# Invoke-ServiceAction
PowerShell Service Manager A helpful tool to check and control Windows Services. It allows you to see the status of a service and decide whether to Start it, Stop it, or simply View its current state.
Features
Safe Checks: It verifies if a service exists before trying to change it, preventing red error messages.

Logic-Aware: If you try to start a service that is already running, it tells you instead of trying to start it again.

Default Mode: If no action is chosen, it simply reports the current status (Running or Stopped).

Pipeline Friendly: You can check multiple services at once.

How to Use

1. Check Service Status (No Action)
By default, the script will just tell you if the service is running or stopped.

PowerShell
CheckServiceAndAction -ServiceName "Spooler"

2. Start or Stop a Service
You can force a specific action using the -Action parameter.

PowerShell
CheckServiceAndAction -ServiceName "wuauserv" -Action Start

3. Manage Multiple Services
You can send a list of service names through the pipeline to check them all at once.

PowerShell
"Spooler", "wuauserv", "bits" | CheckServiceAndAction -Action Nothing
Parameters
$ServiceName: The internal name of the Windows Service (e.g., "bits", "LanmanWorkstation").

$Action: Choose between Start, Stop, or Nothing (default).
