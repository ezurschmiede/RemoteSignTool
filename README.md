# Remote SignTool 

This tool can be used to automate EV Codesigning process on your build server.

### Notes on this fork
Quick noted changes: start/stop server support, Win64 Platform, small MultiThread improvement, modernization (Segoe UI font), control alignment, def port to 8099

AutoIt is not required. It's possible to provied the password in the signtool command line in the /kc parameter.

Example as batch:
``` 
SET SIGNTOOL="C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x64\signtool.exe"
%SIGNTOOL% sign /f "mycert.cer" /csp "eToken Base Cryptographic Provider" /kc "[{{PASSWORT}}]=p11#b891b4357e4ea5d6" /fd sha256 /tr "http://timestamp.digicert.com" /td sha256 /as /v TheFileToSign.exe
``` 

Credits goes to the SirAlex for publishing the original project.


### Limitations of EV Codesignig with SafeNet token:
1. You must login locally to buildserver. Or if you logged to server via RDP, you must attach token to local machine instead of server.
2. If you have more than one developer who want to build project with signing files, you can't do it, because you cannot replicate your token.
3. Windows service applications cannot sign files, because SafeNet denied this.

### Benefits of Remote SignTool
To pass (partially) this limitations, I'm made Client-Server application. You can run server at any machine where you can login locally and attach EV token.
Now you can have any number of build servers (or developer machines). On the client side, you call signttool client which send file to server via HTTP protocol and send signed file back. Client can act as regular signtool.exe, so no modifications needed in your build scripts.

### Limitations of Remote SignTool
You must login locally (you cannot use RDP) to machine with EV token attached and start server application. Once started you must press "Test and start" button. Also you must use AutoPin tool which automatically put password for your token if SafeNet dialog appear.

## How to use
### Requirements:
1. You must use TeamViewer or directly connect to admin console to server with EV token installed.
  a) If you will use TeamViewer, you **must set on TV's client side "Never" for "Lock remote computer" option**,(Go to Advanced settings ->  "Advanced settings for connections to remote computers).
  b) **Do not logout from session after launching RemoteSignTool server!**
2. You must set "Enable single logon" in the SafeNet Auth client Tools (Advanced View -> Client Settings -> Advanced)
3. Please, use **Delphi XE8 Upd1** to compile project OR you can use prebuilt binaries from [Releases page](https://github.com/SirAlex/RemoteSignTool/releases)
4. Use AutoIt to build AutoPin.au3 script.

### Usage:
1. Login to computer where you placed this tool (server side). This can be build server itself. If you have access to admin console (locally or via TeamViewer).
2. Start AutoPin.exe with EV token passowrd as first argument:
``` 
AutoPin.exe YourPassHere
```
3. Start RemoteSignTool_Server.exe. Press "Test and start" button (OR specify **-autostart** cmd line switch to automatically test and start HTTP server). This will launch signtool on test file, if file successfully signed, HTTP server start and will ready to accept remote connections.
4. Do not lock console. Close TeamViewer or leave console as-is.
5. Edit ```Client/RemoteSignTool_Client.ini``` and set the host property to point to the server.
6. Now you can use RemoteSignTool_Client.exe to sign files remotely (or locally if you are instelled all parts on single machine - preferred)
