;------------------------------------------
; PURPOSE : Game: Starve
; SYSTEM  : Turbo Assembler Ideal Mode  
; AUTHOR  : Re'em Kishnevsky
; Date    : July 2017 
;------------------------------------------

		IDEAL
		
		MODEL small
		
		;LIST OF SCREEN ID's
		;-------------------
		;Intro - 0
		;Menu Play - 1
		;Menu Help - 2
		;Menu Exit - 3
		;Game - 4
		;Help - 5
		
		;LIST OF OBJECTS ID's
		;-------------------
		;Tree - 0
		;Rock - 1
		;Lake - 2
		
		STACK 100h
		
		SPAN equ 34000
		
		KEY_RIGHT_DOWN equ 77
        KEY_LEFT_DOWN  equ 75
        KEY_UP_DOWN    equ 72
        KEY_DOWN_DOWN  equ 80
		
		KEY_RIGHT_UP  equ 11001101b
        KEY_LEFT_UP   equ 11001011b
        KEY_UP_UP     equ 11001000b
        KEY_DOWN_UP   equ 11010000b
		
		PLAYER_FACING_UP equ 0
		PLAYER_FACING_RIGHT equ 1
		PLAYER_FACING_DOWN equ 2
		PLAYER_FACING_LEFT equ 3

		DATASEG
		include 'G_Assets\Screens.txt'
		irritator db ?
		tree_color db  2,2,2,2,2,2,10,10,10,10,2,2,2,2,2,2,2,2 
				   db  2,2,2,10,10,10,10,6,10,10,10,10,10,2,2,2,2,2
				   db  2,10,10,10,10,10,10,6,6,10,10,10,10,10,10,2,2,2
				   db  10,10,10,10,10,10,10,10,6,6,10,6,6,10,10,10,2,2
				   db  10,10,10,6,6,10,10,10,6,10,10,6,10,10,10,10,10,2
				   db  10,10,10,10,6,6,6,6,6,6,6,6,10,10,10,10,10,10
				   db  2,2,10,10,10,10,6,10,10,6,6,6,6,6,10,10,6,10
				   db  2,2,10,10,10,10,6,6,6,6,6,6,6,10,10,6,10
				   db  2,10,10,10,10,10,10,10,6,6,6,6,6,10,10,6,6,10
				   db  2,10,10,6,6,6,6,10,10,6,6,6,10,10,6,6,10,10
				   db  10,10,6,6,10,10,6,6,6,6,6,6,10,10,6,10,10,10
				   db  10,10,10,10,10,10,10,10,6,6,6,6,6,6,6,6,6,10
				   db  2,2,10,10,10,10,2,2,6,6,6,6,6,10,10,6,10,10
				   db  2,2,2,2,2,2,2,2,6,6,6,6,2,2,10,10,10,2
				   db  2,2,2,2,2,2,2,2,6,6,6,6,6,2,2,2,2,2
				   db  2,2,2,2,2,2,2,6,6,6,6,6,6,2,2,2,2,2
				   db  2,2,2,2,2,2,6,6,6,6,6,6,6,6,2,2,2,2
				   db  2,2,2,2,2,6,6,6,6,2,2,6,6,6,6,6,2,2,2
				   
		rock_color db 2,2,2,2,2,8,8,8,8,8,2,2,2,2,2,2,2,2 
				   db 2,2,2,2,8,8,7,7,7,8,8,2,2,2,2,2,2,2
				   db 2,2,2,8,8,7,7,8,7,7,7,8,2,2,2,2,2,2
				   db 2,8,8,7,7,8,8,7,7,7,0,8,8,8,2,2,2,2
				   db 8,8,8,8,8,8,8,8,7,7,0,7,7,8,8,8,2,2
				   db 8,7,8,8,8,7,8,8,8,0,7,7,8,8,7,8,8,2
				   db 8,8,8,7,8,8,8,8,0,8,8,8,8,7,7,7,7,8
				   db 0,8,8,8,7,7,8,8,0,0,8,8,7,7,7,7,7,8
				   db 0,0,0,8,8,8,8,0,2,0,8,7,7,7,8,7,7,8
				   db 2,2,0,0,0,0,0,2,2,0,7,7,7,8,8,7,7,8
				   db 2,2,2,2,2,2,2,2,2,0,0,7,7,7,7,8,8,8
				   db 2,2,2,2,2,2,2,2,2,2,2,0,0,0,0,0,2,2
				   
		lake_color db 02,02,02,02,02,02,02,02,02,02,06,06,06,06,06,06,06,06,06,02,02,02,02,02,02,02,02,02,02,02,02,02
				   db 06,06,02,02,02,02,02,02,06,06,06,03,03,03,03,03,03,03,06,06,02,02,02,02,02,06,06,06,06,06,02,02
				   db 06,03,06,06,06,02,06,06,06,03,03,03,03,03,03,11,11,03,03,03,06,06,06,06,06,06,03,03,03,06,06,02
				   db 06,03,03,03,06,06,06,03,03,03,03,03,11,11,11,09,09,03,03,03,03,03,03,03,03,03,03,11,11,03,06,02
				   db 06,03,03,03,03,03,03,03,03,03,03,11,11,09,09,03,03,03,03,03,03,03,03,11,11,11,11,09,09,03,06,02
				   db 06,03,03,03,03,03,03,03,10,03,03,09,09,03,03,03,03,03,03,03,03,11,11,11,09,09,09,03,03,03,06,06
				   db 06,03,03,03,03,03,03,10,02,10,03,03,03,03,03,03,03,03,03,03,03,09,09,09,03,03,03,03,03,03,03,06
				   db 06,03,03,03,03,03,03,03,10,03,03,03,03,03,03,03,11,11,03,03,03,03,03,03,03,03,03,10,03,03,03,06
				   db 06,03,03,03,03,03,03,11,11,03,03,03,03,03,11,11,03,03,10,03,03,03,03,03,03,03,03,03,03,03,06,06
				   db 06,06,03,03,03,11,11,09,09,03,03,03,03,03,03,03,03,10,02,10,03,03,11,11,03,10,03,03,03,06,06,02
				   db 02,06,03,03,11,09,09,03,03,03,03,03,03,03,03,03,03,03,10,11,11,11,09,09,03,03,10,03,03,06,02,02
				   db 02,06,06,03,09,03,03,03,03,03,03,03,06,06,06,06,03,03,03,03,09,09,03,03,03,03,03,06,06,06,02,02
				   db 02,02,06,06,03,03,03,03,03,06,06,06,06,02,02,06,06,06,03,03,03,03,03,03,06,06,06,06,02,02,02,02
				   db 02,02,02,06,06,06,06,06,06,06,02,02,02,02,02,02,02,02,06,06,06,06,06,06,06,02,02,02,02,02,02,02
				   
		player_up    	db  02,02,02,02,02,02,02,02,02,02,02,02
						db  02,02,02,02,14,14,14,14,02,02,02,02
						db	02,14,02,14,14,14,14,14,14,02,14,02
						db	02,14,06,14,14,14,14,14,14,06,14,02
						db	02,14,06,14,14,14,14,14,14,06,14,02
						db	02,02,02,14,14,14,14,14,14,02,02,02
						db	02,02,02,02,14,14,14,14,02,02,02,02
						db  02,02,02,02,02,02,02,02,02,02,02,02
						
		player_down		db  02,02,02,02,02,02,02,02,02,02,02,02
						db  02,02,02,02,14,14,14,14,02,02,02,02
						db	02,02,02,14,14,14,14,14,14,02,02,02
						db	02,14,06,14,14,14,14,14,14,06,14,02
						db	02,14,06,14,14,14,14,14,14,06,14,02
						db	02,14,02,14,14,14,14,14,14,02,14,02
						db	02,02,02,02,14,14,14,14,02,02,02,02
						db  02,02,02,02,02,02,02,02,02,02,02,02
						
		player_right 	db  02,02,02,02,02,02,02,02
						db	02,02,02,14,14,14,02,02
						db	02,02,02,06,06,02,02,02
						db	02,02,14,14,14,14,02,02
						db	02,14,14,14,14,14,14,02
						db	02,14,14,14,14,14,14,02
						db	02,14,14,14,14,14,14,02
						db	02,14,14,14,14,14,14,02
						db	02,02,14,14,14,14,02,02
						db	02,02,02,06,06,02,02,02
						db	02,02,02,14,14,14,02,02
						db  02,02,02,02,02,02,02,02
						
		player_left 	db  02,02,02,02,02,02,02,02
						db  02,02,14,14,14,02,02,02
						db	02,02,02,06,06,02,02,02
						db	02,02,14,14,14,14,02,02
						db	02,14,14,14,14,14,14,02
						db	02,14,14,14,14,14,14,02
						db	02,14,14,14,14,14,14,02
						db	02,14,14,14,14,14,14,02
						db	02,02,14,14,14,14,02,02
						db	02,02,02,06,06,02,02,02
						db	02,02,14,14,14,02,02,02
						db  02,02,02,02,02,02,02,02
					 
		counter dw 300
					 
		player_max_x db 10
		player_max_y db 6
		player_x dw ?
		player_y dw ?
		player_direction dw ?
		player_old_direction dw ?
		
		key db ?
		
		object_id db ? 
		object_x dw ?
		object_y dw ?   
		object_max_x db ?
		object_max_y db ?
		object_count db ?
		
		pointer_MovePlayer dw ?
		pointer_CheckPlayerVacancy dw ?
		pointer_DeletePlayer dw ?
		pointer_PrintPlayer dw ?
		
		Screen db ?
		
		trash dw ?
		
		CODESEG
