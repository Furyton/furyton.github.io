library ieee;
use ieee.std_logic_1164.all;

entity ALU is
	port(
		CPR0: in std_logic;
		CPR1: in std_logic;
		CPR2: in std_logic;
		
		A : in std_logic_vector(7 downto 0);
		B : in std_logic_vector(7 downto 0);
		C0 : in std_logic;
		
		M : in std_logic;
		S : in std_logic_vector(3 downto 0);
		
		Q : out std_logic_vector(7 downto 0)
	);
end entity ALU;

architecture rtl of ALU is
	component full_adder_8bit is
	port(
		A : in std_logic_vector(7 downto 0);
		B : in std_logic_vector(7 downto 0);
		C0: in std_logic;
		
		M : in std_logic;
		S : in std_logic_vector(3 downto 0);
		
		F : out std_logic_vector(7 downto 0)
	);
	end component;
	
	component register_8bit is
	port(
		D : in std_logic_vector(7 downto 0);
		clk : in std_logic;
		Q : out std_logic_vector(7 downto 0)
	);
	end component;
	
	signal R0_wire, R1_wire, R2_wire : std_logic_vector(7 downto 0);
	
begin

	add : full_adder_8bit port map(R0_wire, R1_wire, C0, M, S, R2_wire);
	R0 : register_8bit port map(A, CPR0, R0_wire);
	R1 : register_8bit port map(B, CPR1, R1_wire);
	R2 : register_8bit port map(R2_wire, CPR2, Q);

end rtl;