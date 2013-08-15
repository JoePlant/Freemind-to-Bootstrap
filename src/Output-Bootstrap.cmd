rem @echo off
set project=mindmap.mm

if EXIST Output goto Output_exists
mkdir Output
:Output_exists

xcopy "..\lib\bootstrap 2.3.2" Output\bootstrap /E /Y /I
xcopy "..\lib\jquery 1.10.2" Output\jquery /E /Y /I

set nxslt=..\lib\nxslt\nxslt.exe

@echo === Normalise ===
%nxslt% %project% Output-to-Bootstrap.xslt -o Output\index.html 