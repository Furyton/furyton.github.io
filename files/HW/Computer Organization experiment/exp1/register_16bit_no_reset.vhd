library ieee;
use ieee.std_logic_1164.all;

entity register_16bit_no_reset is
	port(
		D : in std_logic_vector(15 downto 0);
		clk : in std_logic;
		Q : out std_logic_vector(15 downto 0)
	);
end entity register_16bit_no_reset;


architecture rtl of register_16bit_no_reset is

begin
	process (clk)
	begin
		if rising_edge(clk) then
			Q <= D;
		end if;
	end process;
end rtl;