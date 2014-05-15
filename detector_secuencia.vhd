ENTITY detector_secuencia IS 
PORT (clk,x: IN bit; z: OUT bit);
END detector_secuencia;              

ARCHITECTURE arqDetector OF detector_secuencia IS
     TYPE estado IS (a,b,c);
     SIGNAL presente:estado;
BEGIN
        PROCESS(clk)
        BEGIN
            IF clk'EVENT AND clk = '1' THEN
                CASE presente IS
                   WHEN a => IF x = '0' THEN
                             z <= '0';
                             presente <= b;
                        ELSE
                             presente <= a;
                             z <= '0';
                        END IF;

                   WHEN b => IF x = '0' THEN
                             presente <= c;
                             z <= '0';
                        ELSE
                             z <= '0';
                             presente <= a;
                        END IF;

                   WHEN c => IF x = '0' THEN
                             presente <= c;
                             z <= '1';
                        ELSE
                             presente <= a;
                             z <= '0';
                        END IF;
                END CASE;
            END IF;
        END PROCESS;
END arqDetector;