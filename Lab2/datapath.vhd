LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY datapath IS 
	PORT (
		 i_clock, i_reset, i_loadSign, i_clearSign, i_incrementCounter, i_clearCounter, i_loadDividend, i_leftShiftDividend, i_addSubDividend, i_clearRemainder, i_leftShiftRemainder, i_loadRemainder,i_loadDivisor, i_addSubDivisor, i_loadQuotient, i_rightShiftQuotient, i_rightShiftInQuotient, i_clearQuotient : IN STD_LOGIC;
		 i_a, i_b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 o_countgt, o_remaindergteq, o_sign : OUT STD_LOGIC;
		 o_result : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);

END datapath;

ARCHITECTURE structural OF datapath IS
COMPONENT fourBitShiftRegisterStructural
    PORT(
        i_resetBar, i_load, i_shiftLeft, i_shiftRight, i_leftShiftIn , i_rightShiftIn : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_Value : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        o_Value : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END COMPONENT;
COMPONENT fourbitaddsub
    PORT(
        i_x, i_y : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        i_sub : IN STD_LOGIC;
        o_s : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        o_carry : OUT STD_LOGIC
    );
END COMPONENT;
COMPONENT fourbitcomparator
    PORT (
        i_a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        i_b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        o_gt, o_lt, o_eq : OUT STD_LOGIC
    );
END COMPONENT;
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
COMPONENT fourbitcounter
    PORT (
			i_inc, i_clock, i_reset : IN STD_LOGIC;
			o_count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	 );
END COMPONENT;
SIGNAL int_signInput, int_signOutput : STD_LOGIC;
SIGNAL int_dividendIn, int_dividendOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL int_divisorIn, int_divisorOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL int_quotientIn, int_quotientOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL int_remainderIn, int_remainderOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL int_remainderGTdivisor, int_remainderEQdivisor : STD_LOGIC;
SIGNAL int_counterOut : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL int_countGT : STD_LOGIC;
BEGIN
    int_signInput <= '1' xor int_signOutput;
    sign: dflipflop
    PORT MAP(
        i_d => int_signInput,
        i_clock => i_clock,
        i_enable => i_loadSign,
		  i_async_set => '0',
        i_async_reset => i_clearSign or i_reset,
        o_q => int_signOutput
    );

    dividendAdder: fourbitaddsub
    PORT MAP(
        i_x => "0000",
        i_y => i_a,
        i_sub => i_addSubDividend,
        o_s => int_dividendIn
    );

    dividend: fourBitShiftRegisterStructural
    PORT MAP(
        i_resetBar => i_reset,
        i_load => i_loadDividend,
        i_shiftLeft => i_leftShiftDividend,
		  i_leftShiftIn => '0',
		  i_shiftRight => '0',
		  i_rightShiftIn => '0',
        i_clock => i_clock,
        i_Value => int_dividendIn,
        o_Value => int_dividendOut
    );

    divisorAdder: fourbitaddsub
    PORT MAP(
        i_x => "0000",
        i_y => i_b,
        i_sub => i_addSubDivisor,
        o_s => int_divisorIn
    );

    divisor: fourBitShiftRegisterStructural
    PORT MAP(
        i_resetBar => i_reset,
        i_load => i_loadDivisor,
		  i_shiftLeft => '0',
		  i_leftShiftIn => '0',
		  i_shiftRight => '0',
		  i_rightShiftIn => '0',
        i_clock => i_clock,
        i_Value => int_divisorIn,
        o_Value => int_divisorOut
    );

    quotientAdder: fourbitaddsub
    PORT MAP(
        i_x => "0000",
        i_y => int_quotientOut,
        i_sub => '1',
        o_s => int_quotientIn
    );

    quotient: fourBitShiftRegisterStructural
    PORT MAP(
        i_resetBar => i_reset or i_clearQuotient,
        i_load => i_loadQuotient,
        i_clock => i_clock,
        i_rightShiftIn => i_rightShiftInQuotient,
        i_shiftRight => i_rightShiftQuotient,
		  i_leftShiftIn => '0',
		  i_shiftLeft => '0',
        i_Value => int_quotientIn,
        o_Value => int_quotientOut
    );

    remainderAdder: fourbitaddsub
    PORT MAP(
        i_x => int_remainderOut,
        i_y => int_divisorOut,
        i_sub => '1',
        o_s => int_quotientIn
    );

    remainder: fourBitShiftRegisterStructural
    PORT MAP(
        i_resetBar => i_reset or i_clearRemainder,
        i_load => i_loadRemainder,
        i_clock => i_clock,
        i_leftShiftIn => int_dividendOut(3),
        i_shiftLeft => i_leftShiftRemainder,
		  i_rightShiftIn => '0',
		  i_shiftRight => '0',
        i_Value => int_remainderIn,
        o_Value => int_remainderOut
    );

    remainderComparator: fourbitcomparator
    PORT MAP(
        i_a => int_remainderOut,
        i_b => int_divisorOut,
        o_gt => int_remainderGTdivisor, 
        o_eq => int_remainderEQdivisor
    );
	 
	 counter: fourbitcounter
	 PORT MAP(
		i_inc => i_incrementCounter,
		i_clock => i_clock, 
		i_reset => i_reset,
		o_count => int_counterOut
	 );
	 
	 counterComparator: fourbitcomparator
	 PORT MAP(
        i_a => int_counterOut,
        i_b => "0011",
        o_gt => int_countGT
    );
	 o_result <= int_quotientOut;
	 o_countgt <= int_countGT;
	 o_remaindergteq <= int_remainderEQdivisor or int_remainderGTdivisor;
	 o_sign <= int_signOutput;
	 
	 

END structural;