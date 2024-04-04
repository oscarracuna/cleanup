@echo off
echo.
echo ==================================
echo Welcome to the basic cleanup tool.
echo ==================================
echo.
echo ================================================================================================
echo Please do NOT close this window. As soon as the program is finished, the window will be closed.
echo ================================================================================================

echo ===========
echo Running SFC
echo ===========
sfc /scannow
echo.
echo.
echo ============
echo Running DISM
echo ============
dism /online /cleanup-image /restorehealth
echo.
echo.
echo =====================
echo Running disk clean up
echo =====================
cleanmgr /sagerun:1
echo.
echo.
echo =============================
echo Determining if SSD is present
echo =============================
for /f "tokens=2 delims==" %%I in ('wmic diskdrive where "MediaType='SSD'" get MediaType /value') do (
  if "%%I"=="SSD" (
    echo ============================================
    echo SSD detected. Ommiting disk defragmentation.
    echo ============================================
    goto :end
  )
)
echo.
echo.
echo ===================
echo Running disk defrag
echo ===================
defrag C: /U /V

del "%~f0"
