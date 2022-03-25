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
			reset_time	: out	std_logic;			--fires every 20 ms, determined by counter	to the Timebass
			reset_left	: out	std_logic;			--to the left Motor_Control, used to stop the motor
			reset_right	: out	std_logic;			--to the right Motor_Control, used to stop the motor
			direction_left	: out	std_logic;			--to the left Motor_Control
			direction_right : out   std_logic);			--to the right Motor_Control
	end component Controller;

	component timebass is
		port (	clk_in : in  	std_logic;
        	 	reset  : in  	std_logic;
        	 	count  : out 	std_logic_vector(19 downto 0));
	end component timebass;


signal	clk		: std_logic;
signal	reset_in	: std_logic;
signal	counter		: std_logic_vector(19 downto 0);	
signal	sensor		: std_logic_vector(2 downto 0);	
signal	reset_time	: std_logic;	
signal  reset_left	: std_logic;
signal  reset_right	: std_logic;
signal	direction_left	: std_logic;			
signal	direction_right : std_logic;		

begin

clk		<= 	'0' 	after 0 ns,
	   		'1' 	after 10 ns when clk = '0' else '0' after 10 ns;

reset_in	<=	'1'	after 0 ns,
			'0'	after 80 ns,
			'1'	after 150 ns,
			'0'	after 200 ns;		--doesn't affect the counting yet, because reset_time is not fired :(

sensor		<=	"000"	after 0 ns,		--forward
			"001"	after 20 ns,		--testing the reset_in
			"000"	after 40 ns,
			"001"	after 180 ns,		--gentle left
			"010"	after 280 ns,		--forward
			"011"	after 380 ns,		--sharp left
			"100"	after 480 ns,		--gentle right
			"101"	after 580 ns,		--forward
			"110"	after 680 ns,		--sharp right
			"111"	after 780 ns,		--forward
			"110"	after 1000 ns;		--test

lbl0: Controller port map(	clk			=>	clk	,	
				reset_in		=>	reset_in,
				counter			=>	counter,
				sensor			=>	sensor,
				reset_time		=>	reset_time,
				reset_left		=>	reset_left,
				reset_right		=>	reset_right,
				direction_left		=>	direction_left,
				direction_right		=>	direction_right);

lbl1: timebass port map(	clk_in			=>	clk,
				reset			=>	reset_time,
				count			=>	counter);
end architecture structural;
