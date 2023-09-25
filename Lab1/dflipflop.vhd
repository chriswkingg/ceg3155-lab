entity dflipflop is
	port(clk, rst, set, d : in bit; q, qb : out bit);
end dflipflop;

architecture structural of dflipflop is
SIGNAL db, r, s qi, qbi: bit;
begin
	db <= not 
end structural
