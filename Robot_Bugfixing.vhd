library IEEE;
use IEEE.std_logic_1164.all;

entity robot is
	port (  clk             : in    std_logic;
		reset           : in    std_logic;

		sensor_l_in     : in    std_logic;
		sensor_m_in     : in    std_logic;
		sensor_r_in     : in    std_logic;

		motor_l_pwm     : out   std_logic;
		motor_r_pwm     : out   std_logic;

		direction_left	: out	std_logic;				--test
		direction_right : out   std_logic;		
		reset_time	: out	std_logic;	
		reset_left	: out	std_logic;
		reset_right	: out	std_logic;		
		buffer_output	: out	std_logic_vector (2 downto 0);
		timebass_count	: out	std_logic_vector (19 downto 0)		--
	);
end entity robot;

architecture structural of robot is

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
end component;

component Input_buffer
	port(	sensor_in	: in  	std_logic_vector(2 downto 0);
		clk	    	: in	std_logic;
		reset		: in	std_logic;
		sensor_out	: out	std_logic_vector(2 downto 0));
end component;

component Motor_control
	port(	clk		: in	std_logic;
		reset		: in	std_logic;
		direction	: in	std_logic;
		count_in	: in 	std_logic_vector (19 downto 0);
		pwm		: out	std_logic);
end component;

component Timebass
	port(	clk_in 	: in 	std_logic;
		reset	: in	std_logic;
		count	: out	std_logic_vector(19 downto 0));
end component;


signal buff_input, buff_output: std_logic_vector(2 downto 0);
signal count_signal: std_logic_vector(19 downto 0);
signal rst_time_s, rst_left_s,rst_right_s,direct_left_s,direct_right_s: std_logic;

begin

--merging the sensor input into a vector for the Input_Buffer
buff_input  <=  sensor_l_in & sensor_m_in & sensor_r_in;

input_robot: Input_Buffer port map (	sensor_in	=>	buff_input,
					clk	    	=>	clk,
					reset		=>	reset,
					sensor_out	=>	buff_output);

control_robot: Controller port map (	clk		=>	clk,
					reset_in	=>	reset,
					counter		=>	count_signal,
					sensor		=>	buff_output,
					reset_time	=>	rst_time_s,
					reset_left	=>	rst_left_s,
					reset_right	=>	rst_right_s,
					direction_left	=>	direct_left_s,
					direction_right =>	direct_right_s);

timebass_robot: Timebass port map (	clk_in 		=>	clk,
					reset		=>	rst_time_s,
					count		=>	count_signal);

--left motor control
motor_control_1: Motor_control port map(clk		=>	clk,
					reset		=>	rst_left_s,
					direction	=>	direct_left_s,
					count_in	=>	count_signal,
					pwm		=>	motor_l_pwm);

--right motor control
motor_control_r: Motor_control port map(clk		=>	clk,
					reset		=>	rst_right_s,
					direction	=>	direct_right_s,
					count_in	=>	count_signal,
					pwm		=>	motor_r_pwm);

direction_left <= direct_left_s;		--test
direction_right <= direct_right_s;
reset_time <= rst_time_s;
reset_left <= rst_left_s;
reset_right <= rst_right_s;			
buffer_output <= buff_output;
timebass_count <= count_signal;

end architecture structural;