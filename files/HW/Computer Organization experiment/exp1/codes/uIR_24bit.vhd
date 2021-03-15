library ieee;
use ieee.std_logic_1164.all;

entity uIR_24bit is
	port(
		CPuIR: in std_logic;
		D : in std_logic_vector(23 downto 0);
		RESET: in std_logic;
		Q : out std_logic_vector(23 downto 0)
	);
end entity uIR_24bit;

architecture rtl of uIR_24bit is
begin
	process (RESET, CPuIR)
	begin
		if RESET = '1' then
			Q <= (others => '0');
		elsif rising_edge(CPuIR) then
			Q <= D;
		end if;
	end process;
end rtl;
		