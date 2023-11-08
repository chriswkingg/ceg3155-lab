LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY counter IS
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(3 downto 0));
END counter;
ARCHITECTURE rtl OF counter IS
	SIGNAL notA, notB, notC, notD: std_logic;
	signal outA, outB, outC, outD: std_logic;
	COMPONENT dflipflop
	PORT(
		i_d : IN STD_LOGIC;
		i_clock : IN STD_LOGIC;
		i_enable : IN STD_LOGIC;
		i_async_reset : IN STD_LOGIC;
		i_async_set : IN STD_LOGIC;
		o_q, o_qBar : OUT STD_LOGIC);
	END COMPONENT;
BEGIN
	bit0: dflipflop port map(i_async_reset => i_resetBar, i_async_set => '0', i_d => notA, i_enable => i_load, i_clock => i_clock, o_q => outA, o_qBar => notA);								
	bit1: dflipflop port map(i_async_reset => i_resetBar, i_async_set => '0', i_d => notB, i_enable => i_load, i_clock => notA, o_q => outB, o_qBar => notB);								
	bit2: dflipflop port map(i_async_reset => i_resetBar, i_async_set => '0', i_d => notC, i_enable => i_load, i_clock => notB, o_q => outC, o_qBar => notC);
	bit3: dflipflop port map(i_async_reset => i_resetBar, i_async_set => '0', i_d => notD, i_enable => i_load, i_clock => notC, o_q => outD, o_qBar => notD);
									
	o_Value(3) <= outD;
	o_Value(2) <= outC;
	o_Value(1) <= outB;
	o_Value(0) <= outA;

END rtl;
