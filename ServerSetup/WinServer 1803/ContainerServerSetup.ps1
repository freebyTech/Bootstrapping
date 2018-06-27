$env:NODE_VERSION = '8.11.3'
$env:NODE_FULL_NAME = 'node-v8.11.3-win-x64'

$env:DOTNET_SDK_VERSION = '2.1.300'
$env:DOTNET_SDK_FULL_NAME = 'dotnet-sdk-2.1.300-win-x64'

$env:GIT_VERSION = '2.18.0'

New-Item -ItemType directory -Path /build;    

#Install node.js
Invoke-WebRequest https://nodejs.org/dist/v${env:NODE_VERSION}/${env:NODE_FULL_NAME}.zip -OutFile /build/node.zip;
Expand-Archive /build/node.zip -DestinationPath /build/nodejs-tmp;
Move-Item /build/nodejs-tmp/node-v${env:NODE_VERSION}-win-x64 ${env:ProgramFiles}/nodejs;
Remove-Item -Force /build/node.zip;

#Install .NET Framework 2.1 SDK
Invoke-WebRequest https://dotnetcli.blob.core.windows.net/dotnet/Sdk/${env:DOTNET_SDK_VERSION}/${env:DOTNET_SDK_FULL_NAME}.exe;
Start-Process /build/${env:DOTNET_SDK_FULL_NAME}.exe -ArgumentList '/quiet', '/norestart' -NoNewWindow -Wait; \
Remove-Item -Force /build/${env:DOTNET_SDK_FULL_NAME}.exe

#Install git version
Invoke-WebRequest -UseBasicParsing https://github.com/git-for-windows/git/releases/download/v${env:GIT_VERSION}.windows.1/MinGit-${env:GIT_VERSION}-64-bit.exe -outfile /build/git.zip; `
Expand-Archive /build/git.zip -DestinationPath $Env:ProgramFiles/git; `
Remove-Item -Force /build/git.zip

setx /M PATH $($Env:PATH + ';' + $Env:ProgramFiles + '/nodejs' + ';' + $Env:ProgramFiles + '/git/cmd')