library IEEE;
use IEEE.std_logic_1164.all;

entity robot is
	port (  clk             : in    std_logic;
		reset           : in    std_logic;

		sensor_l_in     : in    std_logic;
		sensor_m_in     : in    std_logic;
		sensor_r_in     : in    std_logic;

		motor_l_pwm     : out   std_logic;
		motor_r_pwm     : out   std_logic
	);
end entity robot;


component Controller
	port(	clk		: in 	std_logic;
		reset_in	: in	std_logic;
		counter		: in	std_logic_vector(19 downto 0);
		sensor		: in  	std_logic_vector(2 downto 0);
		reset_time	: out	std_logic;
		reset_left	: out	std_logic;
		reset_right	: out	std_logic;
		direction_left	: out	std_logic;
		direction_right : out   std_logic);
end component

component Input_buffer
	port(	sensor_in	: in  	std_logic_vector(2 downto 0);
		clk	    	: in	std_logic;
		reset		: in	std_logic;
		sensor_out	: out	std_logic_vector(2 downto 0));
end component

component Motor_control
	port(	clk		: in	std_logic;
		reset		: in	std_logic;
		direction	: in	std_logic;
		count_in	: in 	std_logic_vector (19 downto 0);
		pwm		: out	std_logic);
end component

component Timebass
	port(	clk_in 	: in 	std_logic;
		reset	: in	std_logic;
		count	: out	std_logic_vector(19 downto 0));
end component


signal buff_input: std_logic_vector(2 downto 0);
signal count_signal: std_logic_vector(19 downto 0);
signal rst_time_s, rst_left_s,rst_right_s,direct_left_s,direct_right_s, reset: std_logic;

