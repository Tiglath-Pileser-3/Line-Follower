library IEEE;
use IEEE.std_logic_1164.all;

entity controller_tb is
end entity controller_tb;

architecture structural of controller_tb is

	component Controller is
		port(	clk		: in 	std_logic;
			reset_in	: in	std_logic;
			counter		: in	std_logic_vector(19 downto 0);	--from the Timebass
			sensor		: in  	std_logic_vector(2 downto 0);	--from the Input_Buffer
			reset_out	: out	std_logic;			--fires every 20 ms, determined by counter	to the 2 Motor_Controls and Timebass
			direction_left	: out	std_logic;			--to the left Motor_Control
			direction_right : out   std_logic);			--to the right Motor_Control
		
	end component Controller;

signal	clk		: std_logic;
signal	reset_in	: std_logic;
signal	counter		: std_logic_vector(19 downto 0);	
signal	sensor		: std_logic_vector(2 downto 0);	
signal	reset_out	: std_logic;			
signal	direction_left	: std_logic;			
signal	direction_right : std_logic;			


begin

clk		<= 	'0' 	after 0 ns,
	   		'1' 	after 10 ns when clk = '0' else '0' after 10 ns;

reset_in	<=	'1'	after 0 ns,
			'0'	after 40 ns;

counter		<=	"00000000000000000000"	after 0 ns;

sensor		<=	"000"	after 40 ns,		--forward
			"001"	after 140 ns,		--gentle left
			"010"	after 240 ns,		--forward
			"011"	after 340 ns,		--sharp left
			"100"	after 440 ns,		--gentle right
			"101"	after 540 ns,		--forward
			"110"	after 640 ns,		--sharp right
			"111"	after 740 ns;		--forward
lbl0: Controller port map(	clk			=>	clk	,	
				reset_in		=>	reset_in,
				counter			=>	counter,
				sensor			=>	sensor,
				reset_out		=>	reset_out,
				direction_left		=>	direction_left,
				direction_right		=>	direction_right);
end architecture structural;