Start:
        mov ax, @data
        mov ds, ax
		
		;Sets graphics mode
		mov ax, 13h	
		int 10h
		
		;Sets cursor position 0,0
		mov dh, 0
		mov dl, 0
		call SetCursorPosition
		
		;Prints screen: intro
		mov dx, offset intro
		call PrintScreen
		mov [Screen], 0
		
		call ReadKeyInput
	
Print_screen_menuP:	
		;Prints screen: menuP
		mov dx, offset menuP
		call PrintScreen
		mov [Screen], 1
		
		;Determines Screen Selection
		call DetermineLabelSelection
		cmp bl,1
		je Play
		cmp bl, 2
		je Help
		cmp bl, 3
		je Exit

Help:		
		mov dx, offset screenH  
		call PrintScreen      
		mov [Screen], 5
	Help_check_ESC:
		call ReadKeyInput
		cmp ah, 1
		jne Help_Check_ESC
		jmp Print_screen_menuP
		
Play:	;Sets grass background	
		call PaintScreen
		call Randomize 		;Generates seed
		
		call SpawnPlayer
		
		;Places Lakes
		mov [object_id], 2 ;Sets object to lake
		mov [object_count], 5 ;Sets amount of lakes to print
		call PrintMultipleObjects
		
		;Places Trees
		mov [object_id], 0 ;Sets object to tree
		mov [object_count], 10 ;Sets amount of trees to print
		call PrintMultipleObjects
		
		;Places Rocks
		mov [object_id], 1 ;Sets object to rock
		mov [object_count], 10 ;Sets amount of rocks to print
		call PrintMultipleObjects
		
