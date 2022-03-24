library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture structural of testbench is
	component timebass is
		port( 	clk_in 	: in 	std_logic;
			reset	: in	std_logic;
			count	: out	std_logic_vector(19 downto 0)
		);
	end component timebass;

	signal	clk_in_TB	:	std_logic;
	signal	reset_TB	:	std_logic;
	signal	count_TB	:	std_logic_vector(19 downto 0);
begin
	clk_in_TB	<=	'0'	after 0 ns,
				'1'	after 10 ns when clk_in_TB = '0' else '0' after 10 ns;
	reset_TB	<=	'1'	after 0 ns,
				'0' 	after 50 ns,
				'1'	after 20000050 ns,
				'0'	after 20000070 ns;



tbport:	Timebass port map (	clk_in			=>	clk_in_TB,
				reset			=>	reset_TB,
				count			=>	count_TB
			);
end architecture structural;


