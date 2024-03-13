include irvine32.inc
includelib Winmm.lib



PlaySoundA PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD
.data
screenMaxX = 120
screenMaxY = 30
PacmanTitle db "________ ________ _______         _______________ ________ ________",0ah,
		       "|      | |      | |               |      |      | |      | |      |",0ah
		    db "|      | |      | |               |      |      | |      | |      |",0ah,
		       "|______| |______| |         ---   |      |      | |______| |      |",0ah,
		       "|        |      | |               |      |      | |      | |      |",0ah,
		       "|        |      | |               |      |      | |      | |      |",0ah,
		       "|        |      | |______         |      |      | |      | |      |",0ah,0
lengthofOneRow = 68 ; length of one row of pacmanTitle
lengthofOneCol = 7 ; length of one col of pacmanTitle

userNamePrompt db "Enter Your Name: ",0
userName db 50 dup(0)
MenuPrompt1 db "Play",0
MenuPrompt2 db "Instructions",0
MenuPrompt3 db "Exit",0
newLine db 0ah,0
optionSelected db 1
optionPressed db 0
consoleTitlePrompt db "PAC-MAN",0
consoleCursorInfo CONSOLE_CURSOR_INFO <0, 0> 
playerNamePrompt db "Player Name: ",0

wall db '-'
eatable db '.'
fruit db '$'

gameBoardLengthX = 60
gameBoardLengthY = 21
gameBoardStartX = 14
gameBoardStartY = 3
gameBoardEndX = 73
gameBoardEndY = 23


mazeLevel1 db "+------------T---------------------------------T-----------="
		   db "| . . . . .  |   .  .  .  .  .  .  .  .  .  .  | . . . . . |"
		   db "|            |                                 |           |"
		   db "| . +---- .  |   .  .  .  .  .  .  .  .  .  .  | . ----=   |"
		   db "|   |        |                                 |       |   |"
		   db "| . | . . .      --------------------------      . . . | . |"
		   db "|   |                                                  |   |"
		   db "|                                                          |"
		   db "|          ----                              ----          |"
		   db "|                                                          |"
		   db "|                --------------------------                |"
		   db "|                                                          |"
		   db "|          ----                              ----          |"
		   db "|                                                          |"
		   db "|   |                                                  |   |"
		   db "| . | . . .      --------------------------      . . . | . |"
		   db "|   |        |                                 |       |   |"
		   db "| . *---- .  |   .  .  .  .  .  .  .  .  .  .  | . ----/   |"
		   db "|            |                                 |           |"
		   db "| . . . . .  |   .  .  .  .  .  .  .  .  .  .  | . . . . . |"
           db "*------------J---------------------------------J-----------/",0

mazelevel2 db "+---------------------------------------------T------------="
		   db "| .  .  .  .  .  .  .  .  .  .  .  .  .  .  . | .........$ |"
		   db "| . |        --------          |              |    --------U"
		   db "| . |                          |              |            |"
		   db "| . |  .  .  .  .  .  .  .  .  |  .  .  .  .  .  .  .  . . |"
		   db "| . |    |     -----=          *-----             -----= . |"
		   db "| . |    |          |                                  | . |"
		   db "| . |    | $   .  .  .  .  .  .  .  .  .  .  .  .  .   | . |"
		   db "|        Y-------           |    ..     +--------------/ . |"
		   db "| . |    |                  |    ..     |  ..            . |"
		   db "| . |    |  . . . . . . .   |    ..     |  ..            $ |"
		   db "| . |               --      |    ..     |  .. |      ------U"
		   db "| . |          -------------U    ..     |  .. |         .. |"
		   db "| . |   . . . . . . . . .   |    ..     |  .. |         .. |"
		   db "| . | $                     |    ..     |  .. Y------   .. |" 
		   db "| . *-----------------                        |         .. |"
		   db "| . . . . . . . . . . . . . . .         . . . |         .. |"
		   db "|  -----------------------------         -----J--    ----  |"
		   db "| ........................................................ |"
		   db "| ........................................................ |"
		   db "*----------------------------------------------------------/",0

mazelevel3 db "+----------------------------T-----------------------------="
		   db "|...........................$|$............................|"
		   db "|.+---------=.+------------=.|.+-------------=.+---------=.|"
		   db "|.*---------/.*------------/.|.*-------------/.*---------/.|"
		   db "|..........................................................|"
		   db "|.+---------=...-------------T--------------...+---------=.|"
		   db "|.*---------/.|..............|...............|.*---------/.|"
		   db "|$............|..............................|............$|"
		   db "*-----------=.Y-----....................-----U.+-----------/"
		   db "------------/.|$       +----    ----=       $|.*------------"
		   db " .............         |            |         ............. "
		   db "------------=.|$       *------------/       $|.+------------"
		   db "+-----------/.Y-----................... -----U.*-----------="
		   db "|$............|..............................|............$|"
		   db "|.+---------=.|..............|...............|.+---------=.|"
		   db "|.*---------/...-------------J--------------...*---------/.|"
		   db "|..........................................................|"
		   db "|.+---------=.+------------=.|.+-------------=.+---------=.|"
		   db "|.*---------/.*------------/.|.*-------------/.*---------/.|"
		   db "|...........................$|$............................|"
           db "*----------------------------J-----------------------------/",0

teleportLeftX = gameBoardStartX - 1
teleportLeftY = gameBoardStartY + 10

teleportRightX = gameBoardEndX + 1
teleportRightY = gameBoardStartY + 10

teleporterSwitchLeft db 0
teleporterSwitchRight db 0

scoreBoardlengthX = 30
scoreBoardlengthY = 30
scoreBoardStartX = 90
scoreBoardStartY = 0
scoreBoardEndX = 119
scoreBoardEndY = 29

strScore BYTE "Your score is: ",0
score dw 0
scoreX = 0
scoreY = 0

livesPrompt BYTE "Lives Remaining: ",0
lives BYTE 3
livesX = 0
livesY = 0

Pacman db 254
PacmanX db gameBoardStartX+1
PacmanY db gameBoardEndY-1
eatablefound db 0
fruitFound db 0
PacmanInitialX = gameBoardStartX+1 
PacmanInitialY = gameBoardEndY-1 
pacmanPrevX db gameBoardStartX+1
pacmanPrevY db gameBoardEndY-1

temp1 = 0
temp dd ?
ghostspeed dw 6
ghosttimer dw 0

ghost db 254
ghost1x db ?
ghost1y db ?
ghost1prevX db ?
ghost1prevY db ?
ghost1color = blue
isghost1movingup db 0
isghost1movingdown db 0
isghost1movingleft db 1
isghost1movingright db 0


ghost2x db ?
ghost2y db ?
ghost2prevX db ?
ghost2prevY db ?
ghost2color = red
isghost2movingup db 0
isghost2movingdown db 0
isghost2movingleft db 0
isghost2movingright db 1

ghost3x db ?
ghost3y db ?
ghost3prevX db ?
ghost3prevY db ?
ghost3color = green
isghost3movingup db 1
isghost3movingdown db 0
isghost3movingleft db 0
isghost3movingright db 0

ghost4x db ?
ghost4y db ?
ghost4prevX db ?
ghost4prevY db ?
ghost4color = brown
isghost4movingup db 0
isghost4movingdown db 1
isghost4movingleft db 0
isghost4movingright db 0




levelNum db 1
levelPrompt db "Level: ",0
levelX = 0
levelY = 0

levelCompleted db "                           __       ___________    ____  _______  __                        "
			   db "                          |  |     |   ____\   \  /   / |   ____||  |                       "                                             
               db "                          |  |     |  |__   \   \/   /  |  |__   |  |                       "                                               
               db "                          |  |     |   __|   \      /   |   __|  |  |                       "                                              
               db "                          |  `----.|  |____   \    /    |  |____ |  `----.                  "                                         
               db "                          |_______||_______|   \__/     |_______||_______|                  "                                                                                                                        
               db "   ______   ______   .___  ___. .______    __       _______ .___________._______  _______   "  
               db "  /      | /  __  \  |   \/   | |   _  \  |  |     |   ____||           |   ____||       \  " 
               db " |  ,----'|  |  |  | |  \  /  | |  |_)  | |  |     |  |__   `---|  |----|  |__   |  .--.  | "
               db " |  |     |  |  |  | |  |\/|  | |   ___/  |  |     |   __|      |  |    |   __|  |  |  |  | "
               db " |  `----.|  `--'  | |  |  |  | |  |      |  `----.|  |____     |  |    |  |____ |  '--'  | "
               db "  \______| \______/  |__|  |__| | _|      |_______||_______|    |__|    |_______||_______/  ",0 

