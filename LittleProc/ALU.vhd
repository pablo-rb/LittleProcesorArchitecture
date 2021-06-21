---------------------------------------------------
-- Simple ALUv0 Module (ESD book Figure 2.5)		
-- by Antoni Porter, 07/2006
--
-- ALUv0 stands for arithmatic logic unit.
-- It perform multiple operations according to 
-- the control bits.
-- we use 2's complement subraction in this example
-- two 2-bit inputs & carry-bit ignored
---------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

---------------------------------------------------

entity ALU is

port(	
    A:			in std_logic_vector(11 downto 0);
	B:			in std_logic_vector(11 downto 0);
	sel:		in std_logic_vector(2 downto 0);
	ck : 		in std_logic;
	C:			out std_logic_vector(11 downto 0);
	carry: 		out std_logic;
	zero: 		out std_logic;
	negative: 	out std_logic
);

end ALU;

---------------------------------------------------

architecture behv of ALU is
  signal RESULTAT: std_logic_vector(12 downto 0);
  signal carryV: std_logic;

  attribute keep:boolean;
  attribute keep of C: signal is true;
begin					   

  process(A, B, sel, RESULTAT, carryV)
	variable temp: std_logic_vector(11 downto 0);
    begin
	
	case sel is
		when "000" =>
		    -- Paso transparente
			RESULTAT <= ('0' & B) ;
        when "001" =>
            -- resta
			temp := (not (B)) + 1;
			RESULTAT <= ('0'& A) + ('0' & temp);			
	    when "010" =>
	        -- suma						
	        RESULTAT <= ('0' & A)+('0' & B);
	    when "011" =>
	        -- mascara de los 4 primeros bits	 
			RESULTAT <= ('0' & B) AND "0000011111111";
	    when "100" =>
	        -- incremento en 1 del valor que llega por bus B						
	        RESULTAT <=('0' & B) + 1;
        when "101" =>
	        -- rotacion a la derecha con inclusion de carry						
	        RESULTAT <=('0' & (to_stdlogicvector(to_bitvector(B) srl 1)));
	        RESULTAT(12) <= B(0);
	        RESULTAT(11) <= carryV;
	    when "110" =>
	        -- desplazamiento a la derecha con inclusion de carry						
	        RESULTAT <=('0' & (to_stdlogicvector(to_bitvector(B) srl 1)));
	        RESULTAT(12) <= carryV;
	        RESULTAT(11) <= carryV;    
	            	    
	    when others =>	 
			RESULTAT <= "XXXXXXXXXXXXX";
    end case;

	C <= RESULTAT(11 downto 0);
		 
  end process;

  process (ck)
  begin
	if(ck'event and ck='1') then
		if(sel="001" or sel="010" or sel="100" or sel="101" or sel="110") then
		    if(sel /= "100") then 
			    if(RESULTAT(11 downto 0) = "000000000000") then 
                    zero <='1'; 
				else 
			        zero <='0'; 
			    end if;
			end if;     
		    negative <= RESULTAT(11);
		    carry    <= RESULTAT(12);
		    carryV   <= RESULTAT(12);
		end if;
	end if;
  end process;
end behv;

----------------------------------------------------