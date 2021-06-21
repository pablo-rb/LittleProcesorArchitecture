
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;

entity reg is
    port( asynResetn, load, ck: in std_logic;
		datain: in std_logic_vector (11 downto 0);
		dataout: out std_logic_vector (11 downto 0) );
end reg;

architecture behave of reg is
begin 
    process(ck, asynResetn)
    variable state: std_logic_vector (11 downto 0);
    begin
		if(asynResetn = '0') then
			state := "000000000000";
		elsif(ck'event and ck='1') then
			if(load = '1') then
				state := datain;
			end if;
		end if;
		dataout <= state;
    end process;
end behave;