lengthlevelCompletedstr = 92                                                                                   
heightlevelCompletedstr = 12  

GameOver db "   _______      ___      .___  ___.  _______    "  
         db "  /  _____|    /   \     |   \/   | |   ____|   "
         db " |  |  __     /  ^  \    |  \  /  | |  |__      "
         db " |  | |_ |   /  /_\  \   |  |\/|  | |   __|     "
         db " |  |__| |  /  _____  \  |  |  |  | |  |____    "
         db "  \______| /__/     \__\ |__|  |__| |_______|   "
         db "                                                "
         db "   ______   ____    ____  _______  .______      "
         db "  /  __  \  \   \  /   / |   ____| |   _  \     "
         db " |  |  |  |  \   \/   /  |  |__    |  |_)  |    "
         db " |  |  |  |   \      /   |   __|   |      /     "
         db " |  `--'  |    \    /    |  |____  |  |\  \----."
         db "  \______/      \__/     |_______| | _| `._____|",0
                                              
lengthGameOverstr = 48
heightGameOverstr = 13

endScorestr db "Score: ",0
endlevelstr db "Levels Completed: ",0
mainMenuprompt db "Main Menu (Press Enter)",0 

instructions db "1) Movement of pacman is done through arrow keys.",0ah
             db "2) Ghosts eat pacman so try to stay away from them.",0ah
			 db "3) Eatables increment score by 5.",0ah
			 db "4) Fruits increment score by 10.",0ah
			 db "5) Press Escape to pause the game.",0

ghosteatSound db ".\Sounds\ghostEatSound.wav",0


fileName db "scores.txt"
fileHandle dd ?
fileHeadings db "Name                                              Score                                              Levels Completed",0
spacesBetweenHeadings = 46
space db ' '
bytesWritten dw ?
count db ?
PlayerDetails db 118 dup(?)

currentMap db gameBoardlengthX*gameBoardlengthY dup(?) 
.code

main proc
	
	call consoleTitle
	call setBackGroundColor

	mov dl, (screenMaxX-lengthofOneRow)/2
	mov dh,(screenMaxY-lengthofOneCol)/2         ; offset for title

	call PrintTitle
	call GetUserName

	call cursorHide
	
	call clrscr
gameStart::
	call clrscr
	call setBackGroundColor
	call menu

gamePlay::	
			call clrscr
			cmp levelNum,1
			jne level2
			invoke CreateFile,offset fileName,FILE_APPEND_DATA,NULL,NULL,OPEN_ALWAYS,NULL,NULL
			mov fileHandle,eax
			mov edi,offset mazelevel1
			call drawMaze
			jmp remaining
			level2:
			cmp levelNum,2
			jne level3
			mov edi, offset mazelevel2
			call drawMaze
			jmp remaining
			level3:
			mov edi, offset mazelevel3
			call drawMaze
			remaining:
			call drawScoreBoard

			call drawPlayer

			cmp levelNum,3
			jne printGhostsforl1andl2
			call drawGhostsforlevel3
			jmp gameloop
			printGhostsforl1andl2:
			call drawGhosts
gameloop:
		
		mov eax,50
		call delay
		call readKey
		jz continue
		cmp dx, vk_escape
		je gameStart
		cmp dx,vk_up
		jne checkdown
moveup:
		movzx ax,pacmanY
		sub ax,1
		sub ax,gameBoardStartY
		mov bl, gameBoardlengthX
		mul bl
		movzx bx,pacmanX
		sub bx,gameBoardStartX
		add ax,bx
		movzx esi,ax
		mov al, byte ptr [edi+esi]
		cmp al,wall
		je continue
		cmp al,'|'
		je continue
		cmp al,'+'
		je continue
		cmp al,'='
		je continue
		cmp al,'*'
		je continue
		cmp al,'/'
		je continue
		cmp al,'T'
		je continue
		cmp al,'J'
		je continue
		cmp al,'U'
		je continue
		cmp al,'Y'
		je continue
		cmp al,eatable
		jne checkfruit
		mov eatablefound,1
		jmp printspace
		checkfruit:
		cmp al,fruit
		jne continueup
		mov fruitFound,1
		printspace:
		mov al,' '
		mov byte ptr [edi+esi],al
		continueup:
		dec pacmanY
		call updatePlayer
		call checkCollisionwithGhosts
		jmp continue
checkDown:
		cmp dx,vk_down
		jne checkLeft
movedown:
		movzx ax,pacmanY
		add ax,1
		sub ax,gameBoardStartY
		mov bl, gameBoardlengthX
		mul bl
		movzx bx,pacmanX
		sub bx,gameBoardStartX
		add ax,bx
		movzx esi,ax
		mov al, byte ptr [edi+esi]
		cmp al,wall
		je continue
		cmp al,'|'
		je continue
		cmp al,'+'
		je continue
		cmp al,'='
		je continue
		cmp al,'*'
		je continue
		cmp al,'/'
		je continue
		cmp al,'T'
		je continue
		cmp al,'J'
		je continue
		cmp al,'U'
		je continue
		cmp al,'Y'
		je continue
		cmp al,eatable
		jne checkfruit1
		mov eatablefound,1
		jmp printspace1
		checkfruit1:
		cmp al,fruit
		jne continuedown
		mov fruitFound,1
		printspace1:
		mov al,' '
		mov byte ptr [edi+esi],al
		continuedown:
		inc pacmanY
		call updatePlayer
		call checkCollisionwithGhosts
		jmp continue
checkLeft:
		cmp dx, vk_left
		jne checkRight
moveLeft:
		cmp levelNum,3
		jne continueProcessLeft
		cmp pacmanX,teleportLeftX+1
		jne continueprocessLeft
		cmp pacmanY,teleportLeftY
		jne continueprocessLeft
		mov teleporterSwitchLeft,1
		continueprocessLeft:
		movzx ax,pacmanY
		sub ax,gameBoardStartY
		mov bl, gameBoardlengthX
		mul bl
		movzx bx,pacmanX
		cmp teleporterSwitchLeft,1
		je dontsub
		sub bx,1
		dontsub:
		sub bx,gameBoardStartX
		add ax,bx
		movzx esi,ax
		mov al, byte ptr [edi+esi]
		cmp al,wall
		je continue
		cmp al,'|'
		je continue
		cmp al,'+'
		je continue
		cmp al,'='
		je continue
		cmp al,'*'
		je continue
		cmp al,'/'
		je continue
		cmp al,'T'
		je continue
		cmp al,'J'
		je continue
		cmp al,'U'
		je continue
		cmp al,'Y'
		je continue
		cmp al,eatable
		jne checkfruit2
		mov eatablefound,1
		jmp printspace2
		checkfruit2:
		cmp al,fruit
		jne continueleft
		mov fruitFound,1
		printspace2:
		mov al,' '
		mov byte ptr [edi+esi],al
		continueleft:
		dec pacmanX
		call updatePlayer
		call checkCollisionwithGhosts
		jmp continue
checkRight:
		cmp dx,vk_right
		jne continue
