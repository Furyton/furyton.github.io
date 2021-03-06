library ieee;
use ieee.std_logic_1164.all;

entity uIR_32bit is
	port(
		D : in std_logic_vector(31 downto 0);
		CPuIR : in std_logic;
		Q : out std_logic_vector(31 downto 0)
	);
end entity uIR_32bit;

architecture rtl of uIR_32bit is

begin
	process (CPuIR)
	begin
		if rising_edge(CPuIR) then
			Q <= D;
		end if;
	end process;
end rtl;