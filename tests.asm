ORG 0x500
;Program that run sppecified tests.
;Features: it needs only test addresses 
;Programms must handle 0 args and return 0 or 1 in AC
;Constants: 
TEST_COUNT:	WORD	0x4							;Tests amount
TESTS:		WORD	0x010, 0x50, 0x100, 0x150	;Test addresses
RESULTS:	WORD	4 DUP (?)					;Test results
MAIN_RES:	WORD	?							;Result over all tests

first_test:	WORD	0x501			;First test address 
next_test:	WORD	?				;Next test for call
next_test_b:WORD	?				;Buffer for CALL (next_test)+
next_res:	WORD 	?				;Next result address
loop_buf:	WORD	?				;Loop cell
arr_addr:	WORD	?				;Array of test addresses pointer
START:		LD		TEST_COUNT		;Save from constant test count to loop cell
			ST		loop_buf		
			LD		first_test		;Save from constant first test cell to next_test cell
			ST		next_test	
			ADD		TEST_COUNT 		;Count results cells
			ST		next_res	
make_test:	LD		(next_test)+	;This code immitates CALL (next_test)+
			ST		next_test_b
			CALL	next_test_b
			ST		(next_res)+		;Save result 
			LOOP 	loop_buf
			JUMP 	make_test
			LD		TEST_COUNT
			ST		loop_buf
check_res:	LD		-(next_res)		;Check test
			ROR
			BCC		test_fail		;If test failed go to test failed
			LOOP	loop_buf
			JUMP	check_res
test_ok:	LD		#0x1
			ST		MAIN_RES
			HLT
test_fail:	LD		#0x1
			ST		MAIN_RES
			HLT
			
			
;TEST 2
			ORG		0x10
			LD		#0x1
			RET

;TEST 3
			ORG		0x50
			LD		#0x1
			RET

;TEST 4
			ORG		0x100
			LD		#0x1
			RET

;TEST 5
			ORG		0x150
			LD		#0x1
			RET


			