Main_loop:	
		call MovePlayer
		cmp al, 1
		je Print_screen_menuP
		jmp Main_loop
		
Exit:   
		;Clears screen
		mov al, 0
		call ClearScreen
		
		;Sets text mode
		mov ah, 0
		mov al, 2	
		int 10h
		
		;Finishes program
        mov ax, 4C00h
        int 21h
	
;----------------------------------------------------------------
;PaintScreen - Paints the screen in red and green
;----------------------------------------------------------------
;Input:
;		none
;Output:
;		Screen Color
;Registers:
;		ah, al, bh, cx, dx, 
;----------------------------------------------------------------
PROC PaintScreen
		mov bh,0h
		mov al, 3
		mov cx, 0 ;x
		mov dx, 0 ;y
@@Border1:	
		mov ah,0Ch
		int 10h
		inc cx
		cmp cx, 319
		jnz @@Border1
@@Border2:
		mov ah,0Ch
		int 10h
		inc dx
		cmp dx, 199
		jnz @@Border2
@@Border3:
		mov ah,0Ch
		int 10h
		dec cx
		cmp cx, 0
		jnz @@Border3
@@Border4:
		mov ah,0Ch
		int 10h
		dec dx
		cmp dx, 0
		jnz @@Border4

		mov al, 2
		mov cx,1 ;x
		mov dx,1 ;y
@@Green:mov ah,0Ch
		int 10h
		inc cx
		cmp cx, 319
		jnz @@Green
		mov cx, 1
		inc dx
		cmp dx, 199
		jnz @@Green
		ret
ENDP PaintScreen 

;----------------------------------------------------------------
;ClearScreen - Clears the screen 
;----------------------------------------------------------------
;Input:
;		none
;Output:
;		Screen color black
;Registers:
;		ah, al, bh, cx, dx, 
;----------------------------------------------------------------
PROC ClearScreen
		mov cx, 0
		mov dx, 0
		mov al, 0
		
@@Clear:
		mov ah,0Ch
		int 10h
		inc cx
		cmp cx, 319
		jnz @@Clear
		mov cx, 1
		inc dx
		cmp dx, 199
		jnz @@Clear
		ret
ENDP ClearScreen

;----------------------------------------------------------------
;SetCursorPosition - Sets cursor position for text writing
;----------------------------------------------------------------
;Input:
;		dh <- Line, dl <- Column
;Output:
;		Cursor position
;Registers:
;		ah, bh, dh, dl
;----------------------------------------------------------------
Proc SetCursorPosition
		mov bh, 0	
		mov ah, 2h	
		int 10h
		ret
