library ieee;
use ieee.std_logic_1164.all;

entity uPC is
	port(
		LOAD : in std_logic;
		CPuPC  : in std_logic;
		E   : in std_logic;
		CLR  : in std_logic;
		D    : in std_logic_vector(15 downto 0);
		Q    : out std_logic_vector(15 downto 0)
	);
end entity uPC;


architecture rtl of uPC is
	
	COMPONENT f74161
	PORT
	(
		CLRN		:	 IN STD_LOGIC;
		LDN		:	 IN STD_LOGIC;
		D		:	 IN STD_LOGIC;
		C		:	 IN STD_LOGIC;
		B		:	 IN STD_LOGIC;
		ENP		:	 IN STD_LOGIC;
		A		:	 IN STD_LOGIC;
		ENT		:	 IN STD_LOGIC;
		CLK		:	 IN STD_LOGIC;
		RCO		:	 OUT STD_LOGIC;
		QD		:	 OUT STD_LOGIC;
		QC		:	 OUT STD_LOGIC;
		QB		:	 OUT STD_LOGIC;
		QA		:	 OUT STD_LOGIC
	);
END COMPONENT;
	
	signal rco_wire : std_logic_vector(2 downto 0);
	signal useless: std_logic;
	
begin

	counter0 : f74161 port map(CLR, LOAD, D(3), D(2), D(1), E, D(0), E, CPuPC, rco_wire(0), Q(3), Q(2), Q(1), Q(0));
	counter1 : f74161 port map(CLR, LOAD, D(7), D(6), D(5), rco_wire(0), D(4), rco_wire(0), CPuPC, rco_wire(1), Q(7), Q(6), Q(5), Q(4));
	counter2 : f74161 port map(CLR, LOAD, D(11), D(10), D(9), rco_wire(1), D(8), rco_wire(1), CPuPC, rco_wire(2), Q(11), Q(10), Q(9), Q(8));
	counter3 : f74161 port map(CLR, LOAD, D(15), D(14), D(13), rco_wire(2), D(12), rco_wire(2), CPuPC, useless, Q(15), Q(14), Q(13), Q(12));
	
	
end rtl;
