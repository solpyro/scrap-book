@echo off
color 0A

:init
cls

echo *******************
echo * HUNT THE WUMPUS *
echo *******************
echo.
echo WARNING: This game contains violence and mild peril.
echo Players are advised that actions performed in this world should
echo not be attempted in real life.
echo.

rem place player at top of dodecahedron
set playerLastRoom=11
set playerRoom=1
call:nextRooms
rem place wumpus randomly, but not in player room
:placeWumpus
call:rand20
if %rand20%==1 goto placeWumpus
set wumpusRoom=%rand20%
rem place superbat randomly...
:placeSuperbat
call:rand20
if %rand20%==1 goto placeSuperbat
if %rand20%==%wumpusRoom% goto placeSuperbat
set batsRoom=%rand20%
rem place the pit
:placePit
call:rand20
if %rand20%==1 goto placePit
if %rand20%==%wumpusRoom% goto placePit
if %rand20%==%batsRoom% goto placePit
set pitRoom=%rand20%
rem set flags
set playerLives=1
set wumpusLives=1
rem main game loop
:mainLoop
rem check for game end
if %playerLives%==0 goto gameOver
if %playerLives%==-1 goto gameOver
if %wumpusLives%==0 goto gameOver
rem display clues
call:isBatNext
if %isNext%==1 echo I hear flapping!
call:isPitNext
if %isNext%==1 echo I feel drafts!
call:isWumpusNext
if %isNext%==1 echo I smell WUMPUS!
echo.
rem echo (ln55) P=%playerRoom%(%playerLastRoom%), w=%wumpusRoom%, b=%batsRoom%, p=%pitRoom%
rem await user command
echo Walk or Shoot? w/s (default = walk)
set /p M=
echo Left, Right or Back? l/r/b (default = left)
set /p N=
echo.
rem set direction
set dir=l
if %N%==Right set dir=r
if %N%==right set dir=r
if %N%==RIGHT set dir=r
if %N%==R set dir=r
if %N%==r set dir=r
if %N%==Back set dir=br
if %N%==back set dir=b
if %N%==BACK set dir=b
if %N%==B set dir=b
if %N%==b set dir=b
rem check walk or shoot
if %M%==Walk goto walk
if %M%==walk goto walk
if %M%==WALK goto walk
if %M%==W goto walk
if %M%==w goto walk
rem fire arrow
:shoot
echo You loose an arrow into the darkness...
set targetNeighbour=%wumpusRoom%
set wumpusNext=0
if %dir%==l (
	if %nextL%==%wumpusRoom% (
		set wumpusLives=0
	) else (
		rem if next to wumpus?
		set arrowTarget=%nextL%
	)
)
if %dir%==r (
	if %nextR%==%wumpusRoom% (
		set wumpusLives=0
	) else (
		rem if next to wumpus?
		set arrowTarget=%nextR%
	)
)
if %dir%==b (
	if %nextB%==%wumpusRoom% (
		set wumpusLives=0
	) else (
		rem if next to wumpus?
		set arrowTarget=%nextB%
	)
)
call:wumpusNext
if %wumpusNext%==1 call:wumpusRun
goto mainLoop
:walk
rem walk player
set playerLastRoom=%playerRoom%
if %dir%==l (
	set playerRoom=%nextL%
	call:nextRooms
	call:crowded
)
if %dir%==r (
	set playerRoom=%nextR%
	call:nextRooms
	call:crowded
)
if %dir%==b (
	set playerRoom=%nextB%
	call:nextRooms
	call:crowded
)
goto mainLoop

rem move the wumpus
:wumpusRun
rem choose random direction (1/3)
call:rand3
if %rand3%==0 set wumpusRoomTarget=%wumpus1%
if %rand3%==1 set wumpusRoomTarget=%wumpus2%
if %rand3%==2 set wumpusRoomTarget=%wumpus3%
rem if room isn't player room
if %wumpusRoomTarget%==%playerRoom% goto wumpusRun
rem move wumpus to that room
set wumpusRoom=%wumpusRoomTarget%
echo ...and startle the Wumpus!
echo.vdv
goto eof

rem check if the wumpus is next to the arrow
:wumpusNext
rem set wumpus neighbour rooms for later
if %targetNeighbour%==1 (
	set wumpus1=2
	set wumpus2=3
	set wumpus3=11
)
if %targetNeighbour%==2 (
	set wumpus1=1
	set wumpus2=16
	set wumpus3=5
)
if %targetNeighbour%==3 (
	set wumpus1=1
	set wumpus2=4
	set wumpus3=6
)
if %targetNeighbour%==4 (
	set wumpus1=3
	set wumpus2=5
	set wumpus3=8
)
if %targetNeighbour%==5 (
	set wumpus1=2
	set wumpus2=10
	set wumpus3=4
)
if %targetNeighbour%==6 (
	set wumpus1=3
	set wumpus2=7
	set wumpus3=12
)
if %targetNeighbour%==7 (
	set wumpus1=6
	set wumpus2=8
	set wumpus3=13
)
if %targetNeighbour%==8 (
	set wumpus1=4
	set wumpus2=9
	set wumpus3=7
)
if %targetNeighbour%==9 (
	set wumpus1=8
	set wumpus2=10
	set wumpus3=14
)
if %targetNeighbour%==10 (
	set wumpus1=5
	set wumpus2=15
	set wumpus3=9
)
if %targetNeighbour%==11 (
	set wumpus1=1
	set wumpus2=12
	set wumpus3=20
)
if %targetNeighbour%==12 (
	set wumpus1=6
	set wumpus2=13
	set wumpus3=11
)
if %targetNeighbour%==13 (
	set wumpus1=7
	set wumpus2=14
	set wumpus3=17
)
if %targetNeighbour%==14 (
	set wumpus1=9
	set wumpus2=18
	set wumpus3=13
)
if %targetNeighbour%==15 (
	set wumpus1=10
	set wumpus2=16
	set wumpus3=18
)
if %targetNeighbour%==16 (
	set wumpus1=2
	set wumpus2=20
	set wumpus3=15
)
if %targetNeighbour%==17 (
	set wumpus1=12
	set wumpus2=13
	set wumpus3=19
)
if %targetNeighbour%==18 (
	set wumpus1=14
	set wumpus2=15
	set wumpus3=19
)
if %targetNeighbour%==19 (
	set wumpus1=17
	set wumpus2=18
	set wumpus3=11
)
if %targetNeighbour%==20 (
	set wumpus1=11
	set wumpus2=19
	set wumpus3=16
)
rem check if the arrow is near the wumpus
set wumpusNext=0
if %wumpus1%==%arrowTarget% set wumpusNext=1
if %wumpus2%==%arrowTarget% set wumpusNext=1
if %wumpus3%==%arrowTarget% set wumpusNext=1
goto eof

rem check if player has a friend
:crowded
rem is wumpus here?
if %playerRoom%==%wumpusRoom% set playerLives=0
rem is pit here?
if %playerRoom%==%pitRoom% set playerLives=-1
rem is superbat here?
if %playerRoom%==%batsRoom% call:movePlayer
goto eof

rem moves player to new location
:movePlayer
rem choose a new location
:crowdedSelectPlayer
call:rand20
if %rand20%==%wumpusRoom% goto crowdedSelectPlayer
if %rand20%==%pitRoom% goto crowdedSelectPlayer
set playerRoom=%rand20%
set targetNeighbour=%playerRoom%
call:wumpusNext
call:rand3
if %rand3%==0 set playerLastRoom=%wumpus1%
if %rand3%==1 set playerLastRoom=%wumpus2%
if %rand3%==2 set playerLastRoom=%wumpus3%
rem calculate players new neighbours
call:nextRooms
rem choose a new bat location
:crowdedSelectBat
call:rand20
if %rand20%==%wumpusRoom% goto crowdedSelectBat
if %rand20%==%pitRoom% goto crowdedSelectBat
if %rand20%==%playerRoom% goto crowdedSelectBat
set batsRoom=%rand20%
rem tell the player
echo A superbat grabs you and carries you away...
echo.
goto eof

rem check if a wumpus is next door
:isWumpusNext
set isNext=0
if %nextL%==%wumpusRoom% set isNext=1
if %nextR%==%wumpusRoom% set isNext=1
if %nextB%==%wumpusRoom% set isNext=1
goto eof

rem check if a pit is next door
:isPitNext
set isNext=0
if %nextL%==%pitRoom% set isNext=1
if %nextR%==%pitRoom% set isNext=1
if %nextB%==%pitRoom% set isNext=1
goto eof

rem check if a bat is next door
:isBatNext
set isNext=0
if %nextL%==%batsRoom% set isNext=1
if %nextR%==%batsRoom% set isNext=1
if %nextB%==%batsRoom% set isNext=1
goto eof

:nextRooms
if %playerRoom%==1 (
	if %playerLastRoom%==2 (
		set nextL=3
		set nextR=11
		set nextB=2
	)
	if %playerLastRoom%==3 (
		set nextL=11
		set nextR=2
		set nextB=3
	)
	if %playerLastRoom%==11 (
		set nextL=2
		set nextR=3
		set nextB=11
	)
)
if %playerRoom%==2  (
	if %playerLastRoom%==1 (
		set nextL=16
		set nextR=5
		set nextB=1
	)
	if %playerLastRoom%==16 (
		set nextL=5
		set nextR=1
		set nextB=16
	)
	if %playerLastRoom%==5 (
		set nextL=1
		set nextR=16
		set nextB=5
	)
)
if %playerRoom%==3  (
	if %playerLastRoom%==1 (
		set nextL=4
		set nextR=6
		set nextB=1
	)
	if %playerLastRoom%==4 (
		set nextL=6
		set nextR=1
		set nextB=4
	)
	if %playerLastRoom%==6 (
		set nextL=1
		set nextR=4
		set nextB=6
	)
)
if %playerRoom%==4  (
	if %playerLastRoom%==3 (
		set nextL=5
		set nextR=8
		set nextB=3
	)
	if %playerLastRoom%==5 (
		set nextL=8
		set nextR=3
		set nextB=5
	)
	if %playerLastRoom%==8 (
		set nextL=3
		set nextR=5
		set nextB=8
	)
)
if %playerRoom%==5  (
	if %playerLastRoom%==2 (
		set nextL=10
		set nextR=4
		set nextB=2
	)
	if %playerLastRoom%==10 (
		set nextL=4
		set nextR=2
		set nextB=10
	)
	if %playerLastRoom%==4 (
		set nextL=2
		set nextR=10
		set nextB=4
	)
)
if %playerRoom%==6  (
	if %playerLastRoom%==3 (
		set nextL=7
		set nextR=12
		set nextB=3
	)
	if %playerLastRoom%==7 (
		set nextL=12
		set nextR=3
		set nextB=7
	)
	if %playerLastRoom%==12 (
		set nextL=3
		set nextR=7
		set nextB=12
	)
)
if %playerRoom%==7  (
	if %playerLastRoom%==6 (
		set nextL=8
		set nextR=13
		set nextB=6
	)
	if %playerLastRoom%==8 (
		set nextL=13
		set nextR=6
		set nextB=8
	)
	if %playerLastRoom%==13 (
		set nextL=6
		set nextR=8
		set nextB=13
	)
)
if %playerRoom%==8  (
	if %playerLastRoom%==4 (
		set nextL=9
		set nextR=7
		set nextB=4
	)
	if %playerLastRoom%==9 (
		set nextL=7
		set nextR=4
		set nextB=9
	)
	if %playerLastRoom%==7 (
		set nextL=4
		set nextR=9
		set nextB=7
	)
)
if %playerRoom%==9  (
	if %playerLastRoom%==8 (
		set nextL=10
		set nextR=14
		set nextB=8
	)
	if %playerLastRoom%==10 (
		set nextL=14
		set nextR=8
		set nextB=10
	)
	if %playerLastRoom%==14 (
		set nextL=8
		set nextR=10
		set nextB=14
	)
)
if %playerRoom%==10 (
	if %playerLastRoom%==5 (
		set nextL=15
		set nextR=9
		set nextB=5
	)
	if %playerLastRoom%==15 (
		set nextL=9
		set nextR=5
		set nextB=15
	)
	if %playerLastRoom%==9 (
		set nextL=5
		set nextR=15
		set nextB=9
	)
)
if %playerRoom%==11 (
	if %playerLastRoom%==1 (
		set nextL=12
		set nextR=20
		set nextB=1
	)
	if %playerLastRoom%==12 (
		set nextL=20
		set nextR=1
		set nextB=12
	)
	if %playerLastRoom%==20 (
		set nextL=1
		set nextR=12
		set nextB=20
	)
)
if %playerRoom%==12 (
	if %playerLastRoom%==6 (
		set nextL=13
		set nextR=11
		set nextB=6
	)
	if %playerLastRoom%==13 (
		set nextL=11
		set nextR=6
		set nextB=13
	)
	if %playerLastRoom%==11 (
		set nextL=6
		set nextR=13
		set nextB=11
	)
)
if %playerRoom%==13 (
	if %playerLastRoom%==7 (
		set nextL=14
		set nextR=17
		set nextB=7
	)
	if %playerLastRoom%==14 (
		set nextL=17
		set nextR=7
		set nextB=14
	)
	if %playerLastRoom%==17 (
		set nextL=7
		set nextR=14
		set nextB=17
	)
)
if %playerRoom%==14 (
	if %playerLastRoom%==9 (
		set nextL=18
		set nextR=13
		set nextB=9
	)
	if %playerLastRoom%==18 (
		set nextL=13
		set nextR=9
		set nextB=18
	)
	if %playerLastRoom%==13 (
		set nextL=9
		set nextR=18
		set nextB=13
	)
)
if %playerRoom%==15 (
	if %playerLastRoom%==10 (
		set nextL=16
		set nextR=18
		set nextB=10
	)
	if %playerLastRoom%==16 (
		set nextL=18
		set nextR=10
		set nextB=16
	)
	if %playerLastRoom%==18 (
		set nextL=10
		set nextR=16
		set nextB=18
	)
)
if %playerRoom%==16 (
	if %playerLastRoom%==2 (
		set nextL=20
		set nextR=15
		set nextB=2
	)
	if %playerLastRoom%==20 (
		set nextL=15
		set nextR=2
		set nextB=20
	)
	if %playerLastRoom%==15 (
		set nextL=2
		set nextR=20
		set nextB=15
	)
)
if %playerRoom%==17 (
	if %playerLastRoom%==12 (
		set nextL=13
		set nextR=19
		set nextB=12
	)
	if %playerLastRoom%==13 (
		set nextL=19
		set nextR=12
		set nextB=13
	)
	if %playerLastRoom%==19 (
		set nextL=12
		set nextR=13
		set nextB=19
	)
)
if %playerRoom%==18 (
	if %playerLastRoom%==14 (
		set nextL=15
		set nextR=19
		set nextB=14
	)
	if %playerLastRoom%==15 (
		set nextL=19
		set nextR=14
		set nextB=15
	)
	if %playerLastRoom%==19 (
		set nextL=14
		set nextR=15
		set nextB=19
	)
)
if %playerRoom%==19 (
	if %playerLastRoom%==17 (
		set nextL=18
		set nextR=20
		set nextB=17
	)
	if %playerLastRoom%==18 (
		set nextL=20
		set nextR=17
		set nextB=18
	)
	if %playerLastRoom%==20 (
		set nextL=17
		set nextR=18
		set nextB=20
	)
)
if %playerRoom%==20 (
	if %playerLastRoom%==11 (
		set nextL=19
		set nextR=16
		set nextB=11
	)
	if %playerLastRoom%==19 (
		set nextL=16
		set nextR=11
		set nextB=19
	)
	if %playerLastRoom%==16 (
		set nextL=11
		set nextR=19
		set nextB=16
	)
)
goto eof

rem game over
:gameOver
if %playerLives%==1 echo You killed the Wumpus!
if %playerLives%==0 echo You were eaten by the Wumpus!
if %playerLives%==-1 echo You fell into the bottomless pit!
echo.
echo *************
echo * GAME OVER *
echo *************
echo.
echo Would you like to play again? Y/N
set /p M=
if %M%==Y goto init
if %M%==y goto init
goto eof

rem random number between 1 and 20
:rand20
set /a rand10Src=%random%%%2
set /a rand1Src=%random%%%10
set /a rand20=%rand10Src%*10+%rand1Src%+1
goto eof

rem random number between 0 and 2
:rand3
set /a rand3=%random%%%2
goto eof

:eof