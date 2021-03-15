library ieee;
use ieee.std_logic_1164.all;


entity uIR is
	port(
		CPuIR : in std_logic;
		
		D : in std_logic_vector(23 downto 0);
		
		Q : out std_logic_vector(23 downto 0)
	);
end uIR;



architecture rtl of uIR is

begin

	process (CPuIR)
	begin
		if rising_edge(CPuIR) then
			Q <= D;
		end if;
	end process;
	

end rtl;