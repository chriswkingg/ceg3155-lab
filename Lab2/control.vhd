LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY control IS 
	PORT (
		 i_clock, i_reset, i_countgt, i_remaindergteq, i_sign, i_a3, i_b3: IN STD_LOGIC;
		 o_loadSign, o_clearSign, o_incrementCounter, o_clearCounter, o_loadDividend, o_leftShiftDividend, o_addSubDividend, o_clearRemainder, o_leftShiftRemainder, o_loadRemainder,o_loadDivisor, o_addSubDivisor, o_loadQuotient, o_rightShiftQuotient, o_rightShiftInQuotient, o_clearQuotient : OUT STD_LOGIC
	);

END control;

ARCHITECTURE structural OF control IS
COMPONENT dflipflop
    PORT(
        i_d : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_enable : IN STD_LOGIC;
        i_async_reset : IN STD_LOGIC;
        i_async_set : IN STD_LOGIC;
        o_q, o_qBar : OUT STD_LOGIC
    );
END COMPONENT;
SIGNAL s : STD_LOGIC_VECTOR(9 DOWNTO 0);
BEGIN
	dff0: dflipflop
	PORT MAP (
		i_d => '1',
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => '0',
		i_async_set => i_reset,
		o_q => s(0)
	);
	dff1: dflipflop
	PORT MAP (
		i_d => s(0) and i_a3,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => s(1)
	);
	dff2: dflipflop
	PORT MAP (
		i_d => s(0) and not i_a3,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => s(2)
	);
	dff3: dflipflop
	PORT MAP (
		i_d => (s(1) or s(2)) and i_b3,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => s(3)
	);
	dff4: dflipflop
	PORT MAP (
		i_d => (s(1) or s(2)) and not i_b3,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => s(4)
	);
	dff5: dflipflop
	PORT MAP (
		i_d => s(3) or s(4),
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => s(5)
	);
	dff6: dflipflop
	PORT MAP (
		i_d => (s(5) or s(7) or s(8)) and not i_countgt,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => s(6)
	);
	dff7: dflipflop
	PORT MAP (
		i_d => s(6) and i_remaindergteq,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => s(7)
	);
	dff8: dflipflop
	PORT MAP (
		i_d => s(6) and not i_remaindergteq,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => s(8)
	);
	dff9: dflipflop
	PORT MAP (
		i_d => (s(7) or s(8)) and i_sign,
		i_clock => i_clock,
		i_enable => '1',
		i_async_reset => i_reset,
		i_async_set => '0',
		o_q => s(9)
	);
	 
	 o_loadSign <= s(1) or s(3);
	 o_clearSign <= s(0);
	 o_incrementCounter <= s(7); 
	 o_clearCounter <= s(5);
	 o_loadDividend <= s(1) or s(2);
	 o_leftShiftDividend <= s(6); 
	 o_addSubDividend <= s(1);
	 o_clearRemainder <= s(5);
	 o_leftShiftRemainder <= s(6);
	 o_loadRemainder <= s(7);
	 o_loadDivisor <= s(3) or s(4);
	 o_addSubDivisor <= s(3);
	 o_loadQuotient <= s(9);
	 o_rightShiftQuotient <= s(7);
	 o_rightShiftInQuotient <= s(7);
	 o_clearQuotient <= s(5);

END structural;