library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controlgeneralversion3_4 is
    port (
        reset      : in  std_logic;   --activo bajo
        clock : in  std_logic;
        vecino_arriba, vecino_abajo, vecino_der, vecino_izq : out std_logic_vector(3 downto 0);
		  vector_entrada : in std_logic_vector(3 downto 0);
		  p0, p1, p2, p3: in std_logic
    );
end entity;

architecture behavioral of controlgeneralversion3_4 is
	 type array16x8 is array (0 to 15) of std_logic_vector(7 downto 0);
    signal distancias_dato : array16x8;
	 signal posi : integer range 0 to 15;
	
	 
	function min_vecinos(seleccion: integer; distances: array16x8) return unsigned is
		   type array4x4 is array (0 to 3) of std_logic_vector(3 downto 0);
         variable vecinos : array4x4;  -- tienen 4 vecinos cada uno
		   variable vec_min :std_logic_vector(3 downto 0);
			begin
				 case seleccion is
					  when 0  => vecinos := (distances(1)(7 downto 4), distances(4)(7 downto 4), "1111", "1111");
					  when 1  => vecinos := (distances(2)(7 downto 4), distances(5)(7 downto 4), distances(0)(7 downto 4), "1111");
					  when 2  => vecinos := (distances(3)(7 downto 4), distances(6)(7 downto 4), distances(1)(7 downto 4), "1111");
					  when 3  => vecinos := ("1111", distances(7)(7 downto 4), distances(2)(7 downto 4), "1111");
					  when 4  => vecinos := (distances(5)(7 downto 4), distances(8)(7 downto 4), "1111", distances(0)(7 downto 4));
					  when 5  => vecinos := (distances(6)(7 downto 4), distances(9)(7 downto 4), distances(4)(7 downto 4), distances(1)(7 downto 4));
					  when 6  => vecinos := (distances(7)(7 downto 4), distances(10)(7 downto 4), distances(5)(7 downto 4), distances(2)(7 downto 4));
					  when 7  => vecinos := ("1111", distances(11)(7 downto 4), distances(6)(7 downto 4), distances(3)(7 downto 4));
					  when 8  => vecinos := (distances(9)(7 downto 4), distances(12)(7 downto 4), "1111", distances(4)(7 downto 4));
					  when 9  => vecinos := (distances(10)(7 downto 4), distances(13)(7 downto 4), distances(8)(7 downto 4), distances(5)(7 downto 4));
					  when 10 => vecinos := (distances(11)(7 downto 4), distances(14)(7 downto 4), distances(9)(7 downto 4), distances(6)(7 downto 4));
					  when 11 => vecinos := ("1111", distances(15)(7 downto 4), distances(10)(7 downto 4), distances(7)(7 downto 4));
					  when 12 => vecinos := (distances(13)(7 downto 4), "1111", "1111", distances(8)(7 downto 4));
					  when 13 => vecinos := (distances(14)(7 downto 4), "1111", distances(12)(7 downto 4), distances(9)(7 downto 4));
					  when 14 => vecinos := (distances(15)(7 downto 4), "1111", distances(13)(7 downto 4), distances(10)(7 downto 4));
					  when others => vecinos := ("1111", "1111", "1111", "1111");
				 end case;

				 vec_min := "1111";

				 if distances(seleccion)(4) = '1' then
					  vecinos(1) := "1111";
				 end if;

				 if distances(seleccion)(5) = '1' then
					  vecinos(2) := "1111";
				 end if;

				 if distances(seleccion)(6) = '1' then
					  vecinos(3) := "1111";
				 end if;

				 if distances(seleccion)(7) = '1' then
					  vecinos(0) := "1111";
				 end if;

				 for i in 0 to 3 loop -- Para encontrar el mínimo de los obtenidos
					  if unsigned(vecinos(i)) < unsigned(vec_min) then
							vec_min := (vecinos(i));
					  end if;
				 end loop;

				 return unsigned(vec_min);
			end function;

	begin
	process(clock, reset,p3,p2,p1,p0,posi,distancias_dato,vector_entrada)
	begin
			posi <= to_integer(p3 & p2 & p1 & p0);
			if reset = '0' then
					for i in 0 to 15 loop
						  if i = 15 then
								distancias_dato(i) <= "00000000"; -- casilla final la inicializo en 0000
						  elsif i= 14 or i= 11 then
								distancias_dato(i) <= "00010000";  -- inicializo 1
						  elsif i= 13 or i= 10 or i= 7 then
								distancias_dato(i) <= "00100000";  -- inicializo 2
						  elsif i= 12 or i= 9 or i= 6 or i= 3 then
								distancias_dato(i) <= "00110000"; --inicializo 3
						  elsif i= 8 or i= 5 or i= 2 then
								distancias_dato(i) <= "01000000"; -- inicializo 4
						  elsif i= 4 or i= 1 then
								distancias_dato(i) <= "01010000";
						  elsif i= 0 then
								distancias_dato(i) <= "01100000";
								end if;
					end loop;

			elsif rising_edge(clock) then
			
				for i in 0 to 14 loop 
						distancias_dato(i) <= std_logic_vector("00010000" + min_vecinos(i, distancias_dato)); --calcula la distancia de cada casilla
				   
				end loop;
				
				distancias_dato(posi) <=distancias_dato(posi)(7 downto 4) & vector_entrada;  --actualizo el nuevo posi [DONDE LOS PRIMEROS 4 SON EL PESO Y LOS ULTIMOS 4 LAS PAREDES DONDE SON N,E,S,O]
				distancias_dato(15) <=("00000000"); --por si las dudas siempre lo pongo en 00000000 
				end if;
				if ((posi<=3) or (vector_entrada(1)='1')) then---------------------LOS DE ABAJO O PARED ABAJO
					vecino_abajo <= "1111";
					else
					vecino_abajo <= distancias_dato(posi-4)(7 downto 4);
				end if;
				if ((posi>=12) or (vector_entrada(3)='1')) then---------------------LOS DE ARRIBA O PARED ARRIBA
					vecino_arriba <= "1111";
					else
					vecino_arriba <= distancias_dato(posi+4)(7 downto 4);
				end if;
				if ((posi = 0)  or (posi = 4)  or (posi = 8) or (posi = 12)  or (vector_entrada(2)='1')) then---------------------LOS DE DERECHA O PARED DER
					vecino_der <= "1111";
					else
					vecino_der <= distancias_dato(posi-1)(7 downto 4);
				end if;
				if ((posi=3) or (posi=7) or (posi=11)  or (posi=15) or (vector_entrada(0)='1')) then---------------------LOS DE IZQ O PARED IZQ
					vecino_izq <= "1111";
					else
					vecino_izq <= distancias_dato(posi+1)(7 downto 4);
				end if;
			
	end process;
end architecture;