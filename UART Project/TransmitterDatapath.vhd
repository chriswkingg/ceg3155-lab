LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TransmitterDatapath IS
    PORT (
        i_resetBar : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_TDR : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  i_loadTDR : IN STD_LOGIC;
		  i_rightShiftTSR, i_loadTSR : IN STD_LOGIC;
        i_SO0, i_SO1 : IN STD_LOGIC
		  o_tx : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
    );
END TransmitterDatapath;

ARCHITECTURE structural OF TransmitterDatapath IS
COMPONENT eightBitShiftRegisterStructural
PORT (
	  i_resetBar, i_load, i_shiftLeft, i_shiftRight : IN STD_LOGIC;
	  i_clock : IN STD_LOGIC;
	  i_Value : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	  o_Value : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT;

BEGIN
-- wip
END structural;
