library ieee;
use ieee.std_logic_1164.all;

entity buffer_tb is
end buffer_tb;

architecture test of buffer_tb is

component Input_Buffer is
	port (	sensor_in	: in  	std_logic_vector(2 downto 0);
		clk	    	: in	std_logic;
		reset		: in	std_logic;
         	sensor_out	: out	std_logic_vector(2 downto 0));
end component Input_Buffer;

signal		sensor_in	:   	std_logic_vector(2 downto 0);
signal		clk	    	: 	std_logic;
signal		reset		: 	std_logic;
signal   	sensor_out	: 	std_logic_vector(2 downto 0);

begin

clk		<=	'0'	after 0 ns,
			'1'	after 10 ns when clk = '0' else '0' after 10 ns;

reset		<=	'1'	after 0 ns,
			'0'	after 40 ns;

sensor_in	<=	"000"	after 0 ns,
			"111"	after 10 ns,
			"000"	after 20 ns,
			"111" 	after 47 ns,
			"000"	after 67 ns,
			"111"	after 83 ns,
			"000"	after 85 ns,
			"111"	after 95 ns,
			"000"	after 118 ns;


lbl0: Input_Buffer port map( 	sensor_in	=>	sensor_in,
				clk	    	=> 	clk,
				reset		=>	reset,
         			sensor_out	=> 	sensor_out);

end architecture test;


