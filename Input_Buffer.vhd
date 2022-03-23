library ieee;
use ieee.std_logic_1164.all;

entity Input_Buffer is
   port (sensor_in	: in  	std_logic_vector(2 downto 0);
	 clk	    	: in	std_logic;
	 reset		: in	std_logic;
         sensor_out	: out	std_logic_vector(2 downto 0));
end Input_Buffer;

architecture behaviour of Input_Buffer is
begin

--asynchronous reset
process(clk,reset)

--values of the output of the flip-flops, ffq2 will be the same value as sensor_out
	variable ffq1, ffq2 : std_logic_vector(2 downto 0);

	begin

--flip-flops are resetted
		if(reset='1') then
			ffq1 := "000";
			ffq2 := "000";

--flip-flop do their flip flop
		else
			if(rising_edge(clk)) then
				ffq2 := ffq1;
				ffq1 := sensor_in;
			end if;
		end if;
		
		sensor_out <= ffq2;

end process;

end architecture behaviour;
