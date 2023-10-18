LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY msjkflipflop IS
PORT (
	i_j, i_k, i_enable, i_clock : IN STD_LOGIC;
	o_q, o_notq : OUT STD_LOGIC
);
END msjkflipflop;

ARCHITECTURE structural OF msjkflipflop IS
COMPONENT jkflipflop
PORT (
	i_j, i_k, i_enable, i_clock : IN STD_LOGIC;
	o_q, o_notq : OUT STD_LOGIC
 );
END COMPONENT;
SIGNAL int_slaveq, int_slavenotq, int_masterq, int_masternotq : STD_LOGIC;
BEGIN
	master: jkflipflop
	PORT MAP(
		i_j => i_j and int_slavenotq,
		i_k => i_k and int_slaveq,
		i_enable => i_enable,
		i_clock => i_clock,
		o_q => int_masterq,
		o_notq => int_masternotq
	);
	
	slave: jkflipflop
	PORT MAP(
		i_j => int_masterq,
		i_k => int_masternotq,
		i_enable => i_enable,
		i_clock => not i_clock,
		o_q => int_slaveq,
		o_notq => int_slavenotq
	);
	
	 

END structural;
