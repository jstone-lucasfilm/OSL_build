@echo off

if exist %1\ goto End

set root=%1
echo *** Building %root%

set /p gitArgs=<"%root%.git"
if not exist %root% (
	git clone --depth 1 -c advice.detachedHead=false %gitArgs% %root%
)

set cmakeArgs=
if exist %root%.cmakeArgs set /p cmakeArgs=<"%root%.cmakeArgs"

set postBuild=
if exist %root%.postBuild set /p postBuild=<"%root%.postBuild"

set invokeDir=..
if exist "%root%.invokeDir" set /p invokeDir=<"%root%.invokeDir"

pushd %root%

set buildDir="build"

if not exist %buildDir% mkdir %buildDir%

pushd %buildDir%

cmake -G %compiler% -A %arch% %invokeDir% -DCMAKE_DEBUG_POSTFIX=d -DCMAKE_INSTALL_PREFIX=%fullInstallDir% -DCMAKE_PREFIX_PATH=%fullInstallDir% -DLLVM_ROOT=%fullInstallDir% %cmakeArgs%
cmake --build . --target install -j 8 --config release

%postBuild%

popd
popd

:End
