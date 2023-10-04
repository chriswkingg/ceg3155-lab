LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY datapath IS
PORT(
	clock : IN STD_LOGIC;
	selDisplayA, selDisplayB, loadDisplay : IN STD_LOGIC;
	loadLMask, lMaskShiftLeft : IN STD_LOGIC;
	loadRMask, rMaskShiftRight : IN STD_LOGIC;
	o_display : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END datapath;

architecture rtl of datapath is
COMPONENT eightbitfourtoonemux
PORT(
	w0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	w1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	w2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	w3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	s0 : IN STD_LOGIC;
	s1 : IN STD_LOGIC;
	f : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT;

COMPONENT eightBitShiftRegisterStructural
PORT(
	i_resetBar, i_load, i_shiftLeft, i_shiftRight : IN STD_LOGIC;
	i_clock : IN STD_LOGIC;
	i_Value : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	o_Value : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END COMPONENT;

SIGNAL int_lMaskOut, int_rMaskOut, int_xorLMaskRMask, int_displayMuxOutput : STD_LOGIC_VECTOR(7 DOWNTO 0);
begin
	int_xorLMaskRMask <= int_lMaskOut xor int_rmaskOut;
	displayMux : eightbitfourtoonemux
	PORT MAP(
		w0 => "00000000",
		w1 => int_xorLMaskRMask,
		w2 => int_lMaskOut,
		w3 => int_rMaskOut,
		s0 => selDisplayA,
		s1 => selDisplayB,
		f => int_displayMuxOutput
	);
	
	displayReg : eightBitShiftRegisterStructural
	PORT MAP(
			i_resetBar => '0',
			i_load => loadDisplay,
			i_shiftLeft => '0',
			i_shiftRight => '0',
			i_clock => clock,
			i_Value => int_displayMuxOutput,
			o_Value => o_display
	);
	
	lMaskReg : eightBitShiftRegisterStructural
	PORT MAP(
			i_resetBar => '0',
			i_load => loadLMask,
			i_shiftLeft => lMaskShiftLeft,
			i_shiftRight => '0',
			i_clock => clock,
			i_Value => "00000001",
			o_Value => int_lMaskOut
	);
	
	rMaskReg : eightBitShiftRegisterStructural
	PORT MAP(
			i_resetBar => '0',
			i_load => loadRMask,
			i_shiftLeft => '0',
			i_shiftRight => rMaskShiftRight,
			i_clock => clock,
			i_Value => "10000000",
			o_Value => int_rMaskOut
	);
end rtl;