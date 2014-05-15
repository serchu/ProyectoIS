ENTITY selector IS
PORT(a,b,c,d: IN bit_vector(6 DOWNTO 0);
	planta: OUT bit_vector(1 DOWNTO 0);
	columna, fila: OUT bit_vector(2 DOWNTO 0));
END selector;

ARCHITECTURE ps OF selector IS
BEGIN
	if a(6)='0' then	planta<="00";
				columna(2)<=a(5);
				columna(1)<=a(4);
				columna(0)<=a(3);
				fila(2)<=a(2);
				fila(1)<=a(1);
				fila(0)<=a(0);
	elsif b(6)='0' then	planta<="01";
				columna(2)<=b(5);
				columna(1)<=b(4);
				columna(0)<=b(3);
				fila(2)<=b(2);
				fila(1)<=b(1);
				fila(0)<=b(0);
	elsif c(6)='0' then	planta<="10";
				columna(2)<=c(5);
				columna(1)<=c(4);
				columna(0)<=c(3);
				fila(2)<=c(2);
				fila(1)<=c(1);
				fila(0)<=c(0);
	elsif d(6)='0' then	planta<="11";
				columna(2)<=d(5);
				columna(1)<=d(4);
				columna(0)<=d(3);
				fila(2)<=d(2);
				fila(1)<=d(1);
				fila(0)<=d(0);
		END IF;
END ps;