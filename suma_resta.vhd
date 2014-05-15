library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

ENTITY suma_resta IS PORT ( 
	A : IN BIT_VECTOR (7 DOWNTO 0); 
	Sel : IN BIT; 
	Salida : OUT BIT_VECTOR (7 DOWNTO 0) ); 
END suma_resta; 

ARCHITECTURE comportamiento OF suma_resta IS 
BEGIN 
	IF (sel = '1')
		Salida <= ( A - 1 ) ;
	ELSE Salida <= ( A + 1 );
	ENF IF;
END comportamiento;