moveRight:
		cmp levelNum,3
		jne continueProcessRight
		cmp pacmanX,teleportRightX-1
		jne continueprocessright
		cmp pacmanY,teleportRightY
		jne continueprocessright
		mov teleporterSwitchRight,1
		continueprocessright:
		movzx ax,pacmanY
		sub ax,gameBoardStartY
		mov bl, gameBoardlengthX
		mul bl
		movzx bx,pacmanX
		cmp teleporterSwitchRight,1
		je dontadd
		add bx,1
		dontadd:
		sub bx,gameBoardStartX
		add ax,bx
		movzx esi,ax
		mov al, byte ptr [edi+esi]
		cmp al,wall
		je continue
		cmp al,'|'
		je continue		
		cmp al,'+'
		je continue
		cmp al,'='
		je continue
		cmp al,'*'
		je continue
		cmp al,'/'
		je continue
		cmp al,'T'
		je continue
		cmp al,'J'
		je continue
		cmp al,'U'
		je continue
		cmp al,'Y'
		je continue
		cmp al,eatable
		jne checkfruit3
		mov eatablefound,1
		jmp printspace3
		checkfruit3:
		cmp al,fruit
		jne continueright
		mov fruitFound,1
		printspace3:
		mov al,' '
		mov byte ptr [edi+esi],al
		continueright:
		inc pacmanX
		call updatePlayer
		call checkCollisionwithGhosts
		jmp continue
		
continue:
		call checkCollisionwithGhosts
		call checkGameOver
		call levelCompleteCheck
		inc ghostTimer
		mov edx,0
		mov ax, ghostTimer
		mov bx, ghostSpeed
		div bx
		cmp dx,0
		jne dontMoveGhosts
		call checkCollisionwithGhosts
		call moveGhosts
		call checkCollisionwithGhosts
		dontMoveGhosts:
		jmp gameloop

end_program::
	mov eax, white+(black*16)
	call settextcolor
	mov eax, 100
	call delay
	call clrscr
exit
main endp

consoleTitle proc
	
    mov eax, offset consoleTitlePrompt
	invoke SetConsoleTitle,eax 

	ret

consoleTitle endp

setBackgroundColor proc 
	
	mov eax, cyan+(cyan*16)
	call settextcolor
	call clrscr

	ret

setBackgroundColor endp

PrintTitle proc

	call gotoxy
	mov esi, offset PacmanTitle
	l1:
		mov eax, yellow+(yellow*16)
		call settextcolor	
		mov al, byte ptr [esi]
		cmp al,0
		je stop
		cmp al,0ah
		jne printChar
		inc dh
		call gotoxy
		jmp incrementAndJump
	printChar:
		cmp al,' '
		jne skipChangeColor
		mov eax, cyan+(cyan*16)
		call settextcolor
		mov al,' '
	skipChangeColor:
		call WriteChar
	incrementAndJump:
		inc esi
		jmp l1
	mov edx, offset PacmanTitle
	call WriteString
stop:
	mov eax, white+(black*16)
	call settextcolor

	ret

PrintTitle endp

GetUserName proc

	mov eax, yellow+(cyan*16)
	call settextcolor
	add dl,18
	add dh,4
	call gotoxy
	mov edx,offset userNamePrompt
	call WriteString

	mov eax, white+(black*16)
	call settextcolor

	mov edx,offset userName
	mov ecx,lengthof userName - 1
	call ReadString

	ret

GetUserName endp

cursorHide proc

	mov eax, STD_OUTPUT_HANDLE
    invoke GetStdHandle,eax
	mov consoleCursorInfo.dwSize, 1 ; size reduced to minimum
    mov consoleCursorInfo.bVisible, 0 ; visibility false
	mov ebx,offset consoleCursorInfo
    invoke SetConsoleCursorInfo,eax,ebx

	ret

cursorHide endp

menu proc

	mov dl, (screenMaxX-lengthofOneRow)/2
	mov dh,2       ; offset for title
	call PrintTitle
	mov eax, yellow+(cyan*16)
	call settextcolor
	mov dl,28
	mov dh, 25
	call gotoxy
	mov edx,offset playerNamePrompt
	call WriteString
	mov dl,41
	mov dh, 26
	call gotoxy
	mov edx, offset userName
	call WriteString

reCheck:
	cmp optionSelected,1
	jne checkOption2
	mov eax, brown+(black*16)
	call settextcolor
	mov dl, (screenMaxX-lengthof MenuPrompt1)/2
	mov dh,13
	call gotoxy
	mov edx, offset MenuPrompt1
	call WriteString
	mov eax, yellow+(cyan*16)
	call settextcolor
	mov dl, (screenMaxX-lengthof MenuPrompt2)/2
	mov dh,16
	call gotoxy
	mov edx, offset MenuPrompt2
	call WriteString
	mov dl, (screenMaxX-lengthof MenuPrompt3)/2
	mov dh,19
	call gotoxy
	mov edx, offset MenuPrompt3
	call WriteString
	cmp optionPressed,1
	jne takeInput
	mov optionPressed,0
	jmp gamePlay

checkOption2:
	cmp optionSelected,2
	jne checkOption3
	mov eax, brown+(black*16)
	call settextcolor
	mov dl, (screenMaxX-lengthof MenuPrompt2)/2
	mov dh,16
	call gotoxy
	mov edx, offset MenuPrompt2
	call WriteString
	mov eax, yellow+(cyan*16)
	call settextcolor
	mov dl, (screenMaxX-lengthof MenuPrompt1)/2
	mov dh,13
	call gotoxy
	mov edx, offset MenuPrompt1
	call WriteString
	mov dl, (screenMaxX-lengthof MenuPrompt3)/2
	mov dh,19
	call gotoxy
	mov edx, offset MenuPrompt3
	call WriteString
	cmp optionPressed,1
	jne takeInput
	mov optionPressed,0
	call instructionsScreen

checkOption3:
	cmp optionSelected,3
	jne takeInput
	mov eax, brown+(black*16)
	call settextcolor
	mov dl, (screenMaxX-lengthof MenuPrompt3)/2
	mov dh,19
	call gotoxy
	mov edx, offset MenuPrompt3
	call WriteString
	mov eax, yellow+(cyan*16)
	call settextcolor
	mov dl, (screenMaxX-lengthof MenuPrompt1)/2
	mov dh,13
	call gotoxy
	mov edx, offset MenuPrompt1
	call WriteString
	mov dl, (screenMaxX-lengthof MenuPrompt2)/2
	mov dh,16
	call gotoxy
	mov edx, offset MenuPrompt2
	call WriteString
	cmp optionPressed,1
	jne takeInput
	mov optionPressed,0
	jmp end_program


takeInput:
	mov optionPressed,0
	mov eax,100
	call delay
	call readKey
	jz continue
checkEnter:
	cmp dx, vk_return
	jne checkup
	mov optionPressed,1
	jmp recheck
checkup:
	cmp dx,vk_up
	jne checkDown
	cmp optionSelected,1
	jng continue
	dec optionSelected
	jmp recheck
checkDown:
	cmp dx,vk_down
	jne continue
	cmp optionSelected,3
	jnl continue
	inc optionSelected
	jmp recheck

continue:
	jmp takeInput

	ret

menu endp

instructionsScreen proc

	mov eax, cyan+(cyan*16)
	call settextcolor
	call clrscr

	mov dl,screenMaxX/2-20
	mov dh,5

	mov eax,yellow+(cyan*16)
	call settextcolor

	mov esi,offset instructions
	
	l1:
	    call gotoxy
		cmp byte ptr[esi],0
		je return
		cmp byte ptr[esi],0ah
		je nextLine
		inc dl
		mov al,byte ptr [esi]
		call WriteChar
		inc esi
		jmp l1
		nextLine:
		mov dl,screenMaxX/2-20
		add dh,3
		inc esi
		jmp l1

return:
		mov dl,(screenMaxX - lengthof mainmenuPrompt)/2
		add dh,4
		call gotoxy
		mov eax, black+(white*16)
		call settextcolor
		mov edx,offset mainmenuPrompt
		call writeString

menuloop:
		mov eax,50
		call delay
		call readkey
		jz menuloop
		cmp dx,vk_return
		je gameStart
		jmp menuloop
	ret
instructionsScreen endp

