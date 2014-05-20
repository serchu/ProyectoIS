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
		sensores: IN BIT_VECTOR (255 DOWNTO 0);

		estado_parking: OUT BIT;
		display_planta: OUT BIT_VECTOR(6 DOWNTO 0);
		display_columna: OUT BIT_VECTOR(6 DOWNTO 0);
		display_fila: OUT BIT_VECTOR(6 DOWNTO 0)
		);
END controlador_parking;

-- ************ DECLARACION ARQUITECTURA ************

ARCHITECTURE controlador_arch OF controlador_parking IS


-- ********* Declaración de componentes a usar *********

COMPONENT Deco_Parking IS
	PORT(
		entradas_planta:IN BIT_VECTOR(1 DOWNTO 0);entradas_plaza1:IN BIT_VECTOR(2 DOWNTO 0);entrada_plaza2: IN BIT_VECTOR(2 DOWNTO 0); 
		salidas_planta:OUT BIT_VECTOR(6 DOWNTO 0); salidas_plaza1:OUT BIT_VECTOR(6 DOWNTO 0);
		salidas_plaza2:OUT BIT_VECTOR(6 DOWNTO 0)
		);
End COMPONENT;


COMPONENT detector_secuencia is 
	PORT (clk,x: IN BIT; 
		z: OUT BIT
		);
end COMPONENT;              

-- ********* Declaración de señales *********
 
SIGNAL detector_salida_OUT, detector_entrada_OUT: BIT;
SIGNAL count:INTEGER;
SIGNAL lo_que_devuelve_el_buscador: BIT_VECTOR (8 DOWNTO 0);
SIGNAL to_mostrar_planta: BIT_VECTOR (1 DOWNTO 0);
SIGNAL to_mostrar_columna: bit_vector(2 DOWNTO 0);
SIGNAL to_mostrar_fila: bit_vector(2 DOWNTO 0);

-- ******************
function buscador(sensores: BIT_VECTOR(255 DOWNTO 0))
return BIT_VECTOR IS
	variable salida: BIT_VECTOR(8 DOWNTO 0);
	variable i:BIT;
	variable contador: INTEGER;
	begin
		i:='1';
		contador:=0;
		while i = '1' loop
		        i := sensores(contador);
			    contador := contador + 1;
				if i=0
					salida:=contador;
				elsif contador=256
					salida:=contador;
				end if;
	     end loop;
	return salida;
END buscador;

BEGIN

PROCESS(clk, sensor_entrada, sensor_salida)
	BEGIN
		-- mandar las entradas sensor_entrada y sensor_salida a su detector de secuencia correspondiente junto con el reloj, este devolverá un uno cuando se detecte la secuencia 00, 
		-- que sera cuando un coche ha interrumpido el laser que compone el sensor.
		SENSOREN: detector_secuencia PORT MAP(clk, sensor_entrada, detector_entrada_OUT);
		SENSORSAL: detector_secuencia PORT MAP(clk, sensor_salida, detector_salida_OUT);

		IF detector_salida_OUT = '1' AND detector_salida_OUT'EVENT THEN
			-- usar sumador/restador para restar, pasarle que tiene que restar y la cuenta total. Devolverá el valor de la nueva cuenta total -1.
			--RES: suma_resta PORT MAP(count, '1', count);
			count <= count-1;

		END IF;

		IF detector_entrada_OUT = '1' AND detector_entrada_OUT'EVENT THEN
			-- usar sumador/restador para sumar, pasarle que tiene que sumar y la cuenta total. Devolverá el valor de la nueva cuenta total +1
			--SUM: suma_resta PORT MAP (count, '0', count);
			count <= count+1;

			lo_que_devuelve_el_buscador<=buscador(sensores);

			to_mostrar_fila(0)<=lo_que_devuelve_el_buscador(0);
			to_mostrar_fila(1)<=lo_que_devuelve_el_buscador(1);
			to_mostrar_fila(2)<=lo_que_devuelve_el_buscador(2);
			to_mostrar_columna(0)<=lo_que_devuelve_el_buscador(3);
			to_mostrar_columna(1)<=lo_que_devuelve_el_buscador(4);
			to_mostrar_columna(2)<=lo_que_devuelve_el_buscador(5);
			to_mostrar_planta(0)<=lo_que_devuelve_el_buscador(6);
			to_mostrar_planta(1)<=lo_que_devuelve_el_buscador(7);

			-- TO-DO: buscar una plaza libre para posteriormente mostrarla:
				-- 1. Mandar los sensores de cada plaza a un buscador que devolverá un vector con el formato: [plaza encontrada][planta][columna][fila]. Se mandarán a cuatro buscadores, uno por planta.
				-- 2. Cuando se tenga la plaza libre por planta y si hay o no disponible, se mandará a buscar, para que nos quede sólo una plaza que será la escogida, a un selector de planta.
			-- TO-DO: la plaza libre asignada se pasará al decodificador para posteriormente mostrarla en la pantalla según corresponda y poder visualizarla mediante digitos.
		END IF;

		DECOD: Decod_Planta PORT MAP(estado_parking, to_mostrar_planta, to_mostrar_columna, to_mostrar_fila, display_planta, display_columna, display_fila);
		-- Actualizar identificador de parking lleno o vacío.
		IF count = 255 THEN
			estado_parking <='1'; -- Parking lleno, luz roja.
			ELSE estado_parking <= '0';
		END IF;

END PROCESS;

END controlador_arch;