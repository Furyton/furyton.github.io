library ieee;
use ieee.std_logic_1164.all;

entity Counter is
	port(
--		LOAD : in std_logic;
		CPuPC  : in std_logic;
--		E   : in std_logic;
		CLR  : in std_logic;
		D    : in std_logic_vector(7 downto 0);
		Q    : out std_logic_vector(7 downto 0)
	);
end entity Counter;


architecture rtl of Counter is
	
	component f74161
	port
	(
		CLRN		:	 in std_logic;
		LDN		:	 in std_logic;
		D		:	 in std_logic;
		C		:	 in std_logic;
		B		:	 in std_logic;
		A		:	 in std_logic;
		
		ENP		:	 in std_logic;
		ENT		:	 in std_logic;
		
		CLK		:	 in std_logic;
		RCO		:	 out std_logic;
		QD		:	 out std_logic;
		QC		:	 out std_logic;
		QB		:	 out std_logic;
		QA		:	 out std_logic
	);
	end component;
	
	signal rco_wire : std_logic;
	-- signal rco_wire : std_logic_vector(2 downto 0)
	
begin

	counter0 : f74161 port map(CLR, '1', D(3), D(2), D(1), D(0), '1', '1', CPuPC, rco_wire, Q(3), Q(2), Q(1), Q(0));
	counter1 : f74161 port map(CLR, '1', D(7), D(6), D(5), D(4), rco_wire, rco_wire, CPuPC, open, Q(7), Q(6), Q(5), Q(4));
	
	-- counter0 : f74161 port map(CLR, LOAD, D(3), D(2), D(1), D(0), E, E, CPuPC, rco_wire(0), Q(3), Q(2), Q(1), Q(0));
	-- counter1 : f74161 port map(CLR, LOAD, D(7), D(6), D(5), D(4), rco_wire(0), rco_wire(0), CPuPC, rco_wire(1), Q(7), Q(6), Q(5), Q(4));
	-- counter2 : f74161 port map(CLR, LOAD, D(11), D(10), D(9), D(8), rco_wire(1), rco_wire(1), CPuPC, rco_wire(2), Q(11), Q(10), Q(9), Q(8));
	-- counter3 : f74161 port map(CLR, LOAD, D(15), D(14), D(13), D(12), rco_wire(2), rco_wire(2), CPuPC, open, Q(15), Q(14), Q(13), Q(12));
	
	
end rtl;
