-- MIT license
-- 
-- Copyright (C) 2015 by XESS Corp.
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.



--**************************************************************************************************
-- This module tests the StickIt! main board by outputing the following on LED displays
-- connected to the WING sockets:
--   WING1: "-shipout"
--   WING2: "-righton"
--   WING3: "-correct"
--**************************************************************************************************

library IEEE, XESS;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use XESS.LedDigitsPckg.all;
--use XESS.CommonPckg.all;

entity LedDigitsPmods is
  generic (
    FREQ_G : real := 12.0
    );
  port(
    clk_i : in  std_logic;
    s1_o   : out std_logic_vector(7 downto 0);
    s2_o   : out std_logic_vector(7 downto 0);
    s3_o   : out std_logic_vector(7 downto 0)
    );
end entity;

architecture arch of LedDigitsPmods is
  signal ascii1_r : std_logic_vector(55 downto 0) := "01011011010011100100010010011010000100111110101011010100"; -- -shipout
  signal ascii2_r : std_logic_vector(55 downto 0) := "01011011010010100100110001111001000101010010011111001110"; -- -righton
  signal ascii3_r : std_logic_vector(55 downto 0) := "01011011000011100111110100101010010100010110000111010100"; -- -correct
begin
  
  process(clk_i) is
    variable cntr_r      : integer := 0;
    variable asciiChar_v : unsigned(6 downto 0) := "0000000";
  begin
    if rising_edge(clk_i) then
      if cntr_r = 0 then
        cntr_r      := integer(FREQ_G / 2.0 * 1_000_000.0);
        ascii1_r     <= ascii1_r(48 downto 0) & ascii1_r(55 downto 49);
        ascii2_r     <= ascii2_r(48 downto 0) & ascii2_r(55 downto 49);
        ascii3_r     <= ascii3_r(48 downto 0) & ascii3_r(55 downto 49);
      else
        cntr_r := cntr_r - 1;
      end if;
    end if;
  end process;

  u1 : LedDigitsDisplay
    generic map(
      FREQ_G => FREQ_G
      )
    port map (
      clk_i        => clk_i,
      ledDigit1_i  => CharToLedDigit(ascii1_r(6 downto 0)),
      ledDigit2_i  => CharToLedDigit(ascii1_r(13 downto 7)),
      ledDigit3_i  => CharToLedDigit(ascii1_r(20 downto 14)),
      ledDigit4_i  => CharToLedDigit(ascii1_r(27 downto 21)),
      ledDigit5_i  => CharToLedDigit(ascii1_r(34 downto 28)),
      ledDigit6_i  => CharToLedDigit(ascii1_r(41 downto 35)),
      ledDigit7_i  => CharToLedDigit(ascii1_r(48 downto 42)),
      ledDigit8_i  => CharToLedDigit(ascii1_r(55 downto 49)),
      ledDrivers_o => s1_o
      );

  u2 : LedDigitsDisplay
    generic map(
      FREQ_G => FREQ_G
      )
    port map (
      clk_i        => clk_i,
      ledDigit1_i  => CharToLedDigit(ascii2_r(6 downto 0)),
      ledDigit2_i  => CharToLedDigit(ascii2_r(13 downto 7)),
      ledDigit3_i  => CharToLedDigit(ascii2_r(20 downto 14)),
      ledDigit4_i  => CharToLedDigit(ascii2_r(27 downto 21)),
      ledDigit5_i  => CharToLedDigit(ascii2_r(34 downto 28)),
      ledDigit6_i  => CharToLedDigit(ascii2_r(41 downto 35)),
      ledDigit7_i  => CharToLedDigit(ascii2_r(48 downto 42)),
      ledDigit8_i  => CharToLedDigit(ascii2_r(55 downto 49)),
      ledDrivers_o => s2_o
      );

  u3 : LedDigitsDisplay
    generic map(
      FREQ_G => FREQ_G
      )
    port map (
      clk_i        => clk_i,
      ledDigit1_i  => CharToLedDigit(ascii3_r(6 downto 0)),
      ledDigit2_i  => CharToLedDigit(ascii3_r(13 downto 7)),
      ledDigit3_i  => CharToLedDigit(ascii3_r(20 downto 14)),
      ledDigit4_i  => CharToLedDigit(ascii3_r(27 downto 21)),
      ledDigit5_i  => CharToLedDigit(ascii3_r(34 downto 28)),
      ledDigit6_i  => CharToLedDigit(ascii3_r(41 downto 35)),
      ledDigit7_i  => CharToLedDigit(ascii3_r(48 downto 42)),
      ledDigit8_i  => CharToLedDigit(ascii3_r(55 downto 49)),
      ledDrivers_o => s3_o
      );

end architecture;
