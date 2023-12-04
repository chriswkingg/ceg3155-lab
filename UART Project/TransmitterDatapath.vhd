LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TransmitterDatapath IS
    PORT (
        i_resetBar : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_TDRE : IN STD_LOGIC;
        o_setTDRE, o_resetTDRE, o_rightShiftTSR, o_SO0, o_SO1, o_loadTDR, o_loadTSR : OUT STD_LOGIC;
		  o_s : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
    );
END TransmitterDatapath;

ARCHITECTURE structural OF TransmitterDatapath IS
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

BEGIN
-- wip
END structural;