ENDP SetCursorPosition

;----------------------------------------------------------------
;PrintScreen - Prints a specific predefined screen
;----------------------------------------------------------------
;Input:
;		dx <- Screen Variable
;Output:
;	  	New Screen
;Registers:
;		ah, bh, dx,
;----------------------------------------------------------------
PROC PrintScreen
		mov ah, 9h
		int 21h
		ret
ENDP PrintScreen

;-----------------------------------------------------------------------------------------------------
;DetermineLabelSelection - Determines which label should be selected and selects the label accordingly 
;-----------------------------------------------------------------------------------------------------
;Input:
;		Keyboard key press, Variable [Screen]
;Output:
;		Label selection, bl <- Viewed screen in the time of enter press
;Registers:
;		ah, al, bl, dx
;-----------------------------------------------------------------------------------------------------
Proc DetermineLabelSelection
@@Check_again:		
        ;Reads keyboard input
		mov ah, 00h
		int 16h
		
		;Finds pressed key
		cmp ah, 72
		je @@Up
		cmp ah, 80
		je @@Down
		cmp al, 0Dh
		je @@Enter
		jmp @@Check_again
		
@@Up:	cmp [screen], 1
		je @@Check_again
		cmp [screen], 2
		je @@Up2
		cmp [screen], 3
		je @@Up3
		
@@Down:	cmp [screen], 1
		je @@Down1
		cmp [screen], 2
		je @@Down2
		cmp [screen], 3
		jmp @@Check_again
		
@@Enter: cmp [screen], 1
		je @@Enter1
		cmp [screen], 2
		je @@Enter2
		cmp [screen], 3
		je @@Enter3
		
		
@@Up2:	mov dx, offset menuP
		call PrintScreen
		mov [screen], 1
		jmp @@Check_again
		
@@Up3:	mov dx, offset menuH
		call PrintScreen
		mov [screen], 2
		jmp @@Check_again
		
		
@@Down1:	mov dx, offset menuH
		call PrintScreen
		mov [screen], 2
		jmp @@Check_again
		
@@Down2:	mov dx, offset menuE
		call PrintScreen
		mov [screen], 3
		jmp @@Check_again
		
		
@@Enter1:mov bl, 1
		jmp @@cont
		
@@Enter2:mov bl, 2
		jmp @@cont
		
@@Enter3:mov bl, 3
		jmp @@cont
		
@@cont:	ret
ENDP DetermineLabelSelection

;-----------------------------------------
;ReadKeyInput - Reads key input
;-----------------------------------------
;Input:
;		Keyboard key press
;Output:
;		ah <- scan code, al <- ascii code
;Registers:
;		ah
;-----------------------------------------
Proc ReadKeyInput
		mov ah, 00h
		int 16h
		ret
ENDP ReadKeyInput

;--------------------------------------------------------------
;PlaceObject - Places an object
;--------------------------------------------------------------
;Input:
;		[object_id] <- Object ID, ([object_x],[object_y]) <- (x,y) of the upper left corner of the object
;Output:
;		Printed object
;Registers:
;		ah, al, bh, bl, cx, dx, si 
;--------------------------------------------------------------
Proc PlaceObject
		mov bh, 0
		dec [object_x]
		dec [object_y]
		mov cx, [object_x]
		mov dx, [object_y]
;Determines object id
		cmp [object_id], 1
		je Set_rock_check
		cmp [object_id], 2
		je Set_lake_check
		mov bl, 20
		mov [object_max_y], 20
		mov si, offset tree_color
		jmp Object_check_pixel
		
Set_rock_check:
		mov bl, 20
		mov [object_max_y], 14
		mov si, offset rock_color
		jmp Object_check_pixel
		
Set_lake_check:
		mov bl, 34
		mov [object_max_y], 16
		mov si, offset lake_color
		
;Checks if the object can be placed (And it's position isn't already taken by another object)
Object_check_pixel:
		mov ah, 0Dh
		int 10h
		cmp al, 2
		jne Object_occupied
		inc cx
		dec [object_max_x]
		jnz Object_check_pixel
		mov cx, [object_x]
		mov [object_max_x], bl
		inc dx
		dec [object_max_y]
		jnz Object_check_pixel
		inc [object_x]
		inc [object_y]
		
		sub bl, 2
		mov [object_max_x], bl
		cmp [object_id], 1
		je Set_rock_print
		cmp [object_id], 2
		je Set_lake_print
		mov [object_max_y], 18
		mov dx, [object_y]
		jmp Object_print_pixel
		
