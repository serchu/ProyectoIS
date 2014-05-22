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
		sensores_planta1: IN BIT_VECTOR (63 DOWNTO 0);
		sensores_planta2: IN BIT_VECTOR (63 DOWNTO 0);
		sensores_planta3: IN BIT_VECTOR (63 DOWNTO 0);
		sensores_planta4: IN BIT_VECTOR (63 DOWNTO 0);


		luz_estado: OUT BIT;
		display_planta: OUT BIT_VECTOR(6 DOWNTO 0);
		display_columna: OUT BIT_VECTOR(6 DOWNTO 0);
		display_fila: OUT BIT_VECTOR(6 DOWNTO 0)
		);
END controlador_parking;

-- ************ DECLARACION ARQUITECTURA ************

ARCHITECTURE controlador_arch OF controlador_parking IS


-- ********* Declaración de componentes a usar *********

COMPONENT decodificador IS
	PORT(
   lleno:IN BIT; entradas_planta:IN BIT_VECTOR(1 DOWNTO 0);ent_columna:IN BIT_VECTOR(2 DOWNTO 0);ent_fila: IN BIT_VECTOR(2 DOWNTO 0); 
   salidas_planta:OUT BIT_VECTOR(6 DOWNTO 0); salidas_plaza1:OUT BIT_VECTOR(6 DOWNTO 0);
   salidas_plaza2:OUT BIT_VECTOR(6 DOWNTO 0)
   );
End COMPONENT;


COMPONENT sensor is 
	PORT (clk,x: IN BIT; 
		z: OUT BIT
		);
end COMPONENT;              

FOR ALL: decodificador USE ENTITY WORK.Deco_Parking(dec_parking_funcion);
FOR ALL: sensor USE ENTITY WORK.detector_secuencia(arqDetector);

-- ********* Declaración de señales *********
 
SIGNAL detector_salida_OUT: BIT;
SIGNAL detector_entrada_OUT: BIT;
SIGNAL count:INTEGER;
SIGNAL plaza_libre: BIT_VECTOR (8 DOWNTO 0);
SIGNAL to_mostrar_planta: BIT_VECTOR (1 DOWNTO 0);
SIGNAL to_mostrar_columna: BIT_VECTOR(2 DOWNTO 0);
SIGNAL to_mostrar_fila: BIT_VECTOR(2 DOWNTO 0);
SIGNAL estado_parking: BIT;
signal a: std_logic_vector(8 DOWNTO 0);
SIGNAL v: INTEGER;

-- ********* Declaración de funciones *********

function buscador(sensores: BIT_VECTOR(63 DOWNTO 0))
		return INTEGER IS
		variable i:BIT;
		variable contador: INTEGER;
	begin
		i:='1';
		contador:=0;
		while i = '1' or contador = 64 loop
			i := sensores(contador);
			contador := contador + 1;
		end loop;
	return contador;
END buscador;


-- ********** COMIENZO DE PROGRAMA **********
BEGIN
		A1: sensor PORT MAP(clk, sensor_entrada, detector_entrada_OUT);
		A2: sensor PORT MAP(clk, sensor_salida, detector_salida_OUT);
		D1: decodificador PORT MAP(estado_parking, to_mostrar_planta, to_mostrar_columna, to_mostrar_fila, display_planta, display_columna, display_fila);
PROCESS(clk, sensor_entrada, sensor_salida)
	BEGIN
		-- mandar las entradas sensor_entrada y sensor_salida a su detector de secuencia correspondiente junto con el reloj, este devolverá un uno cuando se detecte la secuencia 00, 
		-- que sera cuando un coche ha interrumpido el laser que compone el sensor.
		IF count = 255 THEN
			estado_parking <='1'; -- Parking lleno, luz roja.
			ELSE estado_parking <= '0';
		END IF;


		IF detector_salida_OUT = '1' AND detector_salida_OUT'EVENT THEN
			-- usar sumador/restador para restar, pasarle que tiene que restar y la cuenta total. Devolverá el valor de la nueva cuenta total -1.
			--RES: suma_resta PORT MAP(count, '1', count);
			count <= count-1;

		END IF;

		IF detector_entrada_OUT = '1' AND detector_entrada_OUT'EVENT THEN
			-- usar sumador/restador para sumar, pasarle que tiene que sumar y la cuenta total. Devolverá el valor de la nueva cuenta total +1
			--SUM: suma_resta PORT MAP (count, '0', count);
			count <= count+1;

			v<=buscador(sensores_planta1); -- En entero que devuelve el buscador
			a <= conv_std_logic_vector(v,9); -- Para pasarlo a vector logico
			plaza_libre <= to_bitvector(a);  -- Para pasar el vector logico a vector de bits
			if plaza_libre(8)='1' then
				v<=buscador(sensores_planta2); -- En entero que devuelve el buscador
				a <= conv_std_logic_vector(v,9); -- Para pasarlo a vector logico
				plaza_libre <= to_bitvector(a);  -- Para pasar el vector logico a vector de bits

				if plaza_libre(8)='1' then
					v<=buscador(sensores_planta3); -- En entero que devuelve el buscador
					a <= conv_std_logic_vector(v,9); -- Para pasarlo a vector logico
					plaza_libre <= to_bitvector(a);  -- Para pasar el vector logico a vector de bits
					
					if plaza_libre(8)='1' then
						v<=buscador(sensores_planta4); -- En entero que devuelve el buscador
						a <= conv_std_logic_vector(v,9); -- Para pasarlo a vector logico
						plaza_libre <= to_bitvector(a);  -- Para pasar el vector logico a vector de bits
					end if;						
				end if ;
			end if;

			to_mostrar_fila(0)<=plaza_libre(0);
			to_mostrar_fila(1)<=plaza_libre(1);
			to_mostrar_fila(2)<=plaza_libre(2);
			to_mostrar_columna(0)<=plaza_libre(3);
			to_mostrar_columna(1)<=plaza_libre(4);
			to_mostrar_columna(2)<=plaza_libre(5);
			to_mostrar_planta(0)<=plaza_libre(6);
			to_mostrar_planta(1)<=plaza_libre(7);

			-- TO-DO: buscar una plaza libre para posteriormente mostrarla:
				-- 1. Mandar los sensores de cada plaza a un buscador que devolverá un vector con el formato: [plaza encontrada][planta][columna][fila]. Se mandarán a cuatro buscadores, uno por planta.
				-- 2. Cuando se tenga la plaza libre por planta y si hay o no disponible, se mandará a buscar, para que nos quede sólo una plaza que será la escogida, a un selector de planta.
			-- TO-DO: la plaza libre asignada se pasará al decodificador para posteriormente mostrarla en la pantalla según corresponda y poder visualizarla mediante digitos.
			IF estado_parking = '1' THEN
				 luz_estado <='1'; -- Parking lleno, luz roja.
			ELSE luz_estado <= '0';
				END IF;
		END IF;

		-- Actualizar identificador de parking lleno o vacío.

END PROCESS;

END controlador_arch;