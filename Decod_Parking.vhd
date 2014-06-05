--Decodificador Planta y Plaza
ENTITY Deco_Parking IS
   PORT(
   lleno:IN BIT; entradas_planta:IN BIT_VECTOR(1 DOWNTO 0);ent_columna:IN BIT_VECTOR(2 DOWNTO 0);ent_fila: IN BIT_VECTOR(2 DOWNTO 0); 
   salidas_planta:OUT BIT_VECTOR(6 DOWNTO 0); salidas_plaza1:OUT BIT_VECTOR(6 DOWNTO 0);
   salidas_plaza2:OUT BIT_VECTOR(6 DOWNTO 0)
   );
End Deco_Parking;


ARCHITECTURE dec_parking_funcion OF Deco_Parking IS

  function planta(lleno: IN BIT; ent_plant:BIT_VECTOR(1 downto 0))
  return BIT_VECTOR is
    variable salida: BIT_VECTOR(6 downto 0);
    BEGIN
      if lleno ='1' then
        salida:="1111110";
      else
        CASE ent_plant is
        WHEN "00"=>salida:="0000001";
        WHEN "01"=>salida:="1001111";
        WHEN "10"=>salida:="0010010";
        WHEN "11"=>salida:="0000110";
      --WHEN OTHERS =>salidas_planta<="111111"
        END CASE;
      END IF;
    return salida;
  
    END planta;
    
  function columna(lleno: IN BIT;ent_columna:BIT_VECTOR(2 downto 0))
  return BIT_VECTOR is
    variable salida1: BIT_VECTOR(6 downto 0);
    BEGIN
      if lleno ='1' then
        salida1:="1111110";
      else
        CASE ent_columna is
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
    END IF;
    return salida1;
    END columna;
    
  function fila(lleno: IN BIT; ent_fila:BIT_VECTOR(2 downto 0))
  return BIT_VECTOR is
    variable salida2: BIT_VECTOR(6 downto 0);
    BEGIN
      if lleno ='1' then
        salida2:="1111110";
      else
        
        CASE ent_fila is
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
      end if ;
    return salida2;
 END fila;
    
BEGIN

salidas_planta<=planta(lleno,entradas_planta);

salidas_plaza1<=columna(lleno,ent_columna);

salidas_plaza2<=fila(lleno,ent_fila);

END dec_parking_funcion;