Set_rock_print:
		mov [object_max_y], 12
		mov cx, [object_x]
		mov dx, [object_y]
		jmp Object_print_pixel
		
Set_lake_print:
		mov [object_max_y], 14
		mov cx, [object_x]
		mov dx, [object_y]
		
Object_print_pixel:
		mov al, [si]
		mov ah, 0Ch
		int 10h
		inc si
		inc cx
		dec [object_max_x]
		jnz Object_print_pixel
		mov [object_max_x], bl
		inc dx
		mov cx, [object_x]
		dec [object_max_y]
		jnz Object_print_pixel
		jmp Object_success
		
Object_occupied:
		inc [object_count]
Object_success:
		ret
ENDP PlaceObject

;--------------------------------------------------------------
;GenerateRandomCordinates - Generates a random point
;--------------------------------------------------------------
;Input:
;		None
;Output:
;		([object_x],[object_y]) <- Random point
;Registers:
;		ax 
;--------------------------------------------------------------
PROC GenerateRandomCordinates
		mov ax, 179
		push ax
		call random
		mov [object_y], ax
		mov ax, 299
		push ax
		call random
		mov [object_x], ax
		ret
ENDP GenerateRandomCordinates

;------------------------------------------------------------------------------------
;PrintMultipleObjects - Places multiple objects
;------------------------------------------------------------------------------------
;Input:
;		[object_id] <- ID of the object, [object_count] <- Amount of objects to print
;Output:
;		Multiple printed objects
;Registers:
;		ah, al, bh, bl, cx, dx, si
;------------------------------------------------------------------------------------
Proc PrintMultipleObjects
Object_print:
		call GenerateRandomCordinates
		call PlaceObject
		dec [object_count]
		jnz Object_print
		ret
ENDP PrintMultipleObjects

;------------------------------------------------------------------------------------
;MovePlayer - Moves the player
;------------------------------------------------------------------------------------
;Input:
;		none
;Output:
;		Player movement
;Registers:
;		ah, al, bh, bl, dx, cx, si
;------------------------------------------------------------------------------------
PROC MovePlayer
		pop [pointer_MovePlayer] 
		
;-----  Read SCAN code from keyboard port
    	in al,060h
        mov [key], al

;----- Checking key is released 	
        cmp [key], KEY_UP_UP
        je @@Mid_no_arrow

        cmp [key], KEY_DOWN_UP
        je @@Mid_no_arrow


        cmp [key], KEY_RIGHT_UP
        je @@Mid_no_arrow

        cmp [key], KEY_LEFT_UP
        je @@Mid_no_arrow

;----- Checking key is pressed
        cmp [key], KEY_UP_DOWN
	    je Up

        cmp [key], KEY_DOWN_DOWN
    	je Down

        cmp [key], KEY_RIGHT_DOWN
    	je Right

        cmp [key], KEY_LEFT_DOWN
        jne @@Mid_no_arrow

        cmp [player_direction], PLAYER_FACING_UP
		je @@Mid_left_facing_up_down
		cmp [player_direction], PLAYER_FACING_RIGHT
		je @@Mid_left_facing_right_left
		cmp [player_direction], PLAYER_FACING_DOWN
		je @@Mid_left_facing_up_down
		cmp [player_direction], PLAYER_FACING_LEFT
		je @@Mid_left_facing_right_left

Up: 	
		cmp [player_direction], PLAYER_FACING_UP
		je @@Up_facing_up_down
		cmp [player_direction], PLAYER_FACING_RIGHT
		je @@Up_facing_right_left
		cmp [player_direction], PLAYER_FACING_DOWN
		je @@Up_facing_up_down
		cmp [player_direction], PLAYER_FACING_LEFT
		je @@Up_facing_right_left
		
@@Mid_no_arrow: jmp No_arrow
		
Down:   
		cmp [player_direction], PLAYER_FACING_UP
		je @@Mid_down_facing_up_down
		cmp [player_direction], PLAYER_FACING_RIGHT
		je @@Mid_down_facing_right_left
		cmp [player_direction], PLAYER_FACING_DOWN
		je @@Mid_down_facing_up_down
		cmp [player_direction], PLAYER_FACING_LEFT
		je @@Mid_down_facing_right_left
		
Right:  
		cmp [player_direction], PLAYER_FACING_UP
		je @@Right_facing_up_down
		cmp [player_direction], PLAYER_FACING_RIGHT
		je @@Mid_right_facing_right_left
		cmp [player_direction], PLAYER_FACING_DOWN
		je @@Right_facing_up_down
		cmp [player_direction], PLAYER_FACING_LEFT
		je @@Mid_right_facing_right_left

