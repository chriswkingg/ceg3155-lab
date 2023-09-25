entity and2 is
	port(a, b, : in bit; y : out bit;)
end and2;

architecture structural of and2 is
begin
	y <= a AND b;
end structural