drawMaze proc
	mov ebx, offset currentMap
	mov eax, white+(black*16)
	    call settextcolor
		call clrscr
			mov dl, gameBoardStartX
			mov dh, gameBoardStartY
			mov esi, edi
			l1:
				cmp levelNum,1
				jne level2
				mov eax,green+(black*16)
				jmp setcolor
				level2:
				cmp levelNum,2
				jne level3
				mov eax,blue+(black*16)
				jmp setcolor
				level3:
				mov eax,red+(black*16)
				setcolor:
				call settextcolor
				mov al, byte ptr [esi]
				mov byte ptr [ebx],al
				cmp al,0
				je return
				cmp al,eatable
				jne noEatable
				mov eax,yellow+(black*16)
				call settextcolor
				mov al,eatable
				noEatable:
					cmp al,fruit
					jne noFruit
					mov eax,magenta+(black*16)
					call settextcolor
					mov al,fruit
				noFruit:
				cmp al,wall
				jne check1
				mov al,205
				check1:
				cmp al,'|'
				jne check2
				mov al,186
				check2:
				cmp al,'+'
				jne check3
				mov al,201
				check3:
				cmp al,'='
				jne check4
				mov al,187
				check4:
				cmp al,'*'
				jne check5
				mov al,200
				check5:
				cmp al,'/'
				jne check6
				mov al,188
				check6:
				cmp al,'T'
				jne check7
				mov al,203
				check7:
				cmp al,'J'
				jne check8
				mov al,202
				check8:
				cmp al,'Y'
				jne check9
				mov al,204
				check9:
				cmp al,'U'
				jne continue1
				mov al,185
				continue1:
				call gotoxy
				call writeChar
				inc dl
				inc esi
				inc ebx
				cmp dl,gameBoardEndX
				jle continue
				mov dl,gameBoardstartX
				inc dh
			continue:
				jmp l1

return:
	ret

drawMaze endp


drawScoreBoard proc

            mov dl, scoreBoardStartX
			mov dh, scoreBoardStartY
			mov eax,white+(white*16)
			call settextcolor
			mov al,' '
			mov ecx,scoreBoardlengthX
			l1:
				call gotoxy
				call WriteChar
				inc dl
				loop l1

			mov dl, scoreBoardEndX
			mov dh, scoreBoardStartY
			mov ecx,scoreBoardlengthY
			l2:
				call gotoxy
				call WriteChar
				inc dh
				loop l2

			mov dl, scoreBoardEndX
			mov dh, scoreBoardEndY
			mov ecx,scoreBoardlengthX
			l3:
				call gotoxy
				call WriteChar
				dec dl
				loop l3

			mov dl, scoreBoardStartX
			mov dh, scoreBoardEndY
			mov ecx,scoreBoardlengthY
			l4:
				call gotoxy
				call WriteChar
				dec dh
				loop l4

			mov dl, (scoreBoardlengthX - lengthof strScore)/2
			add dl,scoreBoardStartX
			mov dh , 5
			call gotoxy

			mov eax, white+(black*16)
			call settextcolor

			mov edx, offset strscore
			call WriteString

			scoreY = 8
			mov dh,scoreY
			scoreX =  (scoreBoardlengthX - 5)/2
			scoreX = scoreBoardStartX + scoreX
			mov dl,ScoreX

			call gotoxy
			movzx eax, score
			call writeInt
			
			mov dl, (scoreBoardlengthX - lengthof livesPrompt)/2
			add dl,scoreBoardStartX
			mov dh , 13
			call gotoxy
			mov edx, offset livesprompt
			call WriteString

			livesY = 16
			mov dh,livesY
			livesX =  (scoreBoardlengthX - 1)/2
			livesX = scoreBoardStartX + livesX
			mov dl,livesX
		

			call gotoxy
			movzx eax, lives
			call writeInt

			levelY = 20
			mov dh,levelY
			levelX = (scoreBoardlengthX - lengthof levelPrompt)/2
			mov dl,levelX
			add dl, scoreBoardStartX
			levelX = scoreBoardStartX+levelX+3
			levelY = 2+ levelY
			call gotoxy
			mov edx,offset levelPrompt
			call WriteString

			mov dl,levelX
			mov dh,levelY
			call gotoxy
			movzx eax,levelNum
			call WriteInt

			

			ret

drawScoreBoard endp

updateScore proc
	mov eax, white+(black*16)
	call settextcolor

	mov dl, scoreX
	mov dh, scoreY
	call gotoxy

	movzx eax,score
	call WriteInt

	ret
updateScore endp

drawPlayer proc
			mov eax, white+(black*16)
			call settextcolor
			cmp levelNum,3
			jne continue
			PacmanInitialX = gameBoardStartX+29
			PacmanInitialY = gameBoardStartY+10
			mov PacmanX,PacmanInitialX
			mov PacmanY,PacmanInitialY
			mov PacmanPrevX,PacmanInitialX
			mov PacmanPrevY,PacmanInitialY
			jmp move
			continue:
			mov PacmanX,gameBoardStartX+1
			mov pacmanY,gameBoardEndY-1
			mov PacmanprevX,gameBoardStartX+1
			mov pacmanprevY,gameBoardEndY-1
			move:
			mov dl, pacmanX
			mov dh, pacmanY
			call gotoxy

			mov al, pacman
			call WriteChar

			ret

drawPlayer endp

updatePlayer proc
	mov eax,black+(black*16)
	call settextcolor
	mov dl, pacManprevX
	mov dh,pacManprevY
	call gotoxy
	mov al,' '
	call WriteChar

	mov eax, white+(black*16)
	call settextcolor
	cmp teleporterSwitchLeft,1
	jne checkteleporterSwitchRight
	mov pacmanX, teleportRightX-1
	mov pacmanY, teleportRightY
	mov teleporterSwitchLeft,0
	jmp continue
	checkteleporterSwitchRight:
	cmp teleporterSwitchRight,1
	jne continue
	mov pacmanX, teleportLeftX+1
	mov pacmanY, teleportLeftY
	mov teleporterSwitchRight,0
	continue:
	mov dl, pacmanX
	mov dh, pacManY
	call gotoxy
	mov al, pacman
	call WriteChar
	

	mov al,pacmanX
	mov ah, pacmanY
	mov pacmanprevX,al
	mov pacmanprevY,ah

	cmp eatableFound,1
	jne noeatable
	add score,5
	call updateScore
	mov eatablefound,0

noeatable:
	cmp fruitFound,1
	jne nofruit
	add score,50
	call updateScore
	mov fruitfound,0
nofruit:
	ret
updatePlayer endp

drawGhosts proc
	mov eax,ghost1color+(black*16)
	call settextcolor

makeghost1again:
	call randomize
	mov eax, gameBoardlengthx
	call randomrange
	add eax, gameBoardStartX
	mov dl, al
	mov eax, gameBoardlengthy
	call randomRange
	add eax,gameBoardStartY
	mov dh,al
	cmp dl,pacmanX
	jne continue
	cmp dh,pacmanY
	je makeghost1again
	continue:
	movzx ax,dh
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,dl
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,' '
	jne makeghost1again
	mov al,ghost
	call gotoxy
	call writechar
	mov ghost1X,dl
	mov ghost1Y,dh

	mov ghost1prevX,dl
	mov ghost1prevY,dh

	mov eax,ghost2color+(black*16)
	call settextcolor

makeghost2again:
	call randomize
	mov eax, gameBoardlengthx
	call randomrange
	add eax, gameBoardStartX
	mov dl, al
	mov eax, gameBoardlengthy
	call randomRange
	add eax,gameBoardStartY
	mov dh,al
	cmp dl, ghost1X
	jne continue1
	cmp dh,ghost1y
	je makeghost2again
	continue1:
	cmp dl,pacmanX
	jne continue2
	cmp dh,pacmanY
	je makeghost2again
	continue2:
	movzx ax,dh
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,dl
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,' '
	jne makeghost2again
	mov al,ghost
	call gotoxy
	call writechar
	mov ghost2X,dl
	mov ghost2Y,dh

	mov ghost2prevX,dl
	mov ghost2prevY,dh

	ret
drawGhosts endp

