
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity PC is
    port( asynResetn, load, ck, init: in std_logic;
		datain: in std_logic_vector (11 downto 0);
		PCdataout: out std_logic_vector (11 downto 0) );
end PC;

architecture behave of PC is
attribute keep: boolean;
attribute keep of PCdataout: signal is true;
begin 
    process(ck, asynResetn)
    variable state: std_logic_vector (11 downto 0);
    begin
		if(asynResetn = '0') then
			state := "000000000000";
		elsif(ck'event and ck='1') then
			if(load = '1') then
				if(init = '1') then
					state := "000000000001";
				else
					state := datain;
				end if;
			end if;
		end if;
		PCdataout <= state;
    end process;
end behave;