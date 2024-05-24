-- Inverter Entity
library ieee;
use ieee.std_logic_1164.all;
entity BitInverter is
    Port ( 
        input_bits : in  std_logic_vector(15 downto 0);
        output_bits : out std_logic_vector(15 downto 0)
    );
end BitInverter;

-- Inverter Architecture
architecture Behavioral of BitInverter is
begin
    process(input_bits)
    begin
        -- Invert all bits
        for i in 0 to 15 loop
            output_bits(i) <= not input_bits(i);
        end loop;
    end process;
end Behavioral;
