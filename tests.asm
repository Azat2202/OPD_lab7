ORG 0x501
;Program that run sppecified tests.
;Features: it needs only test addresses 
;Programms must handle 0 args and return 0 or 1 in AC
;----------------------------Constants------------------------------- 
TEST_COUNT:	WORD	0x4			;Tests amount
TESTS:	WORD	0x010, 0x50, 0x100, 0x150	;Test addresses
RESULTS:	WORD	4 DUP (?)			;Test results
MAIN_RES:	WORD	?			;Result over all tests
ARRAY_ADDR:	WORD	0x501			;Address of first element
;---------------------------------------------------------------------

test_loop:	WORD	?	;Test loop variable
array_adr:	WORD	?	;Next element in test array
result_adr:	WORD	?	;Next element in result array
test_adr:	WORD	?	;Next test address
START:	LD	TEST_COUNT
	ST	test_loop
	LD	ARRAY_ADDR
	ST	array_adr
	ADD	TEST_COUNT
	ST	result_adr
MAIN:	LD	(array_adr)+
	ST	test_adr
	CALL	test_adr
	ST	(result_adr)+
	LOOP	test_loop
	JUMP	MAIN
	JUMP	CHECK_RES
CHECK_RES:	LD	TEST_COUNT
	ST	test_loop
CHECKING:	LD	-(result_adr)
	ROR
	BCC	TEST_FAIL
	LOOP	test_loop
	JUMP	CHECKING
	JUMP	TEST_OK
TEST_OK:	LD	#0x1
	ST	MAIN_RES
	HLT
TEST_FAIL:	LD	#0x0
	ST	MAIN_RES
	HLT
	
	
	
	
	
;TEST 2
	ORG	0x10
	LD	#0x1
	RET

;TEST 3
	ORG	0x50
	LD	#0x1
	RET

;TEST 4
	ORG	0x100
	LD	#0x1
	RET

;TEST 5
	ORG	0x150
	LD	#0x1
	RET


	






