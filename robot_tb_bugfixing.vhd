library IEEE;
use IEEE.std_logic_1164.all;

entity robot_tb is
end entity robot_tb;

architecture structural of robot_tb is

	component robot is
		port (	clk		: in	std_logic;
			reset		: in	std_logic;

			sensor_l_in	: in	std_logic;
			sensor_m_in	: in	std_logic;
			sensor_r_in	: in	std_logic;

			motor_l_pwm	: out	std_logic;
			motor_r_pwm	: out	std_logic;

			direction_left	: out	std_logic;				--test
			direction_right : out   std_logic;
			reset_time	: out	std_logic;	
			reset_left	: out	std_logic;
			reset_right	: out	std_logic;		
			buffer_output	: out	std_logic_vector (2 downto 0);
			timebass_count	: out	std_logic_vector (19 downto 0)		--		

		);
	end component robot;

	signal	clk, reset 			: std_logic;
	signal	sensor_l, sensor_m, sensor_r	: std_logic;
	signal	sensors				: std_logic_vector(2 downto 0);
	signal	motor_l_pwm, motor_r_pwm	: std_logic;
	signal  direction_left, direction_right, reset_time, reset_right, reset_left : std_logic;	--test
	signal  buffer_output	: std_logic_vector (2 downto 0);							
	signal  timebass_count  : std_logic_vector (19 downto 0);					--
begin

	lbl0: robot port map	(	clk 			=> clk,
					reset			=> reset,
					sensor_l_in		=> sensor_l,
					sensor_m_in		=> sensor_m,
					sensor_r_in		=> sensor_r,
					motor_l_pwm		=> motor_l_pwm,
					motor_r_pwm		=> motor_r_pwm,
					direction_left		=> direction_left,		--test
					direction_right 	=> direction_right,	
					reset_time		=> reset_time,
					reset_right		=> reset_right,
					reset_left		=> reset_left,
					buffer_output		=> buffer_output,
					timebass_count		=> timebass_count		--
				);

	-- 20 ns = 50 MHz
	clk			<=	'0' after 0 ns,
					'1' after 10 ns when clk /= '1' else '0' after 10 ns;

	reset			<=	'1' after 0 ns,
					'0' after 40 ms;

	sensors 		<=	"000" after 0 ns,   -- bbb
					"001" after 70 ms,  -- bbw
					"010" after 110 ms, -- bwb
					"011" after 150 ms, -- bww
					"100" after 190 ms, -- wbb
					"101" after 230 ms, -- wbw
					"110" after 270 ms, -- wwb
					"111" after 310 ms; -- www

	sensor_l		<= 	sensors(2);
	sensor_m		<= 	sensors(1);
	sensor_r		<= 	sensors(0);

end architecture structural;
