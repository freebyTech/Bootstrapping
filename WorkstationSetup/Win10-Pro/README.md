# Creating a Test / Development .NET Core and Docker Development Worstation for Windows 10

## Development Workstation Requirements
Although .NET Core Applications can be compiled and run on Windows, Linux, and Mac, these instructions only outline a Windows 10 Professional or Enterprise Edition computer installation. This has the advantage that it allows building and running both Windows Images and Ubuntu Images for .NET Core.

Either an automated or manual installation can be performed. The following is assumed either way:

1. The OS is either Windows 10 Professional and Enterprise editions, this is required for Docker Desktop for Windows 10 because of the need for HyperV support. 
2. The base Windows 10 Workstation is installed using standard settings for your environment and Domain.
3. The user performing the below installations will have administrative privilege on the computer or VM.
4. The OS is updated to all the Lastest Service Packs.

## Base Setup (Automated)
Follow the instructions below to perform a full install of all the components necessary to get a workstation setup for docker and .NET core development.

1. You have the ability to execute scripts on your local machine, even ones downloaded from the internet. If you don't you can run this powershell command to be able to execute scripts that are not signed.
```
Set-ExecutionPolicy Unrestricted -force
```
2. Run the following (from administrative powershell) to install containerization and required tools:
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Invoke-WebRequest https://raw.githubusercontent.com/temporafugiunt/DockerSetupInfo/develop/WorkstationSetup/Win10-Pro/ContainerWorkstationSetup.ps1 -outfile $env:TEMP/ContainerWorkstationSetup.ps1
Invoke-Expression $env:TEMP/ContainerWorkstationSetup.ps1
```
NOTE: Docker Desktop for Windows 10 doesn't currently have a sophisticated unattended installation (bug https://github.com/docker/for-win/issues/1322) and it can't be downloaded anonymously. Follow the instructions given in the URL below for Docker Desktop for Windows to obtain and install it manually.

## Base Setup (Manual)
If you are not allowed or prefer not to run scripts from public repositories, below is the list of required tools needed to run and also work with the source code for .NET Core Development with Container support.

## Required Tools
These tools are installed in the automated Base Setup (except Docker Desktop for Windows).

| Tool                               | URL                                                                 | Notes                                     |
| ---------------------------------- | ------------------------------------------------------------------- | ----------------------------------------- |
| Docker Desktop for Windows         | https://hub.docker.com/editions/community/docker-ce-desktop-windows | Requires a docker hub account to download and requires Windows 10 Professional or Enterprise Edition |
| Git for Windows                    | https://git-scm.com/download/win                                    |                                           |
| Install Latest .NET Core 2.1 SDK   | https://www.microsoft.com/net/download/windows                      |                                           |
| Install Latest LTS Version of Node | https://nodejs.org/en/                                              |                                           |
| HashiCorp Terraform                | https://www.terraform.io/downloads.html                             |                                           |

## Optional Support Tools
These tools are not installed in the automated Base Setup.

| Tool                               | URL                                              |
| ---------------------------------- | ------------------------------------------------ |
| Visual Studio Code                 | https://code.visualstudio.com/download           |
| Notepad++                          | https://notepad-plus-plus.org/download           |
| Tortoise Git                       | https://tortoisegit.org/download/                |
| Node Version Manager for Windows   | https://github.com/coreybutler/nvm-windows       |

## Testing Docker and Other Required Tools
1. Run the following to verify that all the support tools are properly installed and available.
```
git --version
dotnet --version
node -v
npm -v
code -v
```
2. Run the following to verify that Docker is properly installed and can download public images from the main Docker registry.
```
docker version 
docker info 
# run the hello-world container for full verification 
docker container run hello-world
```
