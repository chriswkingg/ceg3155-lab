entity not1 is
	port(a : in bit; y : out bit;)
end not1;

architecture structural of not1 is
begin
	y <= NOT a;
end structural