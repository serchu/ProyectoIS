--Decodificador Planta y Plaza
ENTITY Deco_Parking IS
 PORT(entradas_planta:IN BIT_VECTOR(1 DOWNTO 0);entradas_plaza1:IN BIT_VECTOR(2 DOWNTO 0);entradas_plaza2: IN BIT_VECTOR(2 DOWNTO 0); 
 salidas_planta:OUT BIT_VECTOR(6 DOWNTO 0); salidas_plaza1:OUT BIT_VECTOR(6 DOWNTO 0);
 salidas_plaza2:OUT BIT_VECTOR(6 DOWNTO 0);selector:OUT BIT_VECTOR(2 DOWNTO 0);
 selector1:OUT BIT_VECTOR(2 DOWNTO 0);selector2:OUT BIT_VECTOR(2 DOWNTO 0));

--PORT(entradas_planta:IN STD_LOGIC_VECTOR(1 DOWNTO 0);entradas_plaza1:IN STD_LOGIC_VECTOR(2 DOWNTO 0);entradas_plaza2: IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
 -- salidas_planta:OUT STD_LOGIC_VECTOR(6 DOWNTO 0); salidas_plaza1:OUT std_logic_vector(6 DOWNTO 0);
 -- salidas_plaza2:OUT std_logic_vector(6 DOWNTO 0);selector1:OUT std_logic_vector(2 DOWNTO 0);
 -- selector:OUT std_logic_vector(2 DOWNTO 0);selector2:OUT std_logic_vector(2 DOWNTO 0));
  
End Deco_Parking;

ARCHITECTURE dec_parking_funcion OF Deco_Parking IS

  function planta(ent_plant:BIT_VECTOR(1 downto 0))
  return BIT_VECTOR is
    variable salida: BIT_VECTOR(6 downto 0);
    BEGIN

      CASE ent_plant is
      WHEN "00"=>salida:="0000001";
      WHEN "01"=>salida:="1001111";
      WHEN "10"=>salida:="0010010";
      WHEN "11"=>salida:="0000110";
    --WHEN OTHERS =>salidas_planta<="111111"
      END CASE;
    return salida;
  
    END planta;
    
  function plaza1(ent_plaza1:BIT_VECTOR(2 downto 0))
  return BIT_VECTOR is
    variable salida1: BIT_VECTOR(6 downto 0);
    BEGIN
      CASE ent_plaza1 is
      WHEN "000"=>salida1:="0000001";
      WHEN "001"=>salida1:="1001111";
      WHEN "010"=>salida1:="0010010";
      WHEN "011"=>salida1:="0000110";
      WHEN "100"=>salida1:="1000001";
      WHEN "101"=>salida1:="0100100";
      WHEN "110"=>salida1:="0100000";
      WHEN "111"=>salida1:="0001111";
      --WHEN "1000"=>salidas_plaza1<="0000000"
      --WHEN "1001"=>salidas_plaza1<="0000100"
      --WHEN OTHERS =>salidas_plaza1<="111111"
      END CASE;
    return salida1;
    END plaza1;
    
  function plaza2(ent_plaza2:BIT_VECTOR(2 downto 0))
  return BIT_VECTOR is
    variable salida2: BIT_VECTOR(6 downto 0);
    BEGIN
      CASE ent_plaza2 is
      WHEN "000"=>salida2:="0000001";
      WHEN "001"=>salida2:="1001111";
      WHEN "010"=>salida2:="0010010";
      WHEN "011"=>salida2:="0000110";
      WHEN "100"=>salida2:="1000001";
      WHEN "101"=>salida2:="0100100";
      WHEN "110"=>salida2:="0100000";
      WHEN "111"=>salida2:="0001111";
      --WHEN "1000"=>salidas_plaza2<="0000000"
      --WHEN "1001"=>salidas_plaza2<="0000100"
      --WHEN OTHERS =>salidas_plaza2<="111111"
      END CASE;
    return salida2;
 END plaza2;
    
BEGIN
--
--Salida del selector ayuda a seleccionar que display se va  a seleccionar , serian con ceros
--cada selector se asignara con un cero a cada pin correspondiente
salidas_planta<= planta(entradas_planta);
  --Display del anodo 0
  selector<="110";
salidas_plaza1<=plaza1(entradas_plaza1);
  ----Display del anodo 1
  selector1<="101";
salidas_plaza2<=plaza2(entradas_plaza2);
  --Display del anodo 2
  selector2<="011";
END dec_parking_funcion;


