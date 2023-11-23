LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FSMController IS
PORT(
	i_clock, i_reset, i_sscs, i_timerExpired : IN STD_LOGIC;
	o_loadCounter, o_enableCounter : OUT STD_LOGIC;
	o_comparatorSelect : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	o_MSTL, o_SSTL, o_s : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)); -- o_s is debug only
END FSMController;


ARCHITECTURE structural OF FSMController IS
	COMPONENT dflipflop
	PORT(
		i_d : IN STD_LOGIC;
		i_clock : IN STD_LOGIC;
		i_enable : IN STD_LOGIC;
		i_async_reset : IN STD_LOGIC;
		i_async_set : IN STD_LOGIC;
		o_q, o_qBar : OUT STD_LOGIC);
	END COMPONENT;
	SIGNAL int_s : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL int_sNext : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
	s0 : dflipflop
	PORT MAP(
		i_d => int_sNext(0),
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_s(0)
	);
	s1 : dflipflop
	PORT MAP(
		i_d => int_sNext(1),
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_s(1)
	);
	s2 : dflipflop
	PORT MAP(
		i_d => int_sNext(2),
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => int_s(2)
	);
	
	int_sNext(0) <= (int_s(2) and int_s(1)) or ((not int_s(2)) and (not int_s(1)) and (not int_s(0))) or ((not int_s(2)) and (not int_s(1)) and (not i_timerExpired)) or ((not int_s(2)) and (not int_s(1)) and i_sscs);
	int_sNext(1) <= ((not int_s(2)) and int_s(1)) or (int_s(1) and (not int_s(0))) or (int_s(1) and (not i_timerExpired)) or ((not int_s(2)) and int_s(0) and i_timerExpired and i_sscs);
	int_sNext(2) <= (int_s(2) and (not i_timerExpired)) or (int_s(2) and int_s(0)) or (int_s(1) and (not int_s(0)) and i_timerExpired);

	
	-- 0 is green, 1 is yellow, 2 is red
	o_MSTL(0) <= (not int_s(2)) and (not int_s(1));
	o_MSTL(1) <= (not int_s(2)) and int_s(1);
	o_MSTL(2) <= int_s(2);
	
	o_SSTL(0) <= int_s(2) and int_s(1);
	o_SSTL(1) <= int_s(2) and (not int_s(1));
	o_SSTL(2) <= not int_s(2);
	
	-- aux control signals
	o_loadCounter <= ((not int_s(2)) and (not int_s(1)) and (not int_s(0))) or ((not int_s(2)) and int_s(1) and int_s(0)) or (int_s(2) and int_s(1) and (not int_s(0))) or (int_s(2) and int_s(1) and int_s(0));
	o_enableCounter <= (not int_s(1) and int_s(0)) or (int_s(2) and (not int_s(1))) or ((not int_s(2)) and int_s(1) and (not int_s(0)));
	
	o_comparatorSelect(0) <= ((not int_s(2)) and int_s(1)) or (int_s(2) and (not int_s(1)));
	o_comparatorSelect(1) <= int_s(2);
	
	--debug
	o_s <= int_s;

END structural;