drawGhostsForLevel3 proc

	mov eax,ghost1color+(black*16)
	call settextcolor

	mov ghost1x,gameboardStartX+1
	mov ghost1y,gameboardStartY+1
	mov dl, ghost1x
	mov dh,ghost1y
	call gotoxy
	mov al,ghost
	call WriteChar
	mov ghost1prevX,dl
	mov ghost1prevY,dh

	mov eax,ghost2color+(black*16)
	call settextcolor

	mov ghost2x,gameboardEndX-1
	mov ghost2y,gameboardStartY+1
	mov dl, ghost2x
	mov dh,ghost2y
	call gotoxy
	mov al,ghost
	call WriteChar
	mov ghost2prevX,dl
	mov ghost2prevY,dh

	mov eax,ghost3color+(black*16)
	call settextcolor

	mov ghost3x,gameboardStartX+1
	mov ghost3y,gameboardEndY-1
	mov dl, ghost3x
	mov dh,ghost3y
	call gotoxy
	mov al,ghost
	call WriteChar
	mov ghost3prevX,dl
	mov ghost3prevY,dh

	mov eax,ghost4color+(black*16)
	call settextcolor

	mov ghost4x,gameboardEndX-1
	mov ghost4y,gameboardEndY-1
	mov dl, ghost4x
	mov dh,ghost4y
	call gotoxy
	mov al,ghost
	call WriteChar
	mov ghost4prevX,dl
	mov ghost4prevY,dh

	ret
drawGhostsForLevel3 endp

moveGhosts proc

	mov eax,ghost1color+(black*16)
	call settextcolor

	movzx ax,ghost1prevY
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost1prevx
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al, eatable
	je eatableFound1
	cmp al, fruit
	je fruitFound1
	mov dl,ghost1prevX
	mov dh,ghost1prevY
	cmp dl,ghost2x
	jne check1ghost3
	cmp dh,ghost2y
	mov eax,ghost2color+(black*16)
	je ghostFound
	check1ghost3:
		cmp dl,ghost3x
		jne check1ghost4
		cmp dh,ghost3y
		mov eax,ghost3color+(black*16)
		je ghostFound
	check1ghost4:
		cmp dl,ghost4x
		jne continue1
		cmp dh,ghost4y
		mov eax,ghost4color+(black*16)
		je ghostFound
continue1:
	mov eax,black+(black*16)
	call settextcolor
	mov al,' '
	mov dl, ghost1PrevX
	mov dh, ghost1PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost1
eatableFound1:
	mov eax,yellow+(black*16)
	call settextcolor
	mov al,eatable
	mov dl, ghost1PrevX
	mov dh, ghost1PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost1
fruitFound1:
	mov eax,magenta+(black*16)
	call settextcolor
	mov al,fruit
	mov dl, ghost1PrevX
	mov dh, ghost1PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost1
ghostFound:
	call settextcolor
	mov al,ghost
	mov dl, ghost1PrevX
	mov dh, ghost1PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost1

makeGhost1:
	cmp isghost1movingleft,0
	je checkisGhost1MovingUp
	dec ghost1x
	movzx ax,ghost1y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost1x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent
	cmp al,'|'
	je wallpresent
	cmp al,'+'
	je wallpresent
	cmp al,'='
	je wallpresent
	cmp al,'*'
	je wallpresent
	cmp al,'/'
	je wallpresent
	cmp al,'T'
	je wallpresent
	cmp al,'J'
	je wallpresent
	cmp al,'Y'
	je wallpresent
	cmp al,'U'
	jne nowall
	wallpresent:
	inc ghost1x
	mov isghost1movingleft,0
	call randomize
	mov eax,3
	call randomrange
	cmp eax,2
	jne doLeftdown1
	mov isghost1movingup,1
	jmp checkisGhost1MovingUp
	doleftdown1:
	cmp eax,0
	jne doleftright1
	mov isghost1movingdown,1
	jmp checkisGhost1MovingUp
	doleftright1:
	mov isghost1movingright,1 
	jmp checkisGhost1MovingUp

checkisGhost1MovingUp:
	cmp isghost1movingUp,0
	je checkisGhost1MovingRight
	dec ghost1y
	movzx ax,ghost1y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost1x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent1
	cmp al,'|'
	je wallpresent1
	cmp al,'+'
	je wallpresent1
	cmp al,'='
	je wallpresent1
	cmp al,'*'
	je wallpresent1
	cmp al,'/'
	je wallpresent1
	cmp al,'T'
	je wallpresent1
	cmp al,'J'
	je wallpresent1
	cmp al,'Y'
	je wallpresent1
	cmp al,'U'
	jne nowall
	wallpresent1:
	mov isghost1movingup,0
	inc ghost1y
	call randomize
	mov eax,3
	call randomrange
	cmp eax,1
	jne doupdown1
	mov isghost1movingright,1
	jmp checkisGhost1Movingright
	doupdown1:
	cmp eax,0
	jne doupleft1
	mov isghost1movingdown,1
	jmp checkisGhost1Movingright
	doupleft1:
	mov isghost1movingleft,1 
	jmp checkisGhost1Movingright
checkisghost1movingright:
	cmp isghost1movingright,0
	je checkisGhost1MovingDown
	inc ghost1x
	movzx ax,ghost1y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost1x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent2
	cmp al,'|'
	je wallpresent2
	cmp al,'+'
	je wallpresent2
	cmp al,'='
	je wallpresent2
	cmp al,'*'
	je wallpresent2
	cmp al,'/'
	je wallpresent2
	cmp al,'T'
	je wallpresent2
	cmp al,'J'
	je wallpresent2
	cmp al,'Y'
	je wallpresent2
	cmp al,'U'
	jne nowall
	wallpresent2:
	mov isghost1movingright,0
	dec ghost1x
	call randomize
	mov eax,3
	call randomrange
	cmp eax,2
	jne dorightdown1
	mov isghost1movingup,1
	jmp checkisGhost1Movingdown
	dorightdown1:
	cmp eax,1
	jne dorightleft1
	mov isghost1movingdown,1
	jmp checkisGhost1Movingdown
	dorightleft1:
	mov isghost1movingleft,1 
	jmp checkisGhost1Movingdown
checkisghost1movingdown:
	cmp isghost1movingdown,0
	je makeGhost1
	inc ghost1y
	movzx ax,ghost1y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost1x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent3
	cmp al,'|'
	je wallpresent3
	cmp al,'+'
	je wallpresent3
	cmp al,'='
	je wallpresent3
	cmp al,'*'
	je wallpresent3
	cmp al,'/'
	je wallpresent3
	cmp al,'T'
	je wallpresent3
	cmp al,'J'
	je wallpresent3
	cmp al,'Y'
	je wallpresent3
	cmp al,'U'
	jne nowall
	wallpresent3:
	mov isghost1movingdown,0
	dec ghost1y
	call randomize
	mov eax,3
	call randomrange
	cmp eax,1
	jne dodownup1
	mov isghost1movingright,1
	jmp makeGhost1
	dodownup1:
	cmp eax,2
	jne dodownleft1
	mov isghost1movingup,1
	jmp makeGhost1
	dodownleft1:
	mov isghost1movingleft,1 
	jmp makeghost1
nowall:
	mov eax, ghost1color+(black*16)
	call settextcolor
	mov dl,ghost1x
	mov dh,ghost1y

	call gotoxy

	mov al,ghost
	call writechar

	mov ghost1prevx, dl
	mov ghost1prevy, dh

	mov eax,ghost2color+(black*16)
	call settextcolor

	movzx ax,ghost2prevY
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost2prevx
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al, eatable
	je eatableFound2
	cmp al, fruit
	je fruitFound2
	mov dl,ghost2prevX
	mov dh,ghost2prevY
	cmp dl,ghost1x
	jne check2ghost3
	cmp dh,ghost1y
	mov eax,ghost1color+(black*16)
	je ghost1Found
	check2ghost3:
		cmp dl,ghost3x
		jne check2ghost4
		cmp dh,ghost3y
		mov eax,ghost3color+(black*16)
		je ghost1Found
	check2ghost4:
		cmp dl,ghost4x
		jne continue2
		cmp dh,ghost4y
		mov eax,ghost4color+(black*16)
		je ghost1Found
continue2:
	mov eax,black+(black*16)
	call settextcolor
	mov al,' '
	mov dl, ghost2PrevX
	mov dh, ghost2PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost2
eatableFound2:
	mov eax,yellow+(black*16)
	call settextcolor
	mov al,eatable
	mov dl, ghost2PrevX
	mov dh, ghost2PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost2
fruitFound2:
	mov eax,magenta+(black*16)
	call settextcolor
	mov al,fruit
	mov dl, ghost2PrevX
	mov dh, ghost2PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost2
