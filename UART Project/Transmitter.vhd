LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY transmitter IS
	PORT(
		i_reset, i_clock, i_TDRE, i_loadTDR : IN STD_LOGIC;
		i_bus : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_tx, o_setTDRE, o_resetTDRE : OUT STD_LOGIC
	
	);
END transmitter;

ARCHITECTURE structural OF transmitter IS
COMPONENT TransmitterDatapath
PORT (
        i_reset : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_TDR : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- bus connection
		  i_loadTDR : IN STD_LOGIC;
		  i_rightShiftTSR, i_loadTSR : IN STD_LOGIC;
        i_SO0, i_SO1 : IN STD_LOGIC;
		  o_tx : OUT STD_LOGIC
    );
END COMPONENT;
COMPONENT TransmitterController
PORT (
        i_reset : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_TDRE : IN STD_LOGIC;
        o_setTDRE, o_resetTDRE, o_rightShiftTSR, o_SO0, o_SO1, o_loadTDR, o_loadTSR : OUT STD_LOGIC;
		  o_s : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
    );
END COMPONENT;
SIGNAL int_loadTDR, int_loadTSR, int_rightShiftTSR, int_SO0, int_SO1 : STD_LOGIC;
BEGIN
	dp : TransmitterDatapath
	PORT MAP(
        i_reset => i_reset,
        i_clock => i_clock,
        i_TDR => i_bus,
		  i_loadTDR => int_loadTDR,
		  i_rightShiftTSR => int_rightShiftTSR, 
		  i_loadTSR => int_loadTSR,
        i_SO0 => int_SO0, 
		  i_SO1 => int_SO1, 
		  o_tx => o_tx		
	);
	
	con : TransmitterController
	PORT MAP(
        i_reset => i_reset,
        i_clock => i_clock,
        i_TDRE => i_TDRE,
        o_setTDRE => o_setTDRE, 
		  o_resetTDRE => o_resetTDRE,
		  o_rightShiftTSR => int_rightShiftTSR, 
		  o_SO0 => int_SO0, 
		  o_SO1 => int_SO1, 
		  o_loadTDR => int_loadTDR, 
		  o_loadTSR => int_loadTSR,
		  o_s => open		
	);

END structural;

