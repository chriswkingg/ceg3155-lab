library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
entity BaudGenerator is
	port(i_clk, rst_b: in std_logic;
		i_baudsel: in std_logic_vector(2 downto 0);
		o_BclkX8: out std_logic;
		o_Bclk: out std_logic);
end BaudGenerator;
architecture behav of BaudGenerator is
	signal int_13counter: std_logic_vector (3 downto 0):= "0000"; -- div by 13 
	signal int_256counter: std_logic_vector (7 downto 0):= "00000000"; -- div by 256 
	signal int_8counter: std_logic_vector (2 downto 0):= "000"; -- div by 8
	signal int_clkdiv13: std_logic;
	signal int_BclkX8 : std_logic;
begin
process (i_clk) -- 
begin
	if (i_clk'event and i_clk = '1') then
		if (int_13counter = "1100") then 
			int_13counter <= "0000";
		else 
			int_13counter <= int_13counter + 1; 
		end if;
	end if;
end process;


int_clkdiv13 <= int_13counter(3); -- divide i_clk by 13


process (int_clkdiv13) -- clk_divdr is an 8-bit counter
begin
	if (rising_edge(int_clkdiv13)) then
		int_256counter <= int_256counter + 1;
	end if;
end process;


int_BclkX8 <= int_256counter(CONV_INTEGER(i_baudsel)); -- convert baud selector to int for indexing counter


process (int_BclkX8)
begin
	if (rising_edge(int_BclkX8)) then
		int_8counter <= int_8counter + 1;
	end if;
end process;

o_Bclk <= int_8counter(2); -- div by 8
o_BclkX8 <= int_BclkX8;

end behav;