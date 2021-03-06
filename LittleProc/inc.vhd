
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity inc is
	port( A: in std_logic_vector (7 downto 0);
		A_plus: out std_logic_vector (7 downto 0));
end inc;

architecture functional of inc is
attribute keep: boolean;
attribute keep of A_plus: signal is true; 
begin
	process(A)
	begin
		if (A= "11111111") then
			A_plus<="00000000";
		else
		A_plus <= A + 1;
			end if;
	end process;
end functional;