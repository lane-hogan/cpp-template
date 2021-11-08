# C/C++ Project Template
Basic instructions for configuring and building a C/C++ project. Windows is the only supported platform for now, but more platforms will be added later once build systems are configured.

## Compiling on Windows
Be sure to install the C/C++ build tools from Visual Studio. Open a developer command prompt (or Powershell) 
and open your preferred text editor in the cloned repository. Run this command in either the developer command prompt
or your text editor's built-in terminal (i.e. VSCode):

`.\tools\win\build.bat`


## VSCode Setup
Create a directory called `.vscode` and add these files inside:

### c_cpp_properties.json
```jsonc
{
    "configurations": [
        {
            "name": "Win32",
            "includePath": [
                "${workspaceFolder}/**",
                "${workspaceFolder}/include"
            ],
            "defines": [
                "_DEBUG",
                "UNICODE",
                "_UNICODE"
            ],
            "windowsSdkVersion": "10.0.19041.0",
            "compilerPath": "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.27.29110\\bin\\Hostx64\\x64\\cl.exe",
            "cStandard": "c17",
            "cppStandard": "c++17",
            "intelliSenseMode": "windows-msvc-x64"
        }
    ],
    "version": 4
}
```

### launch.json
```jsonc
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(Windows) Launch",
            "type": "cppvsdbg",
            "request": "launch",
            "program": "${workspaceFolder}/bin/project_name.exe",
            "args": [],
            "symbolSearchPath": "${workspaceFolder}/bin",
            "stopAtEntry": false,
            "cwd": "${fileDirname}",
            "environment": [],
            "console": "integratedTerminal"
        }
    ]
}
```

### tasks.json
```jsonc
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "build",
            "type": "shell",
            "command": ".\\tools\\win\\build.bat",
            "args": [],
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "presentation": {
                "reveal": "silent"
            },
            "problemMatcher": "$msCompile"
        }
    ]
}
```
