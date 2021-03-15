library ieee;
use ieee.std_logic_1164.all;

entity MAR is
	port(
		CPMAR : in std_logic;
		D : in std_logic_vector(7 downto 0);
		Q : out std_logic_vector(7 downto 0)
	);
end entity MAR;

architecture rtl of MAR is
begin

	process (CPMAR)
	begin
	
		if rising_edge(CPMAR) then
			Q <= D;
		end if;
	
	end process;

end rtl;