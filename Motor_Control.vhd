library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Motor_control is
	port( 	clk		: in	std_logic;
		reset		: in	std_logic;
		direction	: in	std_logic;
		count_in	: in 	std_logic_vector (19 downto 0);		

		pwm		: out	std_logic);

end entity Motor_control;

architecture behavioural of Motor_control is

	type motor_controller_state is ( motor_reset, motor_H, motor_L);

	signal state, new_state:	motor_controller_state;
	
begin

	process (clk, reset)
	begin
		if (rising_edge(clk)) then
			if (reset = '1' ) then
				state <= motor_reset;
			else
				state <= new_state;
			end if;
		end if;
	end process;



	process (state, direction, count_in)
	begin
		case state is
			when motor_reset =>
				pwm <= '0';
				new_state <= motor_H;
			when motor_H =>
				pwm <= '1';
				if (direction = '0') then	--direction counter clockwise
					if (unsigned(count_in)=50000 ) then
						new_state <= motor_L;
					end if;
				elsif (direction = '1' ) then    --direction clockwise
					if (unsigned(count_in)=100000 ) then
						new_state <= motor_L;
					end if;
				else 				--if direction is not a 1/0
					new_state <= motor_reset;
				end if;
			when motor_L =>
				pwm <= '0';
				if (unsigned(count_in)=1000000) then
					new_state <= motor_reset;
				
				end if;
		end case;
	end process;
end architecture behavioural;



				