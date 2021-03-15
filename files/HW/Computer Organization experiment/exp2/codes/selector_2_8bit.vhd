library ieee;
use ieee.std_logic_1164.all;

entity selector_2_8bit is
	port (
		XPC : in std_logic;
		XMAR : in std_logic;
		
		D_MAR : in std_logic_vector(7 downto 0);
		D_PC : in std_logic_vector(7 downto 0);
		
		Q : out std_logic_vector(7 downto 0)
	);
end selector_2_8bit;


architecture rtl of selector_2_8bit is

begin
	
	Q <= (D_MAR and (Q'Range => XMAR)) or (D_PC and (Q'Range => XPC));

end rtl;