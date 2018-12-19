$env:NODE_VERSION = '8.11.3'
$env:NODE_FULL_NAME = "node-v${env:NODE_VERSION}-win-x64"

$env:DOTNET_SDK_VERSION = '2.1.300'
$env:DOTNET_SDK_FULL_NAME = "dotnet-sdk-${env:DOTNET_SDK_VERSION}-win-x64"

$env:GIT_VERSION = '2.18.0'
$end:GIT_FULL_NAME = "Git-${env:GIT_VERSION}-64-bit.exe"

$env:TERRAFORM_VERSION = '0.11.11'
$env:TERRAFORM_FULL_NAME = "terraform_${$env:TERRAFORM_VERSION}_windows_amd64"

New-Item -ItemType directory -Path /build;    

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Install node.js
$nodeUrl = "https://nodejs.org/dist/v${env:NODE_VERSION}/${env:NODE_FULL_NAME}.zip"
Write-Host "Downloading and installing node from $nodeUrl"
Invoke-WebRequest $nodeUrl -OutFile /build/node.zip -UseBasicParsing;
Expand-Archive /build/node.zip -DestinationPath /build/nodejs-tmp;
Move-Item /build/nodejs-tmp/node-v${env:NODE_VERSION}-win-x64 ${env:ProgramFiles}/nodejs;
Remove-Item -Force /build/node.zip;
setx /M PATH $($Env:PATH + ';' + $Env:ProgramFiles + '/nodejs')

#Install .NET Framework 2.1 SDK
$dotnetFrameworkUrl = "https://dotnetcli.blob.core.windows.net/dotnet/Sdk/${env:DOTNET_SDK_VERSION}/${env:DOTNET_SDK_FULL_NAME}.exe"
Write-Host "Downloading and installing dotnet framwork from $dotnetFrameworkUrl"
Invoke-WebRequest $dotnetFrameworkUrl -OutFile /build/${env:DOTNET_SDK_FULL_NAME}.exe -UseBasicParsing;
Start-Process /build/${env:DOTNET_SDK_FULL_NAME}.exe -ArgumentList '/quiet', '/norestart' -NoNewWindow -Wait;
Remove-Item -Force /build/${env:DOTNET_SDK_FULL_NAME}.exe

#Install git and run install from a known config file.
@"
[Setup]
Lang=default
Dir=C:\Program Files\Git
Group=Git
NoIcons=0
SetupType=default
Components=icons,icons\quicklaunch,ext,ext\shellhere,ext\guihere,assoc,assoc_sh
Tasks=
PathOption=CmdTools
SSHOption=OpenSSH
CRLFOption=CRLFAlways
BashTerminalOption=MinTTY
PerformanceTweaksFSCache=Disabled
"@ | Out-File -FilePath /build/git.conf
$gitUrl = "https://github.com/git-for-windows/git/releases/download/v${env:GIT_VERSION}.windows.1/Git-${env:GIT_VERSION}-64-bit.exe"
Write-Host "Downloading and installing git from $gitUrl"
Invoke-WebRequest $gitUrl -outfile /build/git.exe -UseBasicParsing;
Start-Process /build/git.exe -ArgumentList '/VERYSILENT', '/NORESTART', '/SUPPRESSMSGBOXES', '/LOG', '/LOADINF=/build/git.conf' -NoNewWindow -Wait;
Remove-Item -Force /build/git.exe

# Install HashiCorp Terraform Support
$terraformUrl = "https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_windows_amd64.zip"
Write-Host "Downloading and installing terraform from $terraformUrl"
Invoke-WebRequest $terraformUrl -OutFile /build/terraform.zip -UseBasicParsing;
Expand-Archive /build/terraform.zip -DestinationPath /build/terraform-tmp;
Move-Item /build/terraform-tmp ${env:ProgramFiles}/terraform;
Remove-Item -Force /build/terraform.zip;
setx /M PATH $($Env:PATH + ';' + $Env:ProgramFiles + '/terraform')

# Restart computer for docker windows service and for all path variables
Write-Host "Restarting the computer"
Restart-Computer