@@Mid_left_facing_right_left: jmp @@Left_facing_right_left
@@Mid_left_facing_up_down: jmp @@Left_facing_up_down
@@Mid_down_facing_right_left: jmp @@Down_facing_right_left
@@Mid_down_facing_up_down: jmp @@Down_facing_up_down
@@Mid_right_facing_right_left: jmp @@Right_facing_right_left
		
;UpUp:   jmp Cont

;DownUp: jmp Cont

;RightUp:jmp Cont

;LeftUp: jmp Cont

@@Up_facing_up_down:
		call Timer
		push [player_direction]
		push [player_y]
		push [player_x]
		mov [player_direction], PLAYER_FACING_UP
		dec [player_y]
		jmp Cont
@@Up_facing_right_left:
		call Timer
		push [player_direction]
		push [player_y]
		push [player_x]
		cmp [player_direction], PLAYER_FACING_LEFT
		je @@Up_facing_left
		mov [player_direction], PLAYER_FACING_UP
		sub [player_x], 3
		jmp Cont
	@@Up_facing_left:
		mov [player_direction], PLAYER_FACING_UP
		jmp Cont

@@Right_facing_up_down:
		call Timer
		push [player_direction]
		push [player_y]
		push [player_x]
		add [player_x], 3
		cmp [player_direction], PLAYER_FACING_DOWN
		je @@Right_facing_down
		mov [player_direction], PLAYER_FACING_RIGHT
		inc [player_y]
		jmp Cont
	@@Right_facing_down:
		mov [player_direction], PLAYER_FACING_RIGHT
		sub [player_y], 3
		jmp Cont
		
		
@@Right_facing_right_left:
		call Timer
		push [player_direction]
		push [player_y]
		push [player_x]
		mov [player_direction], PLAYER_FACING_RIGHT
		inc [player_x]
		jmp Cont

@@Down_facing_up_down:
		call Timer
		push [player_direction]
		push [player_y]
		push [player_x]
		mov [player_direction], PLAYER_FACING_DOWN
		inc [player_y]
		jmp Cont
@@Down_facing_right_left:
		call Timer
		push [player_direction]
		push [player_y]
		push [player_x]
		add [player_y], 3
		cmp [player_direction], PLAYER_FACING_LEFT
		je @@Down_facing_left
		mov [player_direction], PLAYER_FACING_DOWN
		sub [player_x], 3
		jmp Cont
		
	@@Down_facing_left:
		mov [player_direction], PLAYER_FACING_DOWN
		jmp Cont

@@Left_facing_up_down:
		call Timer
		push [player_direction]
		push [player_y]
		push [player_x]
		cmp [player_direction], PLAYER_FACING_DOWN
		je @@left_facing_down
		mov [player_direction], PLAYER_FACING_LEFT
		inc [player_y]
		jmp Cont
	@@Left_facing_down:
		mov [player_direction], PLAYER_FACING_LEFT
		sub [player_y], 3
		jmp Cont
@@Left_facing_right_left:
		call Timer
		push [player_direction]
		push [player_y]
		push [player_x]
		mov [player_direction], PLAYER_FACING_LEFT
		dec [player_x]
		jmp Cont


Cont:
		;call DeletePlayer
		call CheckPlayerVacancy
		;call PrintPlayer
No_arrow:
		push [pointer_MovePlayer]
        ret
ENDP MovePlayer

;------------------------------------------------------------------------------------
;CheckPlayerVacancy - Checks if the player's future position is vacant or occupied
;------------------------------------------------------------------------------------
;Input:
;		[player_direction] ,([player_x],[player_y]) <- Cordinates of new player position
;Output:
;		Printed player or none
;Registers:
;		
;------------------------------------------------------------------------------------
PROC CheckPlayerVacancy
		pop [pointer_CheckPlayerVacancy]

		cmp [player_direction], PLAYER_FACING_UP
		je Facing_up 
		cmp [player_direction], PLAYER_FACING_RIGHT
		je Facing_right
		cmp [player_direction], PLAYER_FACING_DOWN
		je Facing_down
		jmp Facing_left
		
Facing_up:
		mov [player_max_x], 12
		mov cx, [player_x]
		mov dx, [player_y]
@@Check_up: 
		mov ah, 0Dh
		int 10h
		cmp al, 2
		jne @@Mid_not_vacant
		inc cx
		dec [player_max_x]
		jnz @@Check_up
		jmp Vacant
		
Facing_right:
		mov [player_max_y], 12
		add [player_x], 8
		mov cx, [player_x]
		mov dx, [player_y]
