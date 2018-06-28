# Creating an Test / Development .NET Core and Docker Server for Windows Server 1803
1803 Servers are servers wthout Desktop Experience, so they can be fully installed by command line. Follow the instructions below to perform a full install of all the components necessary to get a server setup for docker and .NET core development.
1. Install your windows server from a base 1803 image, rename or join an active directory if appropriate.
2. Run the following powershell script to install all components necessary.
```
powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Invoke-WebRequest https://raw.githubusercontent.com/temporafugiunt/DockerSetupInfo/develop/ServerSetup/WinServer%201803/ContainerServerSetup.ps1 -outfile $env:TEMP/ContainerServerSetup.ps1
Invoke-Expression $env:TEMP/ContainerServerSetup.ps1
```
