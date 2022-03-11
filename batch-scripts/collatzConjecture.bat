@echo off

echo Collatz Conjecture
echo ------------------
echo.
echo Choose any number:
echo If it's even, divide it by 2
echo If it's odd, multiply by 3 and add 1
echo.
echo Repeating this procedure for long enough, and you will always end up with 1
echo.

:start
echo Choose a number
set /p M=
set /a number=M
set /a counter=0

:nextStep
if %number%==1 goto eof
set /a isEven=%number%%%2
if %isEven%==0 goto devide2

:multiply3add1
set /a number=%number%*3
set /a number=%number%+1
echo %number%
set /a counter=%counter%+1
rem pause
goto :nextStep

:devide2
set /a number=%number%/2
echo %number%
set /a counter=%counter%+1
rem pause
goto :nextStep

:eof
echo Sequence completed after %counter% iterations.
echo Do you want to try another sequence? (y/n)
set /p M=
echo.
if %M%==Y goto start
if %M%==y goto start