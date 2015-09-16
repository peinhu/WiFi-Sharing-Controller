@echo off

REM @version 1.0
REM @author Payne
REM @email huyang110yahoo@gmail.com
REM @github https://github.com/peinhu
REM @date 2015-09-12

echo ===========================
echo ==== WIFI共享控制 v1.0 ====
echo ===========================
echo Tip:运行可能需要管理员权限
goto MenuShow

:MenuSelect
set input=
set /p input=请选择：
if not defined input ( goto Exception )
if %input%==0 ( goto WIFIStatus ) else if %input%==1 ( goto WIFISet ) else if %input%==2 ( goto WIFIStart ) else if %input%==3 ( goto WIFIStop ) else if %input%==bye ( goto Bye ) else if %input%==exit ( goto Exit ) else ( goto Exception )

:WIFIStatus
netsh wlan show hostednetwork
goto MenuSelect

:WIFISet
set ssid=
set /p ssid=设置无线名称(ssid):
if not defined ssid ( goto Exception )
set key=
set /p key=设置无线密码(key):
if not defined key ( goto Exception )
netsh wlan set hostednetwork mode=allow ssid=%ssid% key=%key%
goto MenuSelect

:WIFIStart
netsh wlan start hostednetwork
echo 启动后请确保 网络连接-属性-共享 中已勾选允许连接共享
echo.
goto MenuSelect

:WIFIStop
netsh wlan stop hostednetwork
goto MenuSelect

:Exception
echo 错误：无效的指令!
goto MenuShow

:MenuShow
echo.
echo 1 - 设置WIFI共享
echo 2 - 启动WIFI共享
echo 3 - 关闭WIFI共享
echo 0 - 显示WIFI状态
echo bye/exit - 退出
goto MenuSelect

:Bye
echo Bye!
ping -n 2 127.0.0.1 >nul
exit

:Exit
exit

