$env:NODE_VERSION = '8.11.3'
$env:NODE_FULL_NAME = 'node-v8.11.3-win-x64'

$env:DOTNET_SDK_VERSION = '2.1.300'
$env:DOTNET_SDK_FULL_NAME = 'dotnet-sdk-2.1.300-win-x64'

$env:GIT_VERSION = '2.18.0'

New-Item -ItemType directory -Path /build;    

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Install node.js
$nodeUrl = https://nodejs.org/dist/v${env:NODE_VERSION}/${env:NODE_FULL_NAME}.zip
Write-Host "Downloading and installing node from $nodeUrl"
Invoke-WebRequest https://nodejs.org/dist/v${env:NODE_VERSION}/${env:NODE_FULL_NAME}.zip -OutFile /build/node.zip -UseBasicParsing;
Expand-Archive /build/node.zip -DestinationPath /build/nodejs-tmp;
Move-Item /build/nodejs-tmp/node-v${env:NODE_VERSION}-win-x64 ${env:ProgramFiles}/nodejs;
Remove-Item -Force /build/node.zip;
setx /M PATH $($Env:PATH + ';' + $Env:ProgramFiles + '/nodejs')

#Install .NET Framework 2.1 SDK
$dotnetFrameworkUrl = https://dotnetcli.blob.core.windows.net/dotnet/Sdk/${env:DOTNET_SDK_VERSION}/${env:DOTNET_SDK_FULL_NAME}.exe
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
$gitUrl = https://github.com/git-for-windows/git/releases/download/v${env:GIT_VERSION}.windows.1/Git-${env:GIT_VERSION}-64-bit.exe
Write-Host "Downloading and installing git from $gitUrl"
Invoke-WebRequest $gitUrl -outfile /build/git.exe -UseBasicParsing;
Start-Process /build/git.exe -ArgumentList '/VERYSILENT', '/NORESTART', '/SUPPRESSMSGBOXES', '/LOG', '/LOADINF=/build/git.conf' -NoNewWindow -Wait;
Remove-Item -Force /build/git.exe

# Install container components
Write-Host "Installing container components"
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force 
Install-Module DockerMsftProvider -Force 
Install-Package Docker -ProviderName DockerMsftProvider -Force 
Install-WindowsFeature containers 

# Restart computer for docker windows service and for all path variables
Write-Host "Restarting the computer"
Restart-Computer
