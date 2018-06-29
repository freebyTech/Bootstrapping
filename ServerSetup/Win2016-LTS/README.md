# Creating a Test / Development .NET Core and Docker Server

## Base Setup (Automated)
Follow the instructions below to perform a full install of all the components necessary to get a server setup for docker and .NET core development.
1. Install the base 2016 Server using standard settings for your environment and Domain.
2. Update to all the Lastest Service Packs.
3. Run the following (from powershell) to install containerization and required tools:
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Invoke-WebRequest https://raw.githubusercontent.com/temporafugiunt/DockerSetupInfo/develop/ServerSetup/WinServer%201803/ContainerServerSetup.ps1 -outfile $env:TEMP/ContainerServerSetup.ps1
Invoke-Expression $env:TEMP/ContainerServerSetup.ps1
```

## Base Setup (Manual)
1. Install the base 2016 Server using standard settings for your environment and Domain.
2. Update to all the Lastest Service Packs.
3. Run the following to install containerization:
```
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force 
Install-Module DockerMsftProvider -Force 
Install-Package Docker -ProviderName DockerMsftProvider -Force 
Install-WindowsFeature containers 
# Restart computer or potentially just start the Docker windows service. 
Restart-Computer
```
## Installing Required Tools (Manual)
These tools are already installed in the automated Base Setup.
| Tool                               | URL                                              |
| ---------------------------------- | ------------------------------------------------ |
| Git for Windows                    | https://git-scm.com/download/win                 |
| Install Latest .NET Core SDK       | https://www.microsoft.com/net/download/windows   |
| Install Latest LTS Version of Node | https://nodejs.org/en/                           |
## Installing Optional Support Tools (Manual)
These tools are not installed in the automated Base Setup.
| Tool                               | URL                                              |
| ---------------------------------- | ------------------------------------------------ |
| Notepad++                          | https://notepad-plus-plus.org/download           |
| Tortoise Git                       | https://tortoisegit.org/download/                |
| Visual Studio Code                 | https://code.visualstudio.com/download           |
| Node Version Manager for Windows   | https://github.com/coreybutler/nvm-windows       |
## Testing Docker and Other Required Tools
1. Run the following to verify that all the support tools are properly installed and available.
```
git --version
dotnet --version
node -v
npm -v
```
2. Run the following to verify that Docker is properly installed and can download images from the main Docker registry.
```
docker version 
docker info 
# run the hello-world container for full verification 
docker container run hello-world:nanoserver
```