@@Check_right: 
		mov ah, 0Dh
		int 10h
		cmp al, 2
		jne Not_vacant
		inc dx
		dec [player_max_y]
		jnz @@Check_right
		sub [player_x], 8
		jmp Vacant

@@Mid_not_vacant: jmp Not_vacant
		
		
Facing_down:
		mov [player_max_x], 12
		add [player_y], 8 
		mov cx, [player_x]
		mov dx, [player_y]
@@Check_down: 
		mov ah, 0Dh
		int 10h
		cmp al, 2
		jne Not_vacant
		inc cx
		dec [player_max_x]
		jnz @@Check_down
		sub [player_y], 8
		jmp Vacant
		
Facing_left:
		mov [player_max_y], 12
		mov cx, [player_x]
		mov dx, [player_y]
@@Check_left: 
		mov ah, 0Dh
		int 10h
		cmp al, 2
		jne Not_vacant
		inc dx
		dec [player_max_y]
		jnz @@Check_left


Vacant:
		;call DrawDot
		pop [trash]
		pop [trash]
		call PrintPlayer
		jmp @@Cont
		
Not_vacant:
		pop [player_x]
		pop [player_y]
		pop [player_direction]
		
@@Cont:
		push [pointer_CheckPlayerVacancy]
		ret
ENDP CheckPlayerVacancy
;------------------------------------------------------------------------------------
;PrintPlayer - Prints new player position
;------------------------------------------------------------------------------------
;Input:
;		[player_direction], ([player_x],[player_y]) <- Cordinates of player
;Output:
;		Printed new player position
;Registers:
;		
;------------------------------------------------------------------------------------
Proc PrintPlayer
		pop [pointer_PrintPlayer] 
		mov al, 2
		
		cmp [player_direction], PLAYER_FACING_LEFT
		je @@Mid_player_left
		cmp [player_direction], PLAYER_FACING_RIGHT
		je @@Mid_player_right
		cmp [player_direction], PLAYER_FACING_DOWN
		je @@Mid_player_down
		
		
@@Player_up:
		pop [player_old_direction]
		cmp [player_old_direction], PLAYER_FACING_UP
		je @@Up
		cmp [player_old_direction], PLAYER_FACING_DOWN
		je @@Up

		mov cx, [player_x]
		mov dx, [player_y]
		cmp [player_old_direction], PLAYER_FACING_RIGHT
		je @@Up_right1
		sub cx, 3
	@@Up_right1:
		add cx, 5
		add dx, 8
		call DrawDot
		inc cx
		call DrawDot
		inc dx
		call DrawDot
		inc dx
		call DrawDot
		inc cx
		call DrawDot
		dec dx
		call DrawDot
		dec dx
		call DrawDot
		inc cx
		call DrawDot
		cmp [player_old_direction], PLAYER_FACING_RIGHT
		je @@Up_right2
		sub cx, 3
		add dx, 2
		call DrawDot
		jmp @@Up
		
	@@Mid_player_left: jmp @@Player_left
	@@Mid_player_down: jmp @@Player_down
	@@Mid_player_right: jmp @@Player_right
	
	@@Up_right2:
		add dx, 2
		call DrawDot
@@Up:
		mov bl, 12
		mov [player_max_x], bl	;Player X length
		mov [player_max_y], 8	;Player Y length
		mov dx, [player_y]
		mov cx, [player_x]
		mov si, offset player_up
		jmp @@Player_print_pixel
		
@@Player_right:
		pop [player_old_direction]
		cmp [player_old_direction], PLAYER_FACING_RIGHT
		je @@Right
		cmp [player_old_direction], PLAYER_FACING_LEFT
		je @@Right
		cmp [player_old_direction], PLAYER_FACING_UP
		je @@Right_up
		
		mov cx, [player_x]
		mov dx, [player_y]
		sub cx, 2
		add dx, 6
		call DrawDot
		inc cx
		call DrawDot
		inc dx
		call DrawDot
		dec cx
		call DrawDot
		inc dx
		call DrawDot
		jmp @@Right
		
	@@Right_up:
		mov cx, [player_x]
		mov dx, [player_y]
		sub cx, 2
		inc dx
		call DrawDot
		inc dx
		call DrawDot
		inc cx
		call DrawDot
		inc dx
		call DrawDot
		dec cx
		call DrawDot
		
@@Right:
		mov bl, 8
		mov [player_max_x], bl	;Player X length
		mov [player_max_y], 12	;Player Y length
		mov dx, [player_y]
		mov cx, [player_x]
		mov si, offset player_right
		jmp @@Player_print_pixel
		