ghost1Found:
	call settextcolor
	mov al,ghost
	mov dl, ghost2PrevX
	mov dh, ghost2PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost2

makeGhost2:
	cmp isghost2movingleft,0
	je checkisGhost2MovingUp
	dec ghost2x
	movzx ax,ghost2y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost2x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent4
	cmp al,'|'
	je wallpresent4
	cmp al,'+'
	je wallpresent4
	cmp al,'='
	je wallpresent4
	cmp al,'*'
	je wallpresent4
	cmp al,'/'
	je wallpresent4
	cmp al,'T'
	je wallpresent4
	cmp al,'J'
	je wallpresent4
	cmp al,'Y'
	je wallpresent4
	cmp al,'U'
	jne nowall1
	wallpresent4:
	inc ghost2x
	mov isghost2movingleft,0
	call randomize
	mov eax,3
	call randomrange
	cmp eax,1
	jne doLeftdown2
	mov isghost2movingup,1
	jmp checkisGhost2MovingUp
	doleftdown2:
	cmp eax,0
	jne doleftright2
	mov isghost2movingdown,1
	jmp checkisGhost2MovingUp
	doleftright2:
	mov isghost2movingright,1 
	jmp checkisGhost2MovingUp

checkisGhost2MovingUp:
	cmp isghost2movingUp,0
	je checkisGhost2MovingRight
	dec ghost2y
	movzx ax,ghost2y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost2x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent5
	cmp al,'|'
	je wallpresent5
	cmp al,'+'
	je wallpresent5
	cmp al,'='
	je wallpresent5
	cmp al,'*'
	je wallpresent5
	cmp al,'/'
	je wallpresent5
	cmp al,'T'
	je wallpresent5
	cmp al,'J'
	je wallpresent5
	cmp al,'Y'
	je wallpresent5
	cmp al,'U'
	jne nowall1
	wallpresent5:
	mov isghost2movingup,0
	inc ghost2y
	call randomize
	mov eax,3
	call randomrange
	cmp eax,1
	jne doupdown2
	mov isghost2movingright,1
	jmp checkisGhost2Movingright
	doupdown2:
	cmp eax,2
	jne doupleft2
	mov isghost2movingdown,1
	jmp checkisGhost2Movingright
	doupleft2:
	mov isghost2movingleft,1 
	jmp checkisGhost2Movingright
checkisghost2movingright:
	cmp isghost2movingright,0
	je checkisGhost2MovingDown
	inc ghost2x
	movzx ax,ghost2y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost2x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent6
	cmp al,'|'
	je wallpresent6
	cmp al,'+'
	je wallpresent6
	cmp al,'='
	je wallpresent6
	cmp al,'*'
	je wallpresent6
	cmp al,'/'
	je wallpresent6
	cmp al,'T'
	je wallpresent6
	cmp al,'J'
	je wallpresent6
	cmp al,'Y'
	je wallpresent6
	cmp al,'U'
	jne nowall1
	wallpresent6:
	mov isghost2movingright,0
	dec ghost2x
	call randomize
	mov eax,3
	call randomrange
	cmp eax,0
	jne dorightdown2
	mov isghost2movingup,1
	jmp checkisGhost2Movingdown
	dorightdown2:
	cmp eax,1
	jne dorightleft2
	mov isghost2movingdown,1
	jmp checkisGhost2Movingdown
	dorightleft2:
	mov isghost2movingleft,1 
	jmp checkisGhost2Movingdown
checkisghost2movingdown:
	cmp isghost2movingdown,0
	je makeGhost2
	inc ghost2y
	movzx ax,ghost2y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost2x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent7
	cmp al,'|'
	je wallpresent7
	cmp al,'+'
	je wallpresent7
	cmp al,'='
	je wallpresent7
	cmp al,'*'
	je wallpresent7
	cmp al,'/'
	je wallpresent7
	cmp al,'T'
	je wallpresent7
	cmp al,'J'
	je wallpresent7
	cmp al,'Y'
	je wallpresent7
	cmp al,'U'
	jne nowall1
	wallpresent7:
	mov isghost2movingdown,0
	dec ghost2y
	call randomize
	mov eax,3
	call randomrange
	cmp eax,0
	jne dodownup2
	mov isghost2movingright,1
	jmp makeGhost2
	dodownup2:
	cmp eax,2
	jne dodownleft2
	mov isghost2movingup,1
	jmp makeGhost2
	dodownleft2:
	mov isghost2movingleft,1 
	jmp makeghost2
nowall1:
	mov eax, ghost2color+(black*16)
	call settextcolor
	mov dl,ghost2x
	mov dh,ghost2y

	call gotoxy

	mov al,ghost
	call writechar

	mov ghost2prevx, dl
	mov ghost2prevy, dh
;------------------------------ for level 3
	cmp levelNum,3
	jne return
	mov eax,ghost3color+(black*16)
	call settextcolor

	movzx ax,ghost3prevY
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost3prevx
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al, eatable
	je eatableFound3
	cmp al, fruit
	je fruitFound3
	mov dl,ghost3prevX
	mov dh,ghost3prevY
	cmp dl,ghost1x
	jne check3ghost2
	cmp dh,ghost1y
	mov eax,ghost1color+(black*16)
	je ghost2Found
	check3ghost2:
		cmp dl,ghost2x
		jne check3ghost4
		cmp dh,ghost2y
		mov eax,ghost2color+(black*16)
		je ghost2Found
	check3ghost4:
		cmp dl,ghost4x
		jne continue3
		cmp dh,ghost4y
		mov eax,ghost4color+(black*16)
		je ghost2Found
continue3:
	mov eax,black+(black*16)
	call settextcolor
	mov al,' '
	mov dl, ghost3PrevX
	mov dh, ghost3PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost3
eatableFound3:
	mov eax,yellow+(black*16)
	call settextcolor
	mov al,eatable
	mov dl, ghost3PrevX
	mov dh, ghost3PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost3
fruitFound3:
	mov eax,magenta+(black*16)
	call settextcolor
	mov al,fruit
	mov dl, ghost3PrevX
	mov dh, ghost3PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost3
ghost2Found:
	call settextcolor
	mov al,ghost
	mov dl, ghost3PrevX
	mov dh, ghost3PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost3

makeGhost3:
	cmp isghost3movingleft,0
	je checkisGhost3MovingUp
	dec ghost3x
	movzx ax,ghost3y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost3x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent8
	cmp al,'|'
	je wallpresent8
	cmp al,'+'
	je wallpresent8
	cmp al,'='
	je wallpresent8
	cmp al,'*'
	je wallpresent8
	cmp al,'/'
	je wallpresent8
	cmp al,'T'
	je wallpresent8
	cmp al,'J'
	je wallpresent8
	cmp al,'Y'
	je wallpresent8
	cmp al,'U'
	jne nowall2
	wallpresent8:
	inc ghost3x
	mov isghost3movingleft,0
	call randomize
	mov eax,3
	call randomrange
	cmp eax,1
	jne doLeftdown3
	mov isghost3movingup,1
	jmp checkisGhost3MovingUp
	doleftdown3:
	cmp eax,0
	jne doleftright3
	mov isghost3movingdown,1
	jmp checkisGhost3MovingUp
	doleftright3:
	mov isghost3movingright,1 
	jmp checkisGhost3MovingUp

checkisGhost3MovingUp:
	cmp isghost3movingUp,0
	je checkisGhost3MovingRight
	dec ghost3y
	movzx ax,ghost3y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost3x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent9
	cmp al,'|'
	je wallpresent9
	cmp al,'+'
	je wallpresent9
	cmp al,'='
	je wallpresent9
	cmp al,'*'
	je wallpresent9
	cmp al,'/'
	je wallpresent9
	cmp al,'T'
	je wallpresent9
	cmp al,'J'
	je wallpresent9
	cmp al,'Y'
	je wallpresent9
	cmp al,'U'
	jne nowall2
	wallpresent9:
	mov isghost3movingup,0
	inc ghost3y
	call randomize
	mov eax,3
	call randomrange
	cmp eax,1
	jne doupdown3
	mov isghost3movingright,1
	jmp checkisGhost3Movingright
	doupdown3:
	cmp eax,2
	jne doupleft3
	mov isghost3movingdown,1
	jmp checkisGhost3Movingright
	doupleft3:
	mov isghost3movingleft,1 
	jmp checkisGhost3Movingright
