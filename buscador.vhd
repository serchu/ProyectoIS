LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.sted_logic_arith.all;

ENTITY buscador IS 
	port(e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e18,e19,e20,e21,e22,e23,e24,e25,e26,e27,e28,e29,e230,e31,e32,e33,e34,e35,e36,e37,e38,e39,e40,e41,e42,e43,e44,e45,e46,e47,e48,e49,e50,e51,e52,e53,e54,e55,e56,e57,e58,e59,e60,e61,e62,e63:in std_logic;s:out std_logic_vector(6 downto 0));

END buscador;

architecture pro_en of pri_enc is
	PROCESS (e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e18,e19,e20,e21,e22,e23,e24,e25,e26,e27,e28,e29,e30,e31,e32,e33,e34,e35,e36,e37,e38,e39,e40,e41,e42,e43,e44,e45,e46,e47,e48,e49,e50,e51,e52,e53,e54,e55,e56,e57,e58,e59,e60,e61,e62, e63) 
	begin 
			    if e0='0'then s<="0000000";
				elsif	e1='0'then s<="0000001";
				elsif	e2='0'then s<="0000010";
				elsif	e3='0'then s<="0000011";
				elsif	e4='0'then s<="0000100";
				elsif	e5='0'then s<="0000101";
				elsif	e6='0'then s<="0000110";
				elsif	e7='0'then s<="0000111";

				elsif	e8 ='0'then s<="0001000";
				elsif	e9 ='0'then s<="0001001";
				elsif	e10='0'then s<="0001010";
				elsif	e11='0'then s<="0001011";
				elsif	e12='0'then s<="0001100";
				elsif	e13='0'then s<="0001101";
				elsif	e14='0'then s<="0001110";
				elsif	e15='0'then s<="0001111";

				elsif	e16='0'then s<="0010000";
				elsif	e17='0'then s<="0010001";
				elsif	e18='0'then s<="0010010";
				elsif	e19='0'then s<="0010011";
				elsif	e20='0'then s<="0010100";
				elsif	e21='0'then s<="0010101";
				elsif	e22='0'then s<="0010110";
				elsif	e23='0'then s<="0010111";

				elsif	e24='0'then s<="0010000";
				elsif	e25='0'then s<="0010001";
				elsif	e26='0'then s<="0010000";
				elsif	e27='0'then s<="0010001";
				elsif	e28='0'then s<="0011000";
				elsif	e29='0'then s<="0011001";
				elsif	e30='0'then s<="0011000";
				elsif	e31='0'then s<="0011001";
				
				elsif	e32='0'then s<="0100000";
				elsif	e33='0'then s<="0100001";
				elsif	e34='0'then s<="0100010";
				elsif	e35='0'then s<="0100011";
				elsif	e36='0'then s<="0100100";
				elsif	e37='0'then s<="0100101";
				elsif	e38='0'then s<="0100110";
				elsif	e39='0'then s<="0100111";

				elsif	e40='0'then s<="0101000";
				elsif	e41='0'then s<="0101001";
				elsif	e42='0'then s<="0101010";
				elsif	e43='0'then s<="0101011";
				elsif	e44='0'then s<="0101100";
				elsif	e45='0'then s<="0101101";
				elsif	e46='0'then s<="0101110";
				elsif	e47='0'then s<="0101111";
			
				elsif	e48='0'then s<="0110000";
				elsif	e49='0'then s<="0110001";
				elsif	e50='0'then s<="0110010";
				elsif	e51='0'then s<="0110011";
				elsif	e52='0'then s<="0110100";
				elsif	e53='0'then s<="0110101";
				elsif	e54='0'then s<="0110110";
				elsif	e55='0'then s<="0110111";
		
				elsif	e56='0'then s<="0111000";
				elsif	e57='0'then s<="0111001";
				elsif	e58='0'then s<="0111010";
				elsif	e59='0'then s<="0111011";
				elsif	e60='0'then s<="0111100";
				elsif	e61='0'then s<="0111101";
				elsif	e62='0'then s<="0111110";
				elsif	e63='0'then s<="0111111";
				else	s<="1000000";
					end if;
end PROCESS;
end pr_en