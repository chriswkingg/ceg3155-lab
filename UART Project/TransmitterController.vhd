LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TransmitterController IS
    PORT (
        i_resetBar : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_TDRE : IN STD_LOGIC;
        o_setTDRE, o_resetTDRE, o_rightShiftTSR, o_SO0, o_SO1, o_loadTDR, o_loadTSR : OUT STD_LOGIC;
		  o_s : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
    );
END TransmitterController;

ARCHITECTURE structural OF TransmitterController IS
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


	 SIGNAL int_s : STD_LOGIC_VECTOR(11 DOWNTO 0);
BEGIN
	s0: dflipflop
	 PORT MAP (
		  i_d => (int_s(0) and (not i_TDRE)) or int_s(11),
		  i_clock => i_clock,
		  i_enable => '1',
		  i_async_set => i_resetBar,
		  i_async_reset => '0',
		  o_q => int_s(0),
		  o_qBar => open
	 );
		 s1: dflipflop
		 PORT MAP (
			  i_d => int_s(0) and i_TDRE,
			  i_clock => i_clock,
			  i_enable => '1',
			  i_async_set => '0',
			  i_async_reset => i_resetBar,
			  o_q => int_s(1),
			  o_qBar => open
		 );
		 s2: dflipflop
		 PORT MAP (
			  i_d => int_s(1),
			  i_clock => i_clock,
			  i_enable => '1',
			  i_async_set => '0',
			  i_async_reset => i_resetBar,
			  o_q => int_s(2),
			  o_qBar => open
		 );
		 s3: dflipflop
		 PORT MAP (
			  i_d => int_s(2),
			  i_clock => i_clock,
			  i_enable => '1',
			  i_async_set => '0',
			  i_async_reset => i_resetBar,
			  o_q => int_s(3),
			  o_qBar => open
		 );
		 s4: dflipflop
		 PORT MAP (
			  i_d => int_s(3),
			  i_clock => i_clock,
			  i_enable => '1',
			  i_async_set => '0',
			  i_async_reset => i_resetBar,
			  o_q => int_s(4),
			  o_qBar => open
		 );
		 s5: dflipflop
		 PORT MAP (
			  i_d => int_s(4),
			  i_clock => i_clock,
			  i_enable => '1',
			  i_async_set => '0',
			  i_async_reset => i_resetBar,
			  o_q => int_s(5),
			  o_qBar => open
		 );
		 s6: dflipflop
		 PORT MAP (
			  i_d => int_s(5),
			  i_clock => i_clock,
			  i_enable => '1',
			  i_async_set => '0',
			  i_async_reset => i_resetBar,
			  o_q => int_s(6),
			  o_qBar => open
		 );
		 s7: dflipflop
		 PORT MAP (
			  i_d => int_s(6),
			  i_clock => i_clock,
			  i_enable => '1',
			  i_async_set => '0',
			  i_async_reset => i_resetBar,
			  o_q => int_s(7),
			  o_qBar => open
		 );
		 s8: dflipflop
		 PORT MAP (
			  i_d => int_s(7),
			  i_clock => i_clock,
			  i_enable => '1',
			  i_async_set => '0',
			  i_async_reset => i_resetBar,
			  o_q => int_s(8),
			  o_qBar => open
		 );
		 s9: dflipflop
		 PORT MAP (
			  i_d => int_s(8),
			  i_clock => i_clock,
			  i_enable => '1',
			  i_async_set => '0',
			  i_async_reset => i_resetBar,
			  o_q => int_s(9),
			  o_qBar => open
		 );
		 s10: dflipflop
		 PORT MAP (
			  i_d => int_s(9),
			  i_clock => i_clock,
			  i_enable => '1',
			  i_async_set => '0',
			  i_async_reset => i_resetBar,
			  o_q => int_s(10),
			  o_qBar => open
		 );
		 s11: dflipflop
		 PORT MAP (
			  i_d => int_s(10),
			  i_clock => i_clock,
			  i_enable => '1',
			  i_async_set => '0',
			  i_async_reset => i_resetBar,
			  o_q => int_s(11),
			  o_qBar => open
		 );
		 
		 o_setTDRE <= int_s(2);
		 o_resetTDRE <= int_s(1);
		 o_SO0 <= int_s(0) or int_s(1) or int_s(2);
		 o_SO1 <= int_s(3);
		 o_loadTDR <= int_s(1);
		 o_loadTSR <= int_s(2);
		 o_rightShiftTSR <= int_s(5) or int_s(6) or int_s(7) or int_s(8) or int_s(9) or int_s(10) or int_s(11);
		 o_s <= int_s;
END structural;
