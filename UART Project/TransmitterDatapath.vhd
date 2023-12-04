LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TransmitterDatapath IS
    PORT (
        i_reset : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_TDR : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- bus connection
		  i_loadTDR : IN STD_LOGIC;
		  i_rightShiftTSR, i_loadTSR : IN STD_LOGIC;
        i_SO0, i_SO1 : IN STD_LOGIC;
		  o_tx : OUT STD_LOGIC
    );
END TransmitterDatapath;

ARCHITECTURE structural OF TransmitterDatapath IS
COMPONENT eightBitShiftRegisterStructural
PORT (
	  i_reset, i_load, i_shiftLeft, i_shiftRight : IN STD_LOGIC;
	  i_clock : IN STD_LOGIC;
	  i_Value : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  o_Value : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT;

COMPONENT fouronemux
PORT (
	w0, w1, w2, w3 : IN STD_LOGIC;
	s0, s1 : IN STD_LOGIC;
	f : OUT STD_LOGIC
);
END COMPONENT;
SIGNAL int_TDRout : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL int_TSRout : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	TDR : eightBitShiftRegisterStructural
	PORT MAP (
		i_reset => i_reset, 
		i_load => i_loadTDR,
		i_shiftLeft => '0',
		i_shiftRight => '0',
		i_clock => i_clock,
		i_Value => i_TDR, 
		o_Value => int_TDRout	
	);
	
	TSR : eightBitShiftRegisterStructural
	PORT MAP (
		i_reset => i_reset, 
		i_load => i_loadTSR,
		i_shiftLeft => '0',
		i_shiftRight => i_rightShiftTSR,
		i_clock => i_clock,
		i_Value => int_TDRout, 
		o_Value => int_TSRout	
	);
	
	outputmux : fouronemux
	PORT MAP (
		w0 => int_TSRout(0),
		w1 => '0',
		w2 => '1',
		w3 => '0',
		s0 => i_sO0,
		s1 => i_sO1,
		f => o_tx
	);
END structural;
