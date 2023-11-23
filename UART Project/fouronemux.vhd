LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY fouronemux IS
PORT(
	w0 : IN STD_LOGIC;
	w1 : IN STD_LOGIC;
	w2 : IN STD_LOGIC;
	w3 : IN STD_LOGIC;
	s0 : IN STD_LOGIC;
	s1 : IN STD_LOGIC;
	f : OUT STD_LOGIC);
END fouronemux;

architecture rtl of fouronemux is
SIGNAL int_a, int_b : STD_LOGIC; 
COMPONENT twoonemux
	PORT(
		w0 : IN STD_LOGIC;
		w1 : IN STD_LOGIC;
		s : IN STD_LOGIC;
		f : OUT STD_LOGIC);
	END COMPONENT;
begin
	muxA: twoonemux
	PORT MAP(
		w0 => w0,
		w1 => w1,
		s => s0,
		f => int_a
	);
	muxB: twoonemux
	PORT MAP(
		w0 => w2,
		w1 => w3,
		s => s0,
		f => int_b
	);
	muxC: twoonemux
	PORT MAP(
		w0 => int_a,
		w1 => int_b,
		s => s1,
		f => f
	);
end rtl;