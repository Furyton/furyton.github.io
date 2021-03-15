library ieee;
use ieee.std_logic_1164.all;

entity exp1 is 
	port(
		P : in std_logic;
		Q : out std_logic_vector(7 downto 0);
		test_addr: out std_logic_vector(7 downto 0);
		test_cmd : out std_logic_vector(23 downto 0);
		test_ir : out std_logic_vector(23 downto 0)
	);
end entity exp1;

architecture rtl of exp1 is

	component ALU is
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
	end component;
	
	component CM is
	PORT
	(
		address		: in std_logic_vector (7 DOWNTO 0);
		clock		: in std_logic  := '1';
		q		: out std_logic_vector (23 DOWNTO 0)
	);
	end component CM;
	
	component uIR_24bit is
	port(
		CPuIR: in std_logic;
		D : in std_logic_vector(23 downto 0);
		RESET: in std_logic;
		Q : out std_logic_vector(23 downto 0)
	);
	end component;

	component uPC is
	port(
		LOAD : in std_logic;
		CPuPC  : in std_logic;
		E   : in std_logic;
		CLR  : in std_logic;
		D    : in std_logic_vector(7 downto 0);
		Q    : out std_logic_vector(7 downto 0)
	);
	end component;
	

	signal addr : std_logic_vector(7 downto 0);
	signal data, ir: std_logic_vector(23 downto 0);
--	signal number : std_logic_vector(7 downto 0);
	
begin

--	number <= ir(23)&ir(22)&ir(21)&ir(20)&ir(19)&ir(18)&ir(17)&ir(16);
	test_addr <= addr after 5 ns;
	test_cmd <= data after 5 ns;
	test_ir <= ir after 5 ns;
	upc_entity : uPC port map('1', P, '1', '1', (others => '0'), addr);
	cm_entity : CM port map(addr, P, data);
	uir_entity : uir_24bit port map(P, data, '0', ir);
--	alu_entity : ALU port map(ir(7) and (not P), ir(6) and (not P), ir(5) and (not P), number, number, ir(8), ir(4), ir(3)&ir(2)&ir(1)&ir(0), Q);
	alu_entity : ALU port map(ir(7) and (not P), ir(6) and (not P), ir(5) and (not P), ir(23)&ir(22)&ir(21)&ir(20)&ir(19)&ir(18)&ir(17)&ir(16), 
			ir(23)&ir(22)&ir(21)&ir(20)&ir(19)&ir(18)&ir(17)&ir(16), ir(8), ir(4), ir(3)&ir(2)&ir(1)&ir(0), Q);
	
	
end rtl;