@echo off
@title WIFI共享控制

REM @version 1.1
REM @author Payne
REM @email huyang110yahoo@gmail.com
REM @github https://github.com/peinhu
REM @date 2015-09-12

::获取管理员权限
:------------------------------------- 
net session >nul 2>&1
if '%errorlevel%' NEQ '0' ( 
echo 正在请求管理员权限...
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs" 
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs" 
"%temp%\getadmin.vbs"
exit /B 
) else ( 
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" ) 
pushd "%CD%" 
CD /D "%~dp0" 
) 
:-------------------------------------- 
echo ===========================
echo ==== WIFI共享控制 v1.1 ====
echo ===========================
goto CheckAuth

:MenuSelect
echo.
echo 1 - 设置WIFI共享
echo 2 - 启动WIFI共享
echo 3 - 关闭WIFI共享
echo 0 - 显示WIFI状态
echo bye/exit - 退出
set input=
set /p input=请选择：
if not defined input ( goto Exception )
if %input%==0 ( goto WIFIStatus ) else if %input%==1 ( goto WIFISet ) else if %input%==2 ( goto WIFIStart ) else if %input%==3 ( goto WIFIStop ) else if %input%==bye ( goto Bye ) else if %input%==exit ( goto Exit ) else ( goto Exception )

:WIFIStatus
netsh wlan show hostednetwork
goto MenuSelect

:WIFISet
set ssid=
set /p ssid=设置无线名称:
if not defined ssid ( goto Exception )
set key=
set /p key=设置无线密码(至少8位):
if not defined key ( goto Exception )
netsh wlan set hostednetwork mode=allow ssid=%ssid% key=%key%
goto MenuSelect

:WIFIStart
netsh wlan start hostednetwork
echo 启动后请确保 本地连接-属性-共享 中已勾选允许连接共享，并选择需要给与共享的无线网卡名称。
echo.
goto MenuSelect

:WIFIStop
netsh wlan stop hostednetwork
goto MenuSelect

:Exception
echo 错误：无效的指令!
goto MenuSelect

:Bye
echo Bye!
ping -n 2 localhost >nul
exit

:Exit
exit

:CheckAuth
net session >nul 2>&1
if '%errorlevel%' NEQ '0' ( 
echo 权限不足！请手动以管理员身份运行
pause
goto Exit
)
goto MenuSelect
