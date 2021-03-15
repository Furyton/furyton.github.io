library ieee;
use ieee.std_logic_1164.all;

entity full_adder_8bit is
	port(
		A : in std_logic_vector(7 downto 0);
		B : in std_logic_vector(7 downto 0);
		C0: in std_logic;
		
		M : in std_logic;
		S : in std_logic_vector(3 downto 0);
		
		F : out std_logic_vector(7 downto 0)
		
	);
end entity full_adder_8bit;

architecture rtl of full_adder_8bit is
	component \74181\
	port
	(
		S3		:	 in std_logic;
		S2		:	 in std_logic;
		S1		:	 in std_logic;
		S0		:	 in std_logic;
		
		B3N		:	 in std_logic;
		B2N		:	 in std_logic;
		B1N		:	 in std_logic;
		B0N		:	 in std_logic;
		
		A3N		:	 in std_logic;
		A2N		:	 in std_logic;
		A1N		:	 in std_logic;
		A0N		:	 in std_logic;
		
		CN		:	 in std_logic;
		M		:	 in std_logic;
		
		F0N		:	 out std_logic;
		F1N		:	 out std_logic;
		F2N		:	 out std_logic;
		F3N		:	 out std_logic;
		
		PN		:	 out std_logic;
		GN		:	 out std_logic;
		
		
		CN4		:	 out std_logic;
		AEQB		:	 out std_logic
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
	
	signal gn_wire, pn_wire: std_logic_vector(1 downto 0);
	signal cx_wire: std_logic;
	
	
begin
	adder0 : \74181\ port map(S(3), S(2), S(1), S(0),  B(3), B(2), B(1), B(0), 
								A(3), A(2), A(1), A(0),  C0, M, F(0), F(1), F(2), F(3), pn_wire(0), gn_wire(0), open, open);
								
	adder1 : \74181\ port map(S(3), S(2), S(1), S(0),  B(7), B(6), B(5), B(4), 
								A(7), A(6), A(5), A(4),  cx_wire, M, F(4), F(5), F(6), F(7), pn_wire(1), gn_wire(1), open, open);
								
	
	carry  : \74182\ port map('1', '1', '1', '1', pn_wire(1), gn_wire(1), pn_wire(0), gn_wire(0), C0, open, open, open, open, cx_wire);
end rtl;
	