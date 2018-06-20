# Creating a Test / Development .NET Core and Docker Server
## Base Setup
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
## Testing Docker
1. Run the following to verify that Docker is properly installed and can download images from the main Docker registry.
```
docker version 
docker info 
# run the hello-world container for full verification 
docker container run hello-world:nanoserver
```
## Installing Required Tools
| Tool                               | URL                                              |
| ---------------------------------- | ------------------------------------------------ |
| Git for Windows                    | https://git-scm.com/download/win                 |
| Install Latest .NET Core SDK       | https://www.microsoft.com/net/download/windows   |
| Install Latest LTS Version of Node | https://nodejs.org/en/                           |
## Installing Optional Support Tools
| Tool                               | URL                                              |
| ---------------------------------- | ------------------------------------------------ |
| Notepad++                          | https://notepad-plus-plus.org/download           |
| Tortoise Git                       | https://tortoisegit.org/download/                |
| Visual Studio Code                 | https://code.visualstudio.com/download           |
| Node Version Manager for Windows   | https://github.com/coreybutler/nvm-windows       |