library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity exp2 is
	port(
		P : in std_logic;
		rst_clk : in std_logic;
		
		CLR_PC : in std_logic;
		
		ram_data : out std_logic_vector(7 downto 0);		
		ram_q : out std_logic_vector(7 downto 0);

		pc_q : out std_logic_vector(7 downto 0);
		mar_q : out std_logic_vector(7 downto 0);
		select_q : out std_logic_vector(7 downto 0);
		
		
		upc_q : out std_logic_vector(7 downto 0);
		cmd : out std_logic_vector(23 downto 0)
		

	);
end exp2;

architecture rtl of exp2 is

	
	component CM IS
	port
	(
		address		: in std_logic_vector (7 downto 0);
		clock		: in std_logic  := '1';
		q		: out std_logic_vector (23 downto 0)
	);
	end component;


	component uIR is
	port(
		CPuIR : in std_logic;
		
		D : in std_logic_vector(23 downto 0);
		
		Q : out std_logic_vector(23 downto 0)
	);
	end component;
	
	
	component R is
	port (
		CPR : in std_logic;
		D : in std_logic_vector(7 downto 0);
		
		Q : out std_logic_vector(7 downto 0)
	);
	end component;

	component MAR is
	port(
		CPMAR : in std_logic;
		D : in std_logic_vector(7 downto 0);
		Q : out std_logic_vector(7 downto 0)
	);
	end component;
			
		
	component Counter is
	port(
--		LOAD : in std_logic;
		CPuPC  : in std_logic;
--		E   : in std_logic;
		CLR  : in std_logic;
		D    : in std_logic_vector(7 downto 0);
		Q    : out std_logic_vector(7 downto 0)
	);
	end component;
	
	component selector_2_8bit is
	port (
		XPC : in std_logic;
		XMAR : in std_logic;
		
		D_MAR : in std_logic_vector(7 downto 0);
		D_PC : in std_logic_vector(7 downto 0);
		
		Q : out std_logic_vector(7 downto 0)
	);
	end component;
	
	component ram is
	port
	(
		address		: in std_logic_vector (7 downto 0);
		clock		: in std_logic  := '1';
		data		: in std_logic_vector (7 downto 0);
		rden		: in std_logic := '1';
		wren		: in std_logic ;
		q		: out std_logic_vector (7 downto 0)
	);
	end component;
	
	
	signal cmAddr : std_logic_vector(7 downto 0);
	signal cmData, command: std_logic_vector(23 downto 0);
	
	signal CPPC, XPC, XMAR, CPMAR, CPR, WR, RD: std_logic;
	
	signal ramAddr, ramIn, ramOut: std_logic_vector(7 downto 0);
	
	signal select_mar, select_pc : std_logic_vector(7 downto 0);

	signal clk : unsigned(1 downto 0);
	
begin

	p_clk_divider: process(rst_clk, P)
	begin
	  if(rst_clk='1') then
		 clk   <= (others=>'0');
	  elsif(rising_edge(P)) then
		 clk   <= clk + 1;
	  end if;
	end process p_clk_divider;

	
	

	uPC_entity : Counter port map(clk(1), '1', (others => '0'), cmaddr);
	
	crom_entity : CM port map(cmaddr, clk(1), cmData);
	
	uir_entity : uIR port map(clk(1), cmData, command);
	
	RD <= command(0) after 10 ns;
	WR <= command(1) after 10 ns;
	
	CPMAR <= (command(2) and not (clk(1))) after 10 ns;
	CPR <= (command(3) and not (clk(1))) after 10 ns;
	CPPC <= (command(4) and not (clk(1))) after 10 ns;
	
	XMAR <= command(5) after 10 ns;
	XPC <= command(6) after 10 ns;
	
	
	r_entity : R port map(CPR, ramOut, ramIn);
	mar_entity : MAR port map(CPMAR, ramOut, select_mar);
	PC_entity : Counter port map(CPPC, not CLR_PC, (others => '0'), select_pc);
	
	selector_entity : selector_2_8bit port map(XPC, XMAR, select_mar, select_pc, ramAddr);
	
	select_q <= ramAddr;
	pc_q <= select_pc;
	mar_q <= select_mar;
	ram_q <= ramOut;
	ram_data <= ramIn;
	upc_q <= cmaddr;
	cmd <= command;
	
	ram_entity : ram port map(ramAddr'delayed(10 ns), clk(0), ramIn, RD, WR, ramOut);
	

end rtl;