@@Player_down:
		pop [player_old_direction]
		cmp [player_old_direction], PLAYER_FACING_UP
		je @@Down
		cmp [player_old_direction], PLAYER_FACING_DOWN
		je @@Down
		
		mov cx, [player_x]
		mov dx, [player_y]
		sub dx, 2
		cmp [player_old_direction], PLAYER_FACING_RIGHT
		je @@Down_right1
		sub cx, 3
	@@Down_right1:
		add cx, 6
		call DrawDot
		inc dx
		call DrawDot
		inc cx
		call DrawDot
		dec dx
		call DrawDot
		cmp [player_old_direction], PLAYER_FACING_RIGHT
		je @@Down_right2
		sub cx, 2
		call DrawDot
		jmp @@Down
		
	@@Down_right2:
		inc cx
		call DrawDot
		
@@Down:
		mov bl, 12
		mov [player_max_x], bl	;Player X length
		mov [player_max_y], 8	;Player Y length
		mov dx, [player_y]
		mov cx, [player_x]
		mov si, offset player_down
		jmp @@Player_print_pixel
		
@@Player_left:
		pop [player_old_direction]
		cmp [player_old_direction], PLAYER_FACING_RIGHT
		je @@Left
		cmp [player_old_direction], PLAYER_FACING_LEFT
		je @@Left
		cmp [player_old_direction], PLAYER_FACING_UP
		je @@Left_up
		
		mov cx, [player_x]
		mov dx, [player_y]
		add dx, 5
		add cx, 8
		call DrawDot
		inc dx
		call DrawDot
		inc cx
		call DrawDot
		inc cx
		call DrawDot
		inc dx
		call DrawDot
		dec cx
		call DrawDot
		dec cx
		call DrawDot
		inc dx
		call DrawDot
		add cx, 2
		call DrawDot
		
		
	@@Left_up:
		mov cx, [player_x]
		mov dx, [player_y]
		add cx, 8
		inc dx
		call DrawDot
		add cx, 2
		call DrawDot
		inc dx
		call DrawDot
		inc dx
		call DrawDot
		dec cx
		call DrawDot
		dec dx
		call DrawDot
		dec cx
		call DrawDot
		inc dx
		call DrawDot
		inc dx
		call DrawDot
		
		
@@Left:
		mov bl, 8
		mov [player_max_x], bl	;Player X length
		mov [player_max_y], 12	;Player Y length
		mov dx, [player_y]
		mov cx, [player_x]
		mov si, offset player_left
		
@@Player_print_pixel:
		mov al, [si]
		mov ah, 0Ch
		int 10h
		inc si
		inc cx
		dec [player_max_x]
		jnz @@Player_print_pixel
		mov [player_max_x], bl
		inc dx
		mov cx, [player_x]
		dec [player_max_y]
		jnz @@Player_print_pixel
		
		push [pointer_PrintPlayer]
		ret
ENDP PrintPlayer

;------------------------------------------------------------------------------------
;SpawnPlayer - Spawns the player in a random position
;------------------------------------------------------------------------------------
;Input:
;		none
;Output:
;		Printed player
;Registers:
;		ah, al, bh, bl, cx, dx, si
;------------------------------------------------------------------------------------
PROC SpawnPlayer
Player_spawn: 
		
		mov bh, 0
		call GenerateRandomCordinates
		inc [object_x]
		inc [object_y]
		mov [player_direction], PLAYER_FACING_UP
	
		push [object_x]
		push [object_y]
		pop [player_y]
		pop [player_x]
		dec [player_x]
		dec [player_y]
		mov cx, [player_x]
		mov dx, [player_y]
		
		mov bl, 12	         		;Player X length
		mov [player_max_y], 8		;Player Y length
		mov si, offset player_up
		
		mov [player_max_x], bl
		mov dx, [player_y]
		
Player_print_pixel:
		mov al, [si]
		mov ah, 0Ch
		int 10h
		inc si
		inc cx
		dec [player_max_x]
		jnz Player_print_pixel
		mov [player_max_x], bl
		inc dx
		mov cx, [player_x]
		dec [player_max_y]
		jnz Player_print_pixel
		jmp Player_success
		
Player_occupied:
		jmp Player_spawn
Player_success:
		ret
ENDP SpawnPlayer

;Procedure DrawDot - Draws green pixels in order to clean player movement traces
PROC DrawDot
		mov al, 2
		mov ah, 0Ch
		int 10h
		ret
ENDP DrawDot

;Procedure Timer - Creates delay between player moves in order to slow movement to a reasonable pace
PROC Timer
@@Not_zero:
		dec [counter]
        jnz @@Not_zero
		mov [counter], SPAN
		ret
ENDP Timer

include 'G_Assets\rnd.inc'

	END Start
	