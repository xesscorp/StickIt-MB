--**********************************************************************
-- Copyright (c) 2015 by XESS Corp <http://www.xess.com>.
-- All rights reserved.
--
-- This library is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 3.0 of the License, or (at your option) any later version.
-- 
-- This library is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- Lesser General Public License for more details.
-- 
-- You should have received a copy of the GNU Lesser General Public
-- License along with this library.  If not, see 
-- <http://www.gnu.org/licenses/>.
--**********************************************************************


library IEEE, XESS;
use IEEE.STD_LOGIC_1164.ALL;
use XESS.CommonPckg.all;
use XESS.ClkGenPckg.all;
use work.XessBoardPckg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gpio_cntr is
    Port ( clk_i : in  STD_LOGIC;
           cntr_o : out  STD_LOGIC_VECTOR (25 downto 0));
end gpio_cntr;

architecture Behavioral of gpio_cntr is
  signal cntr_r : unsigned(cntr_o'range);
  signal clk_s : std_logic;
begin

uclk: clkgen generic map(CLK_MUL_G=>25, CLK_DIV_G=>3) port map(i=>clk_i, o=>clk_s);

process(clk_s)
begin
  if rising_edge(clk_s) then
    cntr_r <= cntr_r + 1;
  end if;
end process;

cntr_o <= std_logic_vector(cntr_r);

end Behavioral;

