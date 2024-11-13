@echo off
setlocal enableDelayedExpansion

set cwd=%cd%
set "cwd=%cwd:\=/%"

set installDir="_installed"

if not exist %installDir% mkdir %installDir%

set fullInstallDir=%cwd%/%installDir%

set compiler="Visual Studio 17 2022"
set arch="x64"

set libs=zlib
set libs=%libs%;winflexbison
set libs=%libs%;pugixml
set libs=%libs%;expat
set libs=%libs%;libpng
set libs=%libs%;imath
set libs=%libs%;oiio
set libs=%libs%;LLVM
set libs=%libs%;OSL

for %%f in (%libs%) do (
	set dep_name=%%~nf
	call BuildHelper.bat !dep_name!
)
