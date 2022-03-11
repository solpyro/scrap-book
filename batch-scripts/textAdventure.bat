echo off
color 0A
cls
echo Would you like to know how to use this game? (Y/N)
set /p M=
if %M%==N goto startStory 
if %M%==n goto startStory
call:helpFile
:startStory
rem | Initilise Variables
call:initVars
rem | Initial Room
rem | sets player name and opens the quest scene.
cls
echo Chief: "Welcome adventurer. Please tell me your name."
echo.
set /p M=
echo.
set name=%M%
echo Chief: "%name% is it? Well, welcome %name%.
echo I have a very important quest for you...
echo We need you to carry this AMULET to the great Cathederal in the NORTH.
echo It needs to be there for the festival on Friday, so you have some time
echo to prepare for your journey."
set item_amulet=1
echo You are in the Chief's hut.
echo.
echo People:
echo CHIEF
echo.
echo Exits:
echo W
echo. 
echo Do you want to continue? (Y/N)
set /p M=
if %M%==Y goto MENU
if %M%==y goto MENU
 
rem  //////////////////////////////////////---------\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\  mer 
rem |||||||||||||||||||||||||||||||||||||| FUNCTIONS |||||||||||||||||||||||||||||||||||||| mer
rem  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\---------//////////////////////////////////////  mer

rem | Initilise Variables
rem | sets veriables and values for use within the game
:initVars
rem | items
set item_amulet=0
rem | characters
rem | rooms
goto eof

rem | View bag contents
rem | displays a list of all the items in the bag
:bag
if %item_amulet%==1 echo AMULET
goto eof

rem | Help File
rem | explains the conventions used in the game.
:helpFile
echo.
echo Rooms
echo -----
echo The different areas of the game are split into rooms.
echo Each room will have a description, which will draw a picture of the
echo world as you travel. This will be followed by a list of items, people
echo and exits in the room.
echo You will then be able to interact with the people and items, or choose
echo which exit to use.
echo.
pause
echo.
echo Characters
echo ----------
echo You might enter a room that is occupied by other people. When this happens
echo you will be able to talk to them by typing TALK [CHARACTER NAME]. Some
echo characters will have many things to say, and others might just have one.
echo repeatedly typing TALK [CHARACTER NAME] will coax the character to continue
echo their monologue.
echo.
pause
echo.
echo Items
echo -----
echo Some rooms will contain items that you can either USE or PICK up.
echo These items will appear in a list after the room has been described.
echo You will be able to interact with these objects by typing USE [OBJECT NAME]
echo to use the object or PICK [OBJECT NAME] to put the item in your bag.
echo Some items will only allow you to perform one of the actions. For example
echo you will not be able to put a lever in your bag.
echo.
pause
echo.
echo Directions
echo ----------
echo In each room there will be at least one direction of travel available.
echo You will be able to travel in the four basic directions of the compass;
echo N = north, S = south, E = east and W = west.
echo.
pause
echo.
echo Misc.
echo -----
echo If you forget how to deal with this site, or you fancy a quick reminder
echo you can type HELP into the command prompt at any point to see these 
echo messages again.
echo.
echo At any time you can also type BAG to see what items you currently hold.
echo You can then type USE [OBJECT NAME] to try and use an item in your
echo current situation.
echo.
pause
goto eof

rem | EOF
rem | this needs to be at the endo of the file, so all functions can escape correctly
:eof