checkisghost3movingright:
	cmp isghost3movingright,0
	je checkisGhost3MovingDown
	inc ghost3x
	movzx ax,ghost3y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost3x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent10
	cmp al,'|'
	je wallpresent10
	cmp al,'+'
	je wallpresent10
	cmp al,'='
	je wallpresent10
	cmp al,'*'
	je wallpresent10
	cmp al,'/'
	je wallpresent10
	cmp al,'T'
	je wallpresent10
	cmp al,'J'
	je wallpresent10
	cmp al,'Y'
	je wallpresent10
	cmp al,'U'
	jne nowall2
	wallpresent10:
	mov isghost3movingright,0
	dec ghost3x
	call randomize
	mov eax,3
	call randomrange
	cmp eax,0
	jne dorightdown3
	mov isghost3movingup,1
	jmp checkisGhost3Movingdown
	dorightdown3:
	cmp eax,1
	jne dorightleft3
	mov isghost3movingdown,1
	jmp checkisGhost3Movingdown
	dorightleft3:
	mov isghost3movingleft,1 
	jmp checkisGhost3Movingdown
checkisghost3movingdown:
	cmp isghost3movingdown,0
	je makeGhost3
	inc ghost3y
	movzx ax,ghost3y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost3x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent11
	cmp al,'|'
	je wallpresent11
	cmp al,'+'
	je wallpresent11
	cmp al,'='
	je wallpresent11
	cmp al,'*'
	je wallpresent11
	cmp al,'/'
	je wallpresent11
	cmp al,'T'
	je wallpresent11
	cmp al,'J'
	je wallpresent11
	cmp al,'Y'
	je wallpresent11
	cmp al,'U'
	jne nowall2
	wallpresent11:
	mov isghost3movingdown,0
	dec ghost3y
	call randomize
	mov eax,3
	call randomrange
	cmp eax,0
	jne dodownup3
	mov isghost3movingright,1
	jmp makeGhost3
	dodownup3:
	cmp eax,2
	jne dodownleft3
	mov isghost3movingup,1
	jmp makeGhost3
	dodownleft3:
	mov isghost3movingleft,1 
	jmp makeghost3
nowall2:
	mov eax, ghost3color+(black*16)
	call settextcolor
	mov dl,ghost3x
	mov dh,ghost3y

	call gotoxy

	mov al,ghost
	call writechar

	mov ghost3prevx, dl
	mov ghost3prevy, dh

	mov eax,ghost4color+(black*16)
	call settextcolor

	movzx ax,ghost4prevY
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost4prevx
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al, eatable
	je eatableFound4
	cmp al, fruit
	je fruitFound4
	mov dl,ghost4prevX
	mov dh,ghost4prevY
	cmp dl,ghost1x
	jne check4ghost2
	cmp dh,ghost1y
	mov eax,ghost1color+(black*16)
	je ghost3Found
	check4ghost2:
		cmp dl,ghost2x
		jne check4ghost3
		cmp dh,ghost2y
		mov eax,ghost2color+(black*16)
		je ghost3Found
	check4ghost3:
		cmp dl,ghost3x
		jne continue4
		cmp dh,ghost3y
		mov eax,ghost3color+(black*16)
		je ghost3Found
continue4:
	mov eax,black+(black*16)
	call settextcolor
	mov al,' '
	mov dl, ghost4PrevX
	mov dh, ghost4PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost4
eatableFound4:
	mov eax,yellow+(black*16)
	call settextcolor
	mov al,eatable
	mov dl, ghost4PrevX
	mov dh, ghost4PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost4
fruitFound4:
	mov eax,magenta+(black*16)
	call settextcolor
	mov al,fruit
	mov dl, ghost4PrevX
	mov dh, ghost4PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost4
ghost3Found:
	call settextcolor
	mov al,ghost
	mov dl, ghost4PrevX
	mov dh, ghost4PrevY
	call gotoxy
	call WriteChar
	jmp makeGhost4

makeGhost4:
	cmp isghost4movingleft,0
	je checkisGhost4MovingUp
	dec ghost4x
	movzx ax,ghost4y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost4x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent12
	cmp al,'|'
	je wallpresent12
	cmp al,'+'
	je wallpresent12
	cmp al,'='
	je wallpresent12
	cmp al,'*'
	je wallpresent12
	cmp al,'/'
	je wallpresent12
	cmp al,'T'
	je wallpresent12
	cmp al,'J'
	je wallpresent12
	cmp al,'Y'
	je wallpresent12
	cmp al,'U'
	jne nowall3
	wallpresent12:
	inc ghost4x
	mov isghost4movingleft,0
	call randomize
	mov eax,3
	call randomrange
	cmp eax,1
	jne doLeftdown4
	mov isghost4movingup,1
	jmp checkisGhost4MovingUp
	doleftdown4:
	cmp eax,2
	jne doleftright4
	mov isghost4movingdown,1
	jmp checkisGhost4MovingUp
	doleftright4:
	mov isghost4movingright,1 
	jmp checkisGhost4MovingUp

checkisGhost4MovingUp:
	cmp isghost4movingUp,0
	je checkisGhost4MovingRight
	dec ghost4y
	movzx ax,ghost4y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost4x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent13
	cmp al,'|'
	je wallpresent13
	cmp al,'+'
	je wallpresent13
	cmp al,'='
	je wallpresent13
	cmp al,'*'
	je wallpresent13
	cmp al,'/'
	je wallpresent13
	cmp al,'T'
	je wallpresent13
	cmp al,'J'
	je wallpresent13
	cmp al,'Y'
	je wallpresent13
	cmp al,'U'
	jne nowall3
	wallpresent13:
	mov isghost4movingup,0
	inc ghost4y
	call randomize
	mov eax,3
	call randomrange
	cmp eax,1
	jne doupdown4
	mov isghost4movingright,1
	jmp checkisGhost4Movingright
	doupdown4:
	cmp eax,2
	jne doupleft4
	mov isghost4movingdown,1
	jmp checkisGhost4Movingright
	doupleft4:
	mov isghost4movingleft,1 
	jmp checkisGhost4Movingright
checkisghost4movingright:
	cmp isghost4movingright,0
	je checkisGhost4MovingDown
	inc ghost4x
	movzx ax,ghost4y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost4x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent14
	cmp al,'|'
	je wallpresent14
	cmp al,'+'
	je wallpresent14
	cmp al,'='
	je wallpresent14
	cmp al,'*'
	je wallpresent14
	cmp al,'/'
	je wallpresent14
	cmp al,'T'
	je wallpresent14
	cmp al,'J'
	je wallpresent14
	cmp al,'Y'
	je wallpresent14
	cmp al,'U'
	jne nowall3
	wallpresent14:
	mov isghost4movingright,0
	dec ghost4x
	call randomize
	mov eax,3
	call randomrange
	cmp eax,2
	jne dorightdown4
	mov isghost4movingup,1
	jmp checkisGhost4Movingdown
	dorightdown4:
	cmp eax,0
	jne dorightleft4
	mov isghost4movingdown,1
	jmp checkisGhost4Movingdown
	dorightleft4:
	mov isghost4movingleft,1 
	jmp checkisGhost4Movingdown
