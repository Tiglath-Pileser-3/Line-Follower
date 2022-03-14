library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

--clk_in: 50 Mhz clk signal
--count: 1 to 10^6 counter
entity timebass is
   port (clk_in : in  	std_logic;
         reset  : in  	std_logic;
         count	: out 	std_logic_vector(19 downto 0));
end timebass;

architecture behaviour of timebass is
begin
outp:	process (clk_in, reset)

	--the "core" counting variable, will have the same value as output count.
	variable counter 	: std_logic_vector(19 downto 0) := (others => '0');

	--"+1"variable to copy to the output count and to the counting variable counter.
	variable counter_new	: std_logic_vector(19 downto 0) := (others => '0');
	begin
 	 	if (clk_in'event and clk_in = '1') then
  			if (reset = '1') then
				counter_new	:= (others => '0');
				count		<= (others => '0');
 		 	else
				counter_new 	:= std_logic_vector(unsigned(counter) + 1);
				count		<= counter_new;
    			end if;
		counter	:= counter_new;
    		end if;
	end process;

end behaviour;
