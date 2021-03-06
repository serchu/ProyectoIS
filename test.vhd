Entity controltest IS
END controltest;

ARCHITECTURE prueba OF controltest IS
COMPONENT controla_parking 
	PORT (	
		clk: IN BIT;
		sensor_entrada: IN BIT;
		sensor_salida: IN BIT;
		sensores: IN BIT_VECTOR (255 DOWNTO 0);
		estado_parking: OUT BIT;
		display_planta: OUT BIT_VECTOR(6 DOWNTO 0);
		display_columna: OUT BIT_VECTOR(6 DOWNTO 0);
		display_fila: OUT BIT_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;
FOR i: controla_parking USE ENTITY WORK.controlador_parking(controlador_arch);
SIGNAL clk, sensor_entrada,sensor_salida,estado_parking:BIT;
SIGNAL sensores: BIT_VECTOR(255 DOWNTO 0);
SIGNAL display_planta,display_columna,display_fila:BIT_VECTOR(6 DOWNTO 0);

BEGIN
	i: controla_parking PORT MAP (clk,sensor_entrada,sensor_salida,sensores,estado_parking,display_planta,display_columna,display_fila);
	clk <= NOTclk AFTER 100ns WHEN now<3000ns ELSE clk;
	sensor_entrada <= '1'AFTER 300ns, '0' AFTER 350ns,'1'AFTER 650ns, '0' AFTER 1030 ns,'1'AFTER 1450ns, '0' AFTER 1600 ns,'1'AFTER 2000ns, '0' AFTER 2050 ns,'1'AFTER 2350ns, '0' AFTER 2430 ns,'1'AFTER 2800ns, '0' AFTER 2830 ns,'1'AFTER 3000ns;
	sensor_salida <= '1'AFTER 200ns, '0' AFTER 500ns,'1'AFTER 550ns, '0' AFTER 1030 ns,'1'AFTER 1330ns, '0' AFTER 1650 ns,'1'AFTER 1950ns, '0' AFTER 2050 ns,'1'AFTER 2350ns, '0' AFTER 2430 ns,'1'AFTER 2900ns, '0' AFTER 3000 ns;
	sensores: "00110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011001100110011"AFTER 0NS, "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110110011101100111011001110110011101100111011001110110011101100111011001110110011101100111011001110110011101100111011001110110011" AFTER 1500ns;
END prueba;