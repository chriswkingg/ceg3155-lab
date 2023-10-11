LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY onebitfa IS
PORT(
	i_x, i_y, i_c : IN STD_LOGIC;
	o_s, o_c : OUT STD_LOGIC
);
END onebitfa;

ARCHITECTURE rtl OF onebitfa IS
SIGNAL int_xxory, int_xandy, int_candxxory : STD_LOGIC;
BEGIN
	int_xxory <= i_x xor i_y;
	int_xandy <= i_x and i_y;
	int_candxxory <= i_c and int_xxory;
	o_s <= i_c xor int_xxory;
	o_c <= int_candxxory or int_xandy;
END rtl;