@ECHO off

set project_name=project_name

ECHO setting up...
ECHO.

:: IF NOT EXIST bin\win64\concrt140.dll (
::     COPY "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Redist\MSVC\14.29.30133\x64\Microsoft.VC124.CRT\*.dll" bin\win64
:: )

ECHO compiling...

:: unused variables:            /wd4100
:: non-constant aggreg. init:   /wd4204
:: _every_ type conversion:     /wd4244 /wd4242
:: hiding previous decls:       /wd4456
:: hiding global decl:          /wd4459
:: "../" in an include:         /wd4464
:: inline not performed:        /wd4710
:: padding was added:           /wd4820
:: narrowing conversions:       /wd4838
:: foo() instead of foo(void):  /wd4255
:: warning C4706: assignment within conditional expression -- happens even with enclosing parentheses, really annoying.
:: produced by Windows headers themselves:
::      warning C4668: "_WIN32_WINNT_WIN10_RS5" is not defined as a preprocessor macro, replacing with '0' for '#if/#elif'
::      warning C5031: #pragma warning(pop): likely mismatch, popping warning state pushed in different file
::      warning C5032: detected #pragma warning(push) with no corresponding #pragma warning(pop)\
:: warning C4201: nonstandard extension used : nameless struct/union
 
set wds=/wd4100 /wd4201 /wd4204 /wd4242 /wd4244 /wd4255 /wd4456 /wd4459 /wd4464 /wd4668 /wd4710 /wd4820 /wd4838 /wd5031 /wd5032 /wd5045 /wd4706
 
set flags=/nologo /D_WIN32_WINNT=0x0501 /D_CRT_SECURE_NO_WARNINGS /MTd /W4 /WX /Oi /MP /EHsc /EHa- /FC /TC /Fa /Zi
set inc=/I..\include /I..\single-header /I..\lib
set lflags=/SUBSYSTEM:CONSOLE /OPT:REF /STACK:4194304 /LIBPATH:include
set libs=user32.lib winmm.lib shell32.lib
 
:: if exist %1.rc (
::     rc /nologo /fo %1.res %1.rc
::     set lres=%1.res
:: ) else (
::     set lres=
:: )

IF NOT EXIST bin MKDIR bin

PUSHD bin\
cl /Fe%project_name%.exe %flags% %wds% %inc% ..\src\*.c /link %lflags% %libs% %lres%

:: check to see if compilation failed or not
IF %ERRORLEVEL%==0 (
    SET should_run=1
) ELSE (
    SET should_run=0
)

DEL *.asm *.ilk *.obj
POPD

if %should_run%==1 (
    ECHO.
    ECHO done. running...
    ECHO.
    
    .\bin\%project_name%.exe
)
