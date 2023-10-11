LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fourbitaddsub IS
PORT(
	i_x, i_y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	i_sub : IN STD_LOGIC;
	o_s : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	o_carry : OUT STD_LOGIC
);
END fourbitaddsub;

ARCHITECTURE rtl OF fourbitaddsub IS
SIGNAL carry0, carry1, carry2, carry3 : STD_LOGIC;
COMPONENT onebitfa
PORT(
	i_x, i_y, i_c : IN STD_LOGIC;
	o_s, o_c : OUT STD_LOGIC
);
END COMPONENT;
BEGIN
	bit0 : onebitfa
	PORT MAP(
		i_x => i_x(0),
		i_y => i_y(0) xor i_sub,
		i_c => i_sub,
		o_s => o_s(0),
		o_c => carry0
	);
	bit1 : onebitfa
	PORT MAP(
		i_x => i_x(1),
		i_y => i_y(1) xor i_sub,
		i_c => carry0,
		o_s => o_s(1),
		o_c => carry1
	);
	bit2 : onebitfa
	PORT MAP(
		i_x => i_x(2),
		i_y => i_y(2) xor i_sub,
		i_c => carry1,
		o_s => o_s(2),
		o_c => carry2
	);
	bit3 : onebitfa
	PORT MAP(
		i_x => i_x(3),
		i_y => i_y(3) xor i_sub,
		i_c => carry2,
		o_s => o_s(3),
		o_c => o_carry
	);
	
END rtl;