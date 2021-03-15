library ieee;
use ieee.std_logic_1164.all;

entity R is
	port (
		CPR : in std_logic;
		D : in std_logic_vector(7 downto 0);
		
		Q : out std_logic_vector(7 downto 0)
	);
end entity R;


architecture rtl of R is
begin

	process(CPR)
	begin
	
		if rising_edge(CPR) then
			Q <= D;
		end if;
	
	end process;

end rtl;