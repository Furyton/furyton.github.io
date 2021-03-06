library ieee;
use ieee.std_logic_1164.all;


entity add_16bit is
	port(
		A : in std_logic_vector(15 downto 0);
		B : in std_logic_vector(15 downto 0);
		M : in std_logic;
		C0: in std_logic;
		S : in std_logic_vector(3 downto 0);
		F : out std_logic_vector(15 downto 0)
		
	);
end add_16bit;

architecture rtl of add_16bit is
	component weak_adder
	port
	(
		a		:	 in std_logic_vector(3 DOWNTO 0);
		b		:	 in std_logic_vector(3 DOWNTO 0);
		cn		:	 in std_logic;
		M		:	 in std_logic;
		s		:	 in std_logic_vector(3 DOWNTO 0);
		GN		:	 out std_logic;
		PN		:	 out std_logic;
		F0N		:	 out std_logic;
		F1N		:	 out std_logic;
		F2N		:	 out std_logic;
		F3N		:	 out std_logic
	);
	end component;
	
	component \74182\
	port
	(
		PN3		:	 in std_logic;
		GN3		:	 in std_logic;
		PN2		:	 in std_logic;
		GN2		:	 in std_logic;
		PN1		:	 in std_logic;
		GN1		:	 in std_logic;
		PN0		:	 in std_logic;
		GN0		:	 in std_logic;
		CI		:	 in std_logic;
		GN		:	 out std_logic;
		PN		:	 out std_logic;
		CZ		:	 out std_logic;
		CY		:	 out std_logic;
		CX		:	 out std_logic
	);
	end component;
	
	signal gn_wire, pn_wire: std_logic_vector(3 downto 0);
	signal cx_wire, cy_wire, cz_wire: std_logic;
	signal useless : std_logic;
	
	
begin
	adder0 : weak_adder port map (A(3)&A(2)&A(1)&A(0), B(3)&B(2)&B(1)&B(0), C0, M, S, gn_wire(0), pn_wire(0), F(0), F(1), F(2), F(3));
	
	adder1 : weak_adder port map (A(7)&A(6)&A(5)&A(4), B(7)&B(6)&B(5)&B(4), cx_wire, M, S, gn_wire(1), pn_wire(1), F(4), F(5), F(6), F(7));

	adder2 : weak_adder port map (A(11)&A(10)&A(9)&A(8), B(11)&B(10)&B(9)&B(8), cy_wire, M, S, gn_wire(2), pn_wire(2), F(8), F(9), F(10), F(11));
	
	adder3 : weak_adder port map (A(15)&A(14)&A(13)&A(12), B(15)&B(14)&B(13)&B(12), cz_wire, M, S, gn_wire(3), pn_wire(3), F(12), F(13), F(14), F(15));
	
	carry : \74182\ port map (pn_wire(3), gn_wire(3), pn_wire(2), gn_wire(2), pn_wire(1), gn_wire(1), pn_wire(0), gn_wire(0), C0, useless, useless, cz_wire, cy_wire, cx_wire);
	
	
end rtl;

	