library ieee;
use ieee.std_logic_1164.all;

entity register_8bit is
	port(
		D : in std_logic_vector(7 downto 0);
		clk : in std_logic;
		Q : out std_logic_vector(7 downto 0)
	);
end entity register_8bit;


architecture rtl of register_8bit is

begin
	process (clk)
	begin
		if rising_edge(clk) then
			Q <= D after 2 ns;
		end if;
	end process;
end rtl;