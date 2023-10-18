LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fourbitcounter IS
    PORT (
			i_inc, i_clock, i_reset : IN STD_LOGIC;
			o_count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	 );
END fourbitcounter;

ARCHITECTURE structural OF fourbitcounter IS
COMPONENT dflipflop
PORT (
	i_d : IN STD_LOGIC;
	i_clock : IN STD_LOGIC;
	i_enable : IN STD_LOGIC;
	i_async_reset : IN STD_LOGIC;
	i_async_set : IN STD_LOGIC;
	o_q, o_qBar : OUT STD_LOGIC
);
END COMPONENT;
SIGNAL int_q, int_notq : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	d0: dflipflop
	PORT MAP(
		i_d => int_notq(0),
		i_clock => i_clock,
		i_enable => i_inc,
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_q(0),
		o_qBar => int_notq(0)
	);
	d1: dflipflop
	PORT MAP(
		i_d => int_notq(1),
		i_clock => int_q(0),
		i_enable => i_inc,
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_q(1),
		o_qBar => int_notq(1)
	);
	d2: dflipflop
	PORT MAP(
		i_d => int_notq(2),
		i_clock => int_q(1),
		i_enable => i_inc,
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_q(2),
		o_qBar => int_notq(2)
	);

	o_count <= int_q;
	 

END structural;