checkisghost4movingdown:
	cmp isghost4movingdown,0
	je makeGhost4
	inc ghost4y
	movzx ax,ghost4y
	sub ax,gameBoardStartY
	mov bl, gameBoardlengthX
	mul bl
	movzx bx,ghost4x
	sub bx,gameBoardStartX
	add ax,bx
	movzx esi,ax
	mov al, byte ptr [edi+esi]
	cmp al,wall
	je wallpresent15
	cmp al,'|'
	je wallpresent15
	cmp al,'+'
	je wallpresent15
	cmp al,'='
	je wallpresent15
	cmp al,'*'
	je wallpresent15
	cmp al,'/'
	je wallpresent15
	cmp al,'T'
	je wallpresent15
	cmp al,'J'
	je wallpresent15
	cmp al,'Y'
	je wallpresent15
	cmp al,'U'
	jne nowall3
	wallpresent15:
	mov isghost4movingdown,0
	dec ghost4y
	call randomize
	mov eax,3
	call randomrange
	cmp eax,0
	jne dodownup4
	mov isghost4movingright,1
	jmp makeGhost4
	dodownup4:
	cmp eax,1
	jne dodownleft4
	mov isghost4movingup,1
	jmp makeGhost4
	dodownleft4:
	mov isghost4movingleft,1 
	jmp makeghost4
nowall3:
	mov eax, ghost4color+(black*16)
	call settextcolor
	mov dl,ghost4x
	mov dh,ghost4y

	call gotoxy

	mov al,ghost
	call writechar

	mov ghost4prevx, dl
	mov ghost4prevy, dh
return:
	ret
	
moveGhosts endp

updateLives proc
	mov dl, livesX
	mov dh, livesY
	call gotoxy

	mov eax, white+(black*16)
	call settextcolor
	movzx eax, lives
	call WriteInt

return:
	ret
updateLives endp
	
checkCollisionWithGhosts proc

	mov dl, pacmanX
	mov dh, pacmanY

	cmp dl,ghost1x
	jne checkGhost2
	cmp dh,ghost1y
	jne checkGhost2
	je decrementLives

checkGhost2:
	cmp dl,ghost2x
	jne checkGhost3
	cmp dh,ghost2y
	je decrementLives

checkGhost3:
	cmp dl,ghost3x
	jne checkGhost4
	cmp dh,ghost3y
	je decrementLives

checkGhost4:
	cmp dl,ghost4x
	jne return
	cmp dh,ghost4y
	jne return


decrementLives:
	dec lives
	invoke PlaySoundA, addr ghosteatSound,NULL,0
	call drawPlayer
	call updateLives
return:
 ret
checkCollisionWithGhosts endp

convertInttoString proc
mov count,0
l1:
	mov edx,0
	mov ebx,10
	div ebx
	cmp edx,-1
	je stop
	add edx,48
	push edx
	add count,1
	cmp eax,0
	je stop
	jne l1

stop:

movzx ecx,count
l2:

pop edx
mov [esi],dl
inc esi
loop l2

ret
convertInttoString endp

gameOverTransition proc
	

	mov esi,offset PlayerDetails
	mov al,0
	mov byte ptr [esi],al
	inc esi
	mov edx,offset userName
	mov ecx,lengthof userName

	addUserNametoPlayerDetails:
		mov al, byte ptr [edx]
		cmp al,0
		je addSpace
		cmp al,0ah
		jne dontAddSpace
		addSpace:
		mov al,space
		dontAddspace:
		mov byte ptr [esi],al
		inc esi
		inc edx
		loop addUserNametoPlayerDetails

	movzx eax,score
	call convertInttoString

	mov ecx,spacesbetweenHeadings
	add ecx,5
	movzx eax,count
	sub ecx,eax
	mov al,space
	printSpaces:
		mov byte ptr [esi],al
		inc esi
		loop printSpaces

	movzx eax,levelNum
	sub eax,1
	add eax,48
	mov byte ptr [esi],al
	inc esi
	mov al,0ah
	mov byte ptr [esi],al

	mov esi,offset PlayerDetails
	mov ecx,0
	calculateSize:
		cmp byte ptr [esi],0ah
		je sizeCalculationDone
		inc ecx
		inc esi
		jmp calculateSize

	sizeCalculationDone:
	add ecx,1
	invoke WriteFile,fileHandle,offset PlayerDetails,ecx,offset bytesWritten,NULL
	

	mov eax,white+(black*16)
	call settextcolor
	call clrscr
	mov dl, (screenMaxX-lengthGameOverStr)/2
	mov bl,dl
	mov dh, (screenMaxY-heightGameOverStr)/2
	sub dh,3
	mov esi, offset GameOver
	l1:
	    mov eax,red+(black*16)
	    call settextcolor
		cmp byte ptr [esi],0
		je return
		cmp byte ptr [esi],' '
		jne nospace
		mov eax, black+(black*16)
		call settextcolor
		nospace:
			mov al,byte ptr [esi]
	        call gotoxy
			call WriteChar
		mov al,dl
		sub al, lengthgameOverStr
		cmp al,bl
		jne continue
		mov dl,bl
		inc dh
		continue:
			inc dl
			inc esi
		jmp l1
return:
		mov eax, green+(black*16)
		call settextcolor
		mov dl, 20
		add dh,4
		mov bl,dh
		call gotoxy
		mov edx, offset playerNameprompt
		call writeString
		mov eax, white+(black*16)
		call settextcolor
		mov edx,offset userName
		call WriteString

		mov eax, yellow+(black*16)
		call settextcolor
		mov dl,20
		add dl,40
		mov bh,dl
		mov dh,bl
		call gotoxy
		mov edx, offset endScorestr
		call writeString
		mov eax, white+(black*16)
		call settextcolor
		movzx eax,score
		call Writedec

		mov eax, green+(black*16)
		call settextcolor
		mov dl,bh
		add dl,30
		mov dh,bl
		call gotoxy
		mov edx, offset endlevelStr
		call writeString
		mov eax, white+(black*16)
		call settextcolor
		movzx eax,levelNum
		sub eax,1
		call Writedec

		mov dl,(screenMaxX - lengthof mainmenuPrompt)/2
		mov dh,bl
		add dh,4
		call gotoxy
		mov eax, black+(white*16)
		call settextcolor
		mov edx,offset mainmenuPrompt
		call writeString
		mov score,0
		mov lives,3
		cmp levelNum,4
		jne menuloop
		mov levelNum,1
		mov ghostSpeed,6
		mov ghost3x,0
		mov ghost3y,0
		mov ghost4x,0
		mov ghost4y,0

menuloop:
		mov eax,50
		call delay
		call readkey
		jz menuloop
		cmp dx,vk_return
		je gameStart
		jmp menuloop
	
	ret

gameOverTransition endp 

checkGameOver proc
	cmp lives,0
	je endgame
	jne return
endgame:
	mov esi,edi
	mov edx,offset currentMap
	l1:
		mov al, byte ptr [edx]
		mov byte ptr [esi],al
		cmp al,0
		je continueProcess
		inc esi
		inc edx
		jmp l1
	continueProcess:
	call gameOverTransition
return:
	ret
checkGameOver endp 

levelCompletedTransition proc

	mov esi,edi
	mov edx,offset currentMap
	l2:
		mov al, byte ptr [edx]
		mov byte ptr [esi],al
		cmp al,0
		je continueProcess
		inc esi
		inc edx
		jmp l2
	continueProcess:

	call setBackgroundColor
	mov dl, (screenMaxX-lengthlevelCompletedStr)/2
	mov bl,dl
	mov dh, (screenMaxY-heightlevelCompletedStr)/2

	mov esi, offset levelCompleted
	l1:
	    mov eax,yellow+(cyan*16)
	    call settextcolor
		cmp byte ptr [esi],0
		je return
		cmp byte ptr [esi],' '
		jne nospace
		mov eax, cyan+(cyan*16)
		call settextcolor
		nospace:
			mov al,byte ptr [esi]
	        call gotoxy
			call WriteChar
		mov al,dl
		sub al, lengthlevelCompletedStr
		cmp al,bl
		jne continue
		mov dl,bl
		inc dh
		continue:
			inc dl
			inc esi
		jmp l1
return:
	ret
levelCompletedTransition endp

levelCompleteCheck proc
	mov esi,edi ;edi already contains the offset of the current map

	l1:
		cmp byte ptr [esi], 0
		je levelComplete
		cmp byte ptr [esi],'.'
		je return
		inc esi
		jmp l1

levelComplete:
	call levelCompletedTransition
	mov eax,1000
	call delay
	sub ghostspeed,2
	inc levelNum
	cmp levelNum,4
	jne gameplay1
	call gameOverTransition
	jmp return
	gameplay1:
	call gamePlay

return:

	ret
levelCompleteCheck endp
end main