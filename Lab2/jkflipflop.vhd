LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY jkflipflop IS
PORT (
	i_j, i_k, i_enable, i_clock : IN STD_LOGIC;
	o_q, o_notq : OUT STD_LOGIC
);
END jkflipflop;

ARCHITECTURE structural OF jkflipflop IS
COMPONENT enabledSRlatch
PORT (
	i_set, i_reset : IN STD_LOGIC;
	i_enable : IN STD_LOGIC;
	o_q, o_qBar : OUT STD_LOGIC
 );
END COMPONENT;
SIGNAL int_s, int_r, int_q : STD_LOGIC;
SIGNAL int_notq : STD_LOGIC := '1';
BEGIN
	int_s <= not (i_j and int_notq and i_clock);
	int_r <= not (i_k and int_q and i_clock);
	int_q <= int_s nand int_notq;
	int_notq <= int_r nand int_q;
	
	o_q <= int_q;
	o_notq <= int_notq;
	 

END structural;
