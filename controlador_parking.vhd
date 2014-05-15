-- *** Descripción ***

-- Componente que detecte la secuencia 00, se usará para el sensor de entrada y salida. Detecta esta secuencia para evitar que alguien se cruce en el laser o algo puntual.
-- Si un coche ha entrado, mediante el componente sumador, se sumará una unidad al total de coches, se restará en caso de que se detecte un coche en el sensor de salida.
-- Si ha entrado, se procederá a mostrar por pantalla una plaza libre, buscada en la matriz o cola de plazas libres, que se definen con los sensores en cada plaza.

-- *** Código ***

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


ENTITY controlador_parking IS
	PORT (
		clk: IN BIT;
		sensor_entrada: IN BIT;
		sensor_salida: IN BIT;

		estado_parking: OUT BIT
		);
END controlador_parking;


ARCHITECTURE controlador_arch OF controlador_parking IS

-- ********* Declaración de componentes a usar *********

COMPONENT suma_resta 
	PORT ( 
		A: IN BIT_VECTOR (7 DOWNTO 0); 
		Sel: IN BIT; 
		Salida: OUT BIT_VECTOR (7 DOWNTO 0)
		); 
end COMPONENT; 


COMPONENT selector IS
	PORT(a,b,c,d: IN BIT_VECTOR(6 DOWNTO 0);
		planta: OUT BIT_VECTOR(1 DOWNTO 0);
		columna, fila: OUT BIT_VECTOR(2 DOWNTO 0)
		);
END COMPONENT;


COMPONENT Deco_Parking IS
	PORT(entradas_planta:IN BIT_VECTOR(1 DOWNTO 0);entradas_plaza1:IN BIT_VECTOR(2 DOWNTO 0);entrada_plaza2: IN BIT_VECTOR(2 DOWNTO 0); 
	  salidas_planta:OUT BIT_VECTOR(6 DOWNTO 0); salidas_plaza1:OUT BIT_VECTOR(6 DOWNTO 0);
	  salidas_plaza2:OUT BIT_VECTOR(6 DOWNTO 0);selector1:OUT BIT_VECTOR(2 DOWNTO 0);
	  selector:OUT BIT_VECTOR(2 DOWNTO 0);selector2:OUT BIT_VECTOR(2 DOWNTO 0)
		);
End COMPONENT;


COMPONENT buscador IS 
	PORT(e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e18,e19,e20,e21,e22,e23,e24,e25,e26,e27,e28,e29,e230,e31,e32,e33,e34,e35,e36,e37,e38,e39,e40,e41,e42,e43,e44,e45,e46,e47,e48,e49,e50,e51,e52,e53,e54,e55,e56,e57,e58,e59,e60,e61,e62,e63:in bit;
		s:OUT BIT_VECTOR(6 DOWNTO 0)
		);
END COMPONENT;


COMPONENT detector_secuencia is 
	PORT (clk,x: IN BIT; 
		z: OUT BIT
		);
end COMPONENT;              

-- ********* Declaración de señales *********
 
SIGNAL	detector_salida_OUT, detector_entrada_OUT: BIT;
SIGNAL	count: BIT_VECTOR (7 DOWNTO 0);

-- ******************

BEGIN

PROCESS(clk, sensor_entrada, sensor_salida)
	BEGIN
		-- mandar las entradas sensor_entrada y sensor_salida a su detector de secuencia correspondiente junto con el reloj, este devolverá un uno cuando se detecte la secuencia 00, 
		-- que será cuando un coche ha interrumpido el laser que compone el sensor.
		SENSOREN: detector_secuencia PORT MAP(clk, sensor_entrada, detector_entrada_OUT);
		SENSORSAL: detector_secuencia PORT MAP(clk, sensor_salida, detector_salida_OUT);

		IF detector_salida_OUT = '1' AND detector_salida_OUT'EVENT THEN
			-- usar sumador/restador para restar, pasarle que tiene que restar y la cuenta total. Devolverá el valor de la nueva cuenta total -1.
			--RES: suma_resta PORT MAP(count, '1', count);
			count <= (count - 1);

		END IF;

		IF detector_entrada_OUT = '1' AND detector_entrada_OUT'EVENT THEN
			-- usar sumador/restador para sumar, pasarle que tiene que sumar y la cuenta total. Devolverá el valor de la nueva cuenta total +1
			--SUM: suma_resta PORT MAP (count, '0', count);
			count <= (count + 1);

			-- TODO: buscar una plaza libre para posteriormente mostrarla:
				-- 1. Mandar los sensores de cada plaza a un buscador que devolverá un vector con el formato: [plaza encontrada][planta][columna][fila]. Se mandarán a cuatro buscadores, uno por planta.
				-- 2. Cuando se tenga la plaza libre por planta y si hay o no disponible, se mandará a buscar, para que nos quede sólo una plaza que será la escogida, a un selector de planta.
			-- TODO: la plaza libre asignada se pasará al decodificador para posteriormente mostrarla en la pantalla según corresponda y poder visualizarla mediante digitos.

		END IF;

		-- Actualizar identificador de parking lleno o vacío.
		IF count = "11111111" THEN
			estado_parking <='1'; -- Parking lleno, luz roja.
			ELSE estado_parking <= '0';
		END IF;

END PROCESS;

END controlador_arch;