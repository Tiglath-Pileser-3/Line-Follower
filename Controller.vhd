library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Controller is
	port( 	clk		: in 	std_logic;
		reset_in	: in	std_logic;
		counter		: in	std_logic_vector(19 downto 0);	--from the Timebass
		sensor		: in  	std_logic_vector(2 downto 0);	--from the Input_Buffer
		reset_out	: out	std_logic;			--fires every 20 ms, determined by counter	to the 2 Motor_Controls and Timebass
		direction_left	: out	std_logic;			--to the left Motor_Control
		direction_right : out   std_logic);			--to the right Motor_Control

end entity Controller;

architecture behavioural of Controller is

	type Controller_state is ( reset, forward, gentle_left, gentle_right, sharp_left, sharp_right);

	signal state, new_state	:	Controller_state;
begin

--asynchronous reset and synchronous state register
	process (clk, reset_in)
	begin
		if (reset_in = '1') then
			reset_out <= '1';
			state <= reset;
		
		elsif (rising_edge(clk)) then
			state <= new_state;

		end if;
	end process;

--state actions
	process (state, sensor)
	begin

				case sensor is
					when "000" =>
						new_state <= forward;
					when "001" =>
						new_state <= gentle_left;
					when "010" =>
						new_state <= forward;
					when "011" =>
						new_state <= sharp_left;
					when "100" =>
						new_state <= gentle_right;
					when "101" =>
						new_state <= forward;
					when "110" =>
						new_state <= sharp_right;
					when "111" =>
						new_state <= forward;
					when others =>
						new_state <= reset;
				end case;

		case state is

			--the state that determines the direction
			when reset =>
				direction_left <= '0';
				direction_right <= '0';

			--the states that determine the directions for the Motor_Controls
			when forward =>
				direction_left <= '1';
				direction_right <= '0';
			when gentle_left =>
				direction_left <= '0';
				direction_right <= '1';
			when gentle_right =>
				direction_left <= '1';
				direction_right <= '0';
			when sharp_left =>
				direction_left <= '0';
				direction_right <= '0';
			when sharp_right =>
				direction_left <= '1';
				direction_right <= '1';
			when others =>
				new_state <= reset;
		end case;
		
	--sends reset signal to timebass(reset counting) and motor_control(new pulse) and determines new direction
	if (unsigned(counter)=20000000) then
		reset_out <= '1';
		new_state <= reset;
	end if;

	end process;

end architecture behavioural;