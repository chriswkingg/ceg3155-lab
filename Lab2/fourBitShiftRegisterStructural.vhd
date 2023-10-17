LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fourBitShiftRegister IS
    PORT (
        i_resetBar, i_load, i_shiftLeft, i_shiftRight, i_leftShiftIn : IN STD_LOGIC;
        i_clock : IN STD_LOGIC;
        i_Value : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        o_Value : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END fourBitShiftRegister;

ARCHITECTURE structural OF fourBitShiftRegister IS
    COMPONENT dflipflop
        PORT (
            i_d : IN STD_LOGIC;
            i_clock : IN STD_LOGIC;
            i_enable : IN STD_LOGIC;
            o_q, o_qBar : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT fouronemux
        PORT (
            w0, w1, w2, w3 : IN STD_LOGIC;
            s0, s1 : IN STD_LOGIC;
            f : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL d_in : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL q_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
	 SIGNAL int_muxSelect0, int_muxSelect1 : STD_LOGIC;
BEGIN
    int_muxSelect0 <=  i_shiftLeft and not i_shiftRight;
	int_muxSelect1 <= i_load;
	 
	
    dff0: dflipflop
    PORT MAP (
        i_d => d_in(0),
        i_clock => i_clock,
        i_enable => i_load or i_shiftLeft or i_shiftRight,
        o_q => q_out(0),
        o_qBar => open
    );

    mux0: fouronemux
    PORT MAP (
        w0 => q_out(1),
        w1 => i_leftShiftIn,
        w2 => i_Value(0),
        w3 => '0',
        s0 => int_muxSelect0,
        s1 => int_muxSelect1,
        f => d_in(0)
    );

    dff1: dflipflop
    PORT MAP (
        i_d => d_in(1),
        i_clock => i_clock,
        i_enable => i_load or i_shiftLeft or i_shiftRight,
        o_q => q_out(1),
        o_qBar => open
    );

    mux1: fouronemux
    PORT MAP (
        w0 => q_out(2),
        w1 => q_out(0),
        w2 => i_value(1),
        w3 => '0',
        s0 => int_muxSelect0,
        s1 => int_muxSelect1,
        f => d_in(1)
    );

    dff2: dflipflop
    PORT MAP (
        i_d => d_in(2),
        i_clock => i_clock,
        i_enable => i_load or i_shiftLeft or i_shiftRight,
        o_q => q_out(2),
        o_qBar => open
    );

    mux2: fouronemux
    PORT MAP (
        w0 => q_out(3),
        w1 => q_out(1),
        w2 => i_value(2),
        w3 => '0',
        s0 => int_muxSelect0,
        s1 => int_muxSelect1,
        f => d_in(2)
    );

    dff3: dflipflop
    PORT MAP (
        i_d => d_in(3),
        i_clock => i_clock,
        i_enable => i_load or i_shiftLeft or i_shiftRight,
        o_q => q_out(3),
        o_qBar => open
    );

    mux3: fouronemux
    PORT MAP (
        w0 => q_out(4),
        w1 => q_out(2),
        w2 => i_value(3),
        w3 => '0',
        s0 => int_muxSelect0,
        s1 => int_muxSelect1,
        f => d_in(3)
    );
    o_Value <= q_out;
END structural;
