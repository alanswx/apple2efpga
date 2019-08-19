-- Copyright (C) 1991-2007 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.
-- Quartus II 7.2 Build 151 09/26/2007
---START_PACKAGE_HEADER-----------------------------------------------------
--
-- Package Name    :  ALTERA_COMMON_CONVERSION
--
-- Description     :  Common conversion functions
--
---END_PACKAGE_HEADER--------------------------------------------------------

-- BEGINING OF PRIMITIVE

Library ieee;
use ieee.std_logic_1164.all;
entity LCELL is
    port(
        a_in                           :  in    std_logic;
        a_out                          :  out   std_logic);
end LCELL;
architecture BEHAVIOR of LCELL is
begin
    a_out <= a_in;
end BEHAVIOR;

-- BEGINING OF PACKAGE
Library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

-- PACKAGE DECLARATION
package ALTERA_COMMON_CONVERSION is
-- FUNCTION DECLARATION
    function INT_TO_STR_RAM (value : in integer) return string;
    function INT_TO_STR_ARITH (value : in integer) return string;
    function HEX_STR_TO_INT (str : in string) return integer;
    function BIN_STR_TO_INT (str : in string) return integer;
    function OCT_STR_TO_INT (str : in string) return integer;
    function INT_STR_TO_INT (str : in string) return integer;
    function ALPHA_TOLOWER (given_string : in string) return string;
    procedure SHRINK_LINE (str_line : inout line; pos : in integer);
end ALTERA_COMMON_CONVERSION;

package body ALTERA_COMMON_CONVERSION is
-- This function converts an integer to a string
function INT_TO_STR_RAM (value : in integer) return string is
variable ivalue : integer := 0;
variable index  : integer := 0;
variable digit : integer := 0;
variable line_no: string(8 downto 1) := "        ";
begin
    ivalue := value;
    index := 1;

    while (ivalue > 0) loop
        digit := ivalue MOD 10;
        ivalue := ivalue/10;
        case digit is
            when 0 => line_no(index) := '0';
            when 1 => line_no(index) := '1';
            when 2 => line_no(index) := '2';
            when 3 => line_no(index) := '3';
            when 4 => line_no(index) := '4';
            when 5 => line_no(index) := '5';
            when 6 => line_no(index) := '6';
            when 7 => line_no(index) := '7';
            when 8 => line_no(index) := '8';
            when 9 => line_no(index) := '9';
            when others =>
                ASSERT FALSE
                REPORT "Illegal number!"
                SEVERITY ERROR;
        end case;
        index := index + 1;
    end loop;

    return line_no;
end INT_TO_STR_RAM;

function INT_TO_STR_ARITH (value : in integer) return string is
    variable ivalue : integer := 0;
    variable index : integer := 0;
    variable digit : integer := 0;
    variable temp: string(10 downto 1) := "0000000000";
begin
    ivalue := value;
    index := 1;

    while (ivalue > 0) loop
        digit := ivalue mod 10;
        ivalue := ivalue/10;

        case digit is
            when 0 => temp(index) := '0';
            when 1 => temp(index) := '1';
            when 2 => temp(index) := '2';
            when 3 => temp(index) := '3';
            when 4 => temp(index) := '4';
            when 5 => temp(index) := '5';
            when 6 => temp(index) := '6';
            when 7 => temp(index) := '7';
            when 8 => temp(index) := '8';
            when 9 => temp(index) := '9';
            when others =>
                ASSERT FALSE
                REPORT "Illegal number!"
                SEVERITY ERROR;
        end case;
        index := index + 1;
    end loop;

    if value < 0 then
        return '-'& temp(index downto 1);
    else
        return temp(index downto 1);
    end if;
end INT_TO_STR_ARITH;

-- This function converts a hexadecimal number to an integer
function HEX_STR_TO_INT (str : in string) return integer is
variable len : integer := str'length;
variable ivalue : integer := 0;
variable digit : integer := 0;
begin
    for i in len downto 1 loop
        case str(i) is
            when '0' => digit := 0;
            when '1' => digit := 1;
            when '2' => digit := 2;
            when '3' => digit := 3;
            when '4' => digit := 4;
            when '5' => digit := 5;
            when '6' => digit := 6;
            when '7' => digit := 7;
            when '8' => digit := 8;
            when '9' => digit := 9;
            when 'A' => digit := 10;
            when 'a' => digit := 10;
            when 'B' => digit := 11;
            when 'b' => digit := 11;
            when 'C' => digit := 12;
            when 'c' => digit := 12;
            when 'D' => digit := 13;
            when 'd' => digit := 13;
            when 'E' => digit := 14;
            when 'e' => digit := 14;
            when 'F' => digit := 15;
            when 'f' => digit := 15;
            when others =>
                ASSERT FALSE
                REPORT "Illegal hex character "&  str(i) & "! "
                SEVERITY ERROR;
        end case;
        ivalue := ivalue * 16 + digit;
    end loop;
    return ivalue;
end HEX_STR_TO_INT;

-- This function converts a binary number to an integer
function BIN_STR_TO_INT (str : in string) return integer is
variable len : integer := str'length;
variable ivalue : integer := 0;
variable digit : integer := 0;
begin
    for i in len downto 1 loop
        case str(i) is
            when '0' => digit := 0;
            when '1' => digit := 1;
            when others =>
                ASSERT FALSE
                REPORT "Illegal bin character "&  str(i) & "! "
                SEVERITY ERROR;
        end case;
        ivalue := ivalue * 2 + digit;
    end loop;
    return ivalue;
end BIN_STR_TO_INT;

-- This function converts a octadecimal number to an integer
function OCT_STR_TO_INT (str : in string) return integer is
variable len : integer := str'length;
variable ivalue : integer := 0;
variable digit : integer := 0;
begin
    for i in len downto 1 loop
        case str(i) is
            when '0' => digit := 0;
            when '1' => digit := 1;
            when '2' => digit := 2;
            when '3' => digit := 3;
            when '4' => digit := 4;
            when '5' => digit := 5;
            when '6' => digit := 6;
            when '7' => digit := 7;
            when others =>
                ASSERT FALSE
                REPORT "Illegal octadecimal character "&  str(i) & "! "
                SEVERITY ERROR;
        end case;
        ivalue := ivalue * 8 + digit;
    end loop;
    return ivalue;
end OCT_STR_TO_INT;

-- This function converts a integer string to an integer
function INT_STR_TO_INT (str : in string) return integer is
variable len : integer := str'length;
variable newdigit : integer := 0;
variable sign : integer := 1;
variable digit : integer := 0;
begin
    for i in 1 to len loop
        case str(i) is
            when '-' =>
                if i = 1 then
                    sign := -1;
                else
                    ASSERT FALSE
                    REPORT "Illegal Character "&  str(i) & "i n string parameter! "
                    SEVERITY ERROR;
                end if;
            when '0' =>
                digit := 0;
            when '1' =>
                digit := 1;
            when '2' =>
                digit := 2;
            when '3' =>
                digit := 3;
            when '4' =>
                digit := 4;
            when '5' =>
                digit := 5;
            when '6' =>
                digit := 6;
            when '7' =>
                digit := 7;
            when '8' =>
                digit := 8;
            when '9' =>
                digit := 9;
            when others =>
                ASSERT FALSE
                REPORT "Illegal Character "&  str(i) & "in string parameter! "
                SEVERITY ERROR;
        end case;
        newdigit := newdigit * 10 + digit;
    end loop;

    return (sign*newdigit);
end;

-- converts uppercase parameter values (e.g. "AUTO") to lowercase ("auto")
function ALPHA_TOLOWER (given_string : in string) return string is
    -- VARIABLE DECLARATION
    variable result_string : string(given_string'low to given_string'high);

begin
    for i in given_string'low to given_string'high loop
        case given_string(i) is
            when 'A' => result_string(i) := 'a';
            when 'B' => result_string(i) := 'b';
            when 'C' => result_string(i) := 'c';
            when 'D' => result_string(i) := 'd';
            when 'E' => result_string(i) := 'e';
            when 'F' => result_string(i) := 'f';
            when 'G' => result_string(i) := 'g';
            when 'H' => result_string(i) := 'h';
            when 'I' => result_string(i) := 'i';
            when 'J' => result_string(i) := 'j';
            when 'K' => result_string(i) := 'k';
            when 'L' => result_string(i) := 'l';
            when 'M' => result_string(i) := 'm';
            when 'N' => result_string(i) := 'n';
            when 'O' => result_string(i) := 'o';
            when 'P' => result_string(i) := 'p';
            when 'Q' => result_string(i) := 'q';
            when 'R' => result_string(i) := 'r';
            when 'S' => result_string(i) := 's';
            when 'T' => result_string(i) := 't';
            when 'U' => result_string(i) := 'u';
            when 'V' => result_string(i) := 'v';
            when 'W' => result_string(i) := 'w';
            when 'X' => result_string(i) := 'x';
            when 'Y' => result_string(i) := 'y';
            when 'Z' => result_string(i) := 'z';
            when others => result_string(i) := given_string(i);
        end case;
    end loop;

    return (result_string(given_string'low to given_string'high));
end;

-- This procedure "cuts" the str_line into desired length
procedure SHRINK_LINE (str_line : inout line; pos : in integer) is
subtype nstring is string(1 to pos);
variable str : nstring;
begin
    if (pos >= 1) then
        read(str_line, str);
    end if;
end;
end ALTERA_COMMON_CONVERSION;
-- END OF PACKAGE

---START_PACKAGE_HEADER-----------------------------------------------------
--
-- Package Name    :  ALTERA_MF_HINT_EVALUATION
--
-- Description     :  Common function to grep the value of altera specific parameters
--                    within the lpm_hint parameter.
--
---END_PACKAGE_HEADER--------------------------------------------------------

-- BEGINING OF PACKAGE
Library ieee;
use ieee.std_logic_1164.all;

-- PACKAGE DECLARATION
package ALTERA_MF_HINT_EVALUATION is
-- FUNCTION DECLARATION
    function get_parameter_value( constant  given_string : string;
                                            compare_param_name : string) return string;
end ALTERA_MF_HINT_EVALUATION;

package body ALTERA_MF_HINT_EVALUATION is

-- This function will search through the string (given string) to look for a match for the
-- a given parameter(compare_param_name). It will return the value for the given parameter.
function get_parameter_value( constant  given_string : string; 
                                        compare_param_name : string) return string is
    variable param_name_left_index   : integer := given_string'length;
    variable param_name_right_index  : integer := given_string'length;
    variable param_value_left_index  : integer := given_string'length;
    variable param_value_right_index : integer := given_string'length;
    variable set_right_index         : boolean := true;
    variable extract_param_value     : boolean := true; 
    variable extract_param_name      : boolean := false;  
    variable param_found             : boolean := false;
    
begin

    -- checking every character of the given_string from right to left.
    for i in given_string'length downto 1 loop
        if (given_string(i) /= ' ') then
            if (given_string(i) = '=') then
                extract_param_value := false;
                extract_param_name  := true;
                set_right_index := true;
            elsif (given_string(i) = ',') then
                extract_param_value := true;
                extract_param_name  := false;
                set_right_index := true;
                
                if (compare_param_name = given_string(param_name_left_index to param_name_right_index)) then
                        param_found := true;  -- the compare_param_name have been found in the given_string
                        exit;
                end if;            
            else            
                if (extract_param_value = true) then                
                    if (set_right_index = true) then                    
                        param_value_right_index := i;
                        set_right_index := false;    
                    end if;
                    param_value_left_index := i;
                elsif (extract_param_name = true) then                
                    if (set_right_index = true) then                    
                        param_name_right_index := i;
                        set_right_index := false;    
                    end if;
                    param_name_left_index := i;    
                end if;
            end if;
        end if;
    end loop;

    -- for the case whether parameter's name is the left most part of the given_string
    if (extract_param_name = true) then
        if(compare_param_name = given_string(param_name_left_index to param_name_right_index)) then        
            param_found := true;                
        end if;
    end if;

    if(param_found = true) then             
        return given_string(param_value_left_index to param_value_right_index);    
    else    
        return "";   -- return empty string if parameter not found
    end if;
    
end get_parameter_value;
end ALTERA_MF_HINT_EVALUATION;
-- END OF PACKAGE 

---START_PACKAGE_HEADER-----------------------------------------------------
--
-- Package Name    :  ALTERA_DEVICE_FAMILIES
--
-- Description     :  Common Altera device families comparison
--
---END_PACKAGE_HEADER--------------------------------------------------------

-- BEGINING OF PACKAGES
Library ieee;
use ieee.std_logic_1164.all;

-- PACKAGE DECLARATION
package ALTERA_DEVICE_FAMILIES is
-- FUNCTION DECLARATION
    function IS_FAMILY_ACEX1K (device : in string) return boolean;
    function IS_FAMILY_APEX20K (device : in string) return boolean;
    function IS_FAMILY_APEX20KC (device : in string) return boolean;
    function IS_FAMILY_APEX20KE (device : in string) return boolean;
    function IS_FAMILY_APEXII (device : in string) return boolean;
    function IS_FAMILY_EXCALIBUR_ARM (device : in string) return boolean;
    function IS_FAMILY_FLEX10KE (device : in string) return boolean;
    function IS_FAMILY_MERCURY (device : in string) return boolean;
    function IS_FAMILY_STRATIX (device : in string) return boolean;
    function IS_FAMILY_STRATIXGX (device : in string) return boolean;
    function IS_FAMILY_CYCLONE (device : in string) return boolean;
    function IS_FAMILY_MAXII (device : in string) return boolean;
    function IS_FAMILY_HARDCOPYSTRATIX (device : in string) return boolean;
    function IS_FAMILY_STRATIXII (device : in string) return boolean;
    function IS_FAMILY_STRATIXIIGX (device : in string) return boolean;
    function IS_FAMILY_ARRIAGX (device : in string) return boolean;
    function IS_FAMILY_CYCLONEII (device : in string) return boolean;
    function IS_FAMILY_HARDCOPYII (device : in string) return boolean;
    function IS_FAMILY_STRATIXIII (device : in string) return boolean;
    function IS_FAMILY_CYCLONEIII (device : in string) return boolean;
    function FEATURE_FAMILY_FLEX10KE (device : in string) return boolean;
    function FEATURE_FAMILY_APEX20K (device : in string) return boolean;
    function FEATURE_FAMILY_APEX20KE (device : in string) return boolean;
    function FEATURE_FAMILY_APEXII (device : in string) return boolean;
    function FEATURE_FAMILY_MERCURY (device : in string) return boolean;
    function FEATURE_FAMILY_STRATIXGX (device : in string) return boolean;
    function FEATURE_FAMILY_CYCLONE (device : in string) return boolean;
    function FEATURE_FAMILY_STRATIXIIGX (device : in string) return boolean;
    function FEATURE_FAMILY_STRATIXIII (device : in string) return boolean;
    function FEATURE_FAMILY_STRATIXII (device : in string) return boolean;
    function FEATURE_FAMILY_CYCLONEIII (device : in string) return boolean;
    function FEATURE_FAMILY_STRATIX_HC (device : in string) return boolean;
    function FEATURE_FAMILY_HARDCOPYII (device : in string) return boolean;
    function FEATURE_FAMILY_STRATIX (device : in string) return boolean;
    function FEATURE_FAMILY_MAXII (device : in string) return boolean;
    function FEATURE_FAMILY_CYCLONEII (device : in string) return boolean;
    function FEATURE_FAMILY_BASE_STRATIXII (device : in string) return boolean;
    function FEATURE_FAMILY_BASE_STRATIX (device : in string) return boolean;
    function FEATURE_FAMILY_BASE_CYCLONEII (device : in string) return boolean;
    function FEATURE_FAMILY_BASE_CYCLONE (device : in string) return boolean;
    function FEATURE_FAMILY_BASE_CYCLONEIII (device : in string) return boolean;
    function FEATURE_FAMILY_BASE_STRATIXIII (device : in string) return boolean;
    function FEATURE_FAMILY_STRATIX_NONGX (device : in string) return boolean;
    function FEATURE_FAMILY_HAS_MEGARAM (device : in string) return boolean;
    function FEATURE_FAMILY_HAS_M512 (device : in string) return boolean;
    function FEATURE_FAMILY_HAS_LUTRAM (device : in string) return boolean;
    function FEATURE_FAMILY_HAS_STRATIXII_STYLE_RAM (device : in string) return boolean;
    function FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM (device : in string) return boolean;
    function FEATURE_FAMILY_HAS_STRATIX_STYLE_PLL (device : in string) return boolean;
    function FEATURE_FAMILY_HAS_STRATIXII_STYLE_PLL (device : in string) return boolean;
    function FEATURE_FAMILY_HAS_FLEXIBLE_LVDS (device : in string) return boolean;
    function FEATURE_FAMILY_HAS_INVERTED_OUTPUT_DDIO (device : in string) return boolean;
    function FEATURE_FAMILY_USES_STRATIXIII_PLL (device : in string) return boolean;
    function IS_VALID_FAMILY (device: in string) return boolean;
end ALTERA_DEVICE_FAMILIES;

package body ALTERA_DEVICE_FAMILIES is


function IS_FAMILY_ACEX1K (device : in string) return boolean is
variable is_acex1k : boolean := false;
begin
    if ((device = "ACEX1K") or (device = "acex1k") or (device = "ACEX 1K") or (device = "acex 1k"))
    then
        is_acex1k := true;
    end if;
    return is_acex1k;
end IS_FAMILY_ACEX1K;

function IS_FAMILY_APEX20K (device : in string) return boolean is
variable is_apex20k : boolean := false;
begin
    if ((device = "APEX20K") or (device = "apex20k") or (device = "APEX 20K") or (device = "apex 20k") or (device = "RAPHAEL") or (device = "raphael"))
    then
        is_apex20k := true;
    end if;
    return is_apex20k;
end IS_FAMILY_APEX20K;

function IS_FAMILY_APEX20KC (device : in string) return boolean is
variable is_apex20kc : boolean := false;
begin
    if ((device = "APEX20KC") or (device = "apex20kc") or (device = "APEX 20KC") or (device = "apex 20kc"))
    then
        is_apex20kc := true;
    end if;
    return is_apex20kc;
end IS_FAMILY_APEX20KC;

function IS_FAMILY_APEX20KE (device : in string) return boolean is
variable is_apex20ke : boolean := false;
begin
    if ((device = "APEX20KE") or (device = "apex20ke") or (device = "APEX 20KE") or (device = "apex 20ke"))
    then
        is_apex20ke := true;
    end if;
    return is_apex20ke;
end IS_FAMILY_APEX20KE;

function IS_FAMILY_APEXII (device : in string) return boolean is
variable is_apexii : boolean := false;
begin
    if ((device = "APEX II") or (device = "apex ii") or (device = "APEXII") or (device = "apexii") or (device = "APEX 20KF") or (device = "apex 20kf") or (device = "APEX20KF") or (device = "apex20kf"))
    then
        is_apexii := true;
    end if;
    return is_apexii;
end IS_FAMILY_APEXII;

function IS_FAMILY_EXCALIBUR_ARM (device : in string) return boolean is
variable is_excalibur_arm : boolean := false;
begin
    if ((device = "EXCALIBUR_ARM") or (device = "excalibur_arm") or (device = "Excalibur ARM") or (device = "EXCALIBUR ARM") or (device = "excalibur arm") or (device = "ARM-BASED EXCALIBUR") or (device = "arm-based excalibur") or (device = "ARM_BASED_EXCALIBUR") or (device = "arm_based_excalibur"))
    then
        is_excalibur_arm := true;
    end if;
    return is_excalibur_arm;
end IS_FAMILY_EXCALIBUR_ARM;

function IS_FAMILY_FLEX10KE (device : in string) return boolean is
variable is_flex10ke : boolean := false;
begin
    if ((device = "FLEX10KE") or (device = "flex10ke") or (device = "FLEX 10KE") or (device = "flex 10ke"))
    then
        is_flex10ke := true;
    end if;
    return is_flex10ke;
end IS_FAMILY_FLEX10KE;

function IS_FAMILY_MERCURY (device : in string) return boolean is
variable is_mercury : boolean := false;
begin
    if ((device = "Mercury") or (device = "MERCURY") or (device = "mercury") or (device = "DALI") or (device = "dali"))
    then
        is_mercury := true;
    end if;
    return is_mercury;
end IS_FAMILY_MERCURY;

function IS_FAMILY_STRATIX (device : in string) return boolean is
variable is_stratix : boolean := false;
begin
    if ((device = "Stratix") or (device = "STRATIX") or (device = "stratix") or (device = "Yeager") or (device = "YEAGER") or (device = "yeager"))
    then
        is_stratix := true;
    end if;
    return is_stratix;
end IS_FAMILY_STRATIX;

function IS_FAMILY_STRATIXGX (device : in string) return boolean is
variable is_stratixgx : boolean := false;
begin
    if ((device = "Stratix GX") or (device = "STRATIX GX") or (device = "stratix gx") or (device = "Stratix-GX") or (device = "STRATIX-GX") or (device = "stratix-gx") or (device = "StratixGX") or (device = "STRATIXGX") or (device = "stratixgx") or (device = "Aurora") or (device = "AURORA") or (device = "aurora"))
    then
        is_stratixgx := true;
    end if;
    return is_stratixgx;
end IS_FAMILY_STRATIXGX;

function IS_FAMILY_CYCLONE (device : in string) return boolean is
variable is_cyclone : boolean := false;
begin
    if ((device = "Cyclone") or (device = "CYCLONE") or (device = "cyclone") or (device = "ACEX2K") or (device = "acex2k") or (device = "ACEX 2K") or (device = "acex 2k") or (device = "Tornado") or (device = "TORNADO") or (device = "tornado"))
    then
        is_cyclone := true;
    end if;
    return is_cyclone;
end IS_FAMILY_CYCLONE;

function IS_FAMILY_MAXII (device : in string) return boolean is
variable is_maxii : boolean := false;
begin
    if ((device = "MAX II") or (device = "max ii") or (device = "MAXII") or (device = "maxii") or (device = "Tsunami") or (device = "TSUNAMI") or (device = "tsunami"))
    then
        is_maxii := true;
    end if;
    return is_maxii;
end IS_FAMILY_MAXII;

function IS_FAMILY_HARDCOPYSTRATIX (device : in string) return boolean is
variable is_hardcopystratix : boolean := false;
begin
    if ((device = "HardCopy Stratix") or (device = "HARDCOPY STRATIX") or (device = "hardcopy stratix") or (device = "Stratix HC") or (device = "STRATIX HC") or (device = "stratix hc") or (device = "StratixHC") or (device = "STRATIXHC") or (device = "stratixhc") or (device = "HardcopyStratix") or (device = "HARDCOPYSTRATIX") or (device = "hardcopystratix"))
    then
        is_hardcopystratix := true;
    end if;
    return is_hardcopystratix;
end IS_FAMILY_HARDCOPYSTRATIX;

function IS_FAMILY_STRATIXII (device : in string) return boolean is
variable is_stratixii : boolean := false;
begin
    if ((device = "Stratix II") or (device = "STRATIX II") or (device = "stratix ii") or (device = "StratixII") or (device = "STRATIXII") or (device = "stratixii") or (device = "Armstrong") or (device = "ARMSTRONG") or (device = "armstrong"))
    then
        is_stratixii := true;
    end if;
    return is_stratixii;
end IS_FAMILY_STRATIXII;

function IS_FAMILY_STRATIXIIGX (device : in string) return boolean is
variable is_stratixiigx : boolean := false;
begin
    if ((device = "Stratix II GX") or (device = "STRATIX II GX") or (device = "stratix ii gx") or (device = "StratixIIGX") or (device = "STRATIXIIGX") or (device = "stratixiigx"))
    then
        is_stratixiigx := true;
    end if;
    return is_stratixiigx;
end IS_FAMILY_STRATIXIIGX;

function IS_FAMILY_ARRIAGX (device : in string) return boolean is
variable is_arriagx : boolean := false;
begin
    if ((device = "Arria GX") or (device = "ARRIA GX") or (device = "arria gx") or (device = "ArriaGX") or (device = "ARRIAGX") or (device = "arriagx") or (device = "Stratix II GX Lite") or (device = "STRATIX II GX LITE") or (device = "stratix ii gx lite") or (device = "StratixIIGXLite") or (device = "STRATIXIIGXLITE") or (device = "stratixiigxlite"))
    then
        is_arriagx := true;
    end if;
    return is_arriagx;
end IS_FAMILY_ARRIAGX;

function IS_FAMILY_CYCLONEII (device : in string) return boolean is
variable is_cycloneii : boolean := false;
begin
    if ((device = "Cyclone II") or (device = "CYCLONE II") or (device = "cyclone ii") or (device = "Cycloneii") or (device = "CYCLONEII") or (device = "cycloneii") or (device = "Magellan") or (device = "MAGELLAN") or (device = "magellan"))
    then
        is_cycloneii := true;
    end if;
    return is_cycloneii;
end IS_FAMILY_CYCLONEII;

function IS_FAMILY_HARDCOPYII (device : in string) return boolean is
variable is_hardcopyii : boolean := false;
begin
    if ((device = "HardCopy II") or (device = "HARDCOPY II") or (device = "hardcopy ii") or (device = "HardCopyII") or (device = "HARDCOPYII") or (device = "hardcopyii") or (device = "Fusion") or (device = "FUSION") or (device = "fusion"))
    then
        is_hardcopyii := true;
    end if;
    return is_hardcopyii;
end IS_FAMILY_HARDCOPYII;

function IS_FAMILY_STRATIXIII (device : in string) return boolean is
variable is_stratixiii : boolean := false;
begin
    if ((device = "Stratix III") or (device = "STRATIX III") or (device = "stratix iii") or (device = "StratixIII") or (device = "STRATIXIII") or (device = "stratixiii") or (device = "Titan") or (device = "TITAN") or (device = "titan") or (device = "SIII") or (device = "siii"))
    then
        is_stratixiii := true;
    end if;
    return is_stratixiii;
end IS_FAMILY_STRATIXIII;

function IS_FAMILY_CYCLONEIII (device : in string) return boolean is
variable is_cycloneiii : boolean := false;
begin
    if ((device = "Cyclone III") or (device = "CYCLONE III") or (device = "cyclone iii") or (device = "CycloneIII") or (device = "CYCLONEIII") or (device = "cycloneiii") or (device = "Barracuda") or (device = "BARRACUDA") or (device = "barracuda") or (device = "Cuda") or (device = "CUDA") or (device = "cuda") or (device = "CIII") or (device = "ciii"))
    then
        is_cycloneiii := true;
    end if;
    return is_cycloneiii;
end IS_FAMILY_CYCLONEIII;

function FEATURE_FAMILY_FLEX10KE (device : in string) return boolean is
variable var_family_flex10ke : boolean := false;
begin
    if (IS_FAMILY_FLEX10KE(device) or IS_FAMILY_ACEX1K(device) )
    then
        var_family_flex10ke := true;
    end if;
    return var_family_flex10ke;
end FEATURE_FAMILY_FLEX10KE;


function FEATURE_FAMILY_APEX20K (device : in string) return boolean is
variable var_family_apex20k : boolean := false;
begin
    if (IS_FAMILY_APEX20K(device) )
    then
        var_family_apex20k := true;
    end if;
    return var_family_apex20k;
end FEATURE_FAMILY_APEX20K;


function FEATURE_FAMILY_APEX20KE (device : in string) return boolean is
variable var_family_apex20ke : boolean := false;
begin
    if (IS_FAMILY_APEX20KE(device) or IS_FAMILY_EXCALIBUR_ARM(device) or IS_FAMILY_APEX20KC(device) )
    then
        var_family_apex20ke := true;
    end if;
    return var_family_apex20ke;
end FEATURE_FAMILY_APEX20KE;


function FEATURE_FAMILY_APEXII (device : in string) return boolean is
variable var_family_apexii : boolean := false;
begin
    if (IS_FAMILY_APEXII(device) or IS_FAMILY_APEXII(device) )
    then
        var_family_apexii := true;
    end if;
    return var_family_apexii;
end FEATURE_FAMILY_APEXII;


function FEATURE_FAMILY_MERCURY (device : in string) return boolean is
variable var_family_mercury : boolean := false;
begin
    if (IS_FAMILY_MERCURY(device) )
    then
        var_family_mercury := true;
    end if;
    return var_family_mercury;
end FEATURE_FAMILY_MERCURY;


function FEATURE_FAMILY_STRATIXGX (device : in string) return boolean is
variable var_family_stratixgx : boolean := false;
begin
    if (IS_FAMILY_STRATIXGX(device) )
    then
        var_family_stratixgx := true;
    end if;
    return var_family_stratixgx;
end FEATURE_FAMILY_STRATIXGX;


function FEATURE_FAMILY_CYCLONE (device : in string) return boolean is
variable var_family_cyclone : boolean := false;
begin
    if (IS_FAMILY_CYCLONE(device) )
    then
        var_family_cyclone := true;
    end if;
    return var_family_cyclone;
end FEATURE_FAMILY_CYCLONE;


function FEATURE_FAMILY_STRATIXIIGX (device : in string) return boolean is
variable var_family_stratixiigx : boolean := false;
begin
    if (IS_FAMILY_STRATIXIIGX(device) or IS_FAMILY_ARRIAGX(device) )
    then
        var_family_stratixiigx := true;
    end if;
    return var_family_stratixiigx;
end FEATURE_FAMILY_STRATIXIIGX;


function FEATURE_FAMILY_STRATIXIII (device : in string) return boolean is
variable var_family_stratixiii : boolean := false;
begin
    if (IS_FAMILY_STRATIXIII(device) )
    then
        var_family_stratixiii := true;
    end if;
    return var_family_stratixiii;
end FEATURE_FAMILY_STRATIXIII;


function FEATURE_FAMILY_STRATIXII (device : in string) return boolean is
variable var_family_stratixii : boolean := false;
begin
    if (IS_FAMILY_STRATIXII(device) or IS_FAMILY_HARDCOPYII(device) or FEATURE_FAMILY_STRATIXIIGX(device) or FEATURE_FAMILY_STRATIXIII(device) )
    then
        var_family_stratixii := true;
    end if;
    return var_family_stratixii;
end FEATURE_FAMILY_STRATIXII;


function FEATURE_FAMILY_CYCLONEIII (device : in string) return boolean is
variable var_family_cycloneiii : boolean := false;
begin
    if (IS_FAMILY_CYCLONEIII(device) )
    then
        var_family_cycloneiii := true;
    end if;
    return var_family_cycloneiii;
end FEATURE_FAMILY_CYCLONEIII;


function FEATURE_FAMILY_STRATIX_HC (device : in string) return boolean is
variable var_family_stratix_hc : boolean := false;
begin
    if (IS_FAMILY_HARDCOPYSTRATIX(device) )
    then
        var_family_stratix_hc := true;
    end if;
    return var_family_stratix_hc;
end FEATURE_FAMILY_STRATIX_HC;


function FEATURE_FAMILY_HARDCOPYII (device : in string) return boolean is
variable var_family_hardcopyii : boolean := false;
begin
    if (IS_FAMILY_HARDCOPYII(device) )
    then
        var_family_hardcopyii := true;
    end if;
    return var_family_hardcopyii;
end FEATURE_FAMILY_HARDCOPYII;


function FEATURE_FAMILY_STRATIX (device : in string) return boolean is
variable var_family_stratix : boolean := false;
begin
    if (IS_FAMILY_STRATIX(device) or FEATURE_FAMILY_STRATIX_HC(device) or FEATURE_FAMILY_STRATIXGX(device) or FEATURE_FAMILY_CYCLONE(device) or FEATURE_FAMILY_STRATIXII(device) or FEATURE_FAMILY_MAXII(device) or FEATURE_FAMILY_CYCLONEII(device) )
    then
        var_family_stratix := true;
    end if;
    return var_family_stratix;
end FEATURE_FAMILY_STRATIX;


function FEATURE_FAMILY_MAXII (device : in string) return boolean is
variable var_family_maxii : boolean := false;
begin
    if (IS_FAMILY_MAXII(device) )
    then
        var_family_maxii := true;
    end if;
    return var_family_maxii;
end FEATURE_FAMILY_MAXII;


function FEATURE_FAMILY_CYCLONEII (device : in string) return boolean is
variable var_family_cycloneii : boolean := false;
begin
    if (IS_FAMILY_CYCLONEII(device) or IS_FAMILY_CYCLONEIII(device) )
    then
        var_family_cycloneii := true;
    end if;
    return var_family_cycloneii;
end FEATURE_FAMILY_CYCLONEII;


function FEATURE_FAMILY_BASE_STRATIXII (device : in string) return boolean is
variable var_family_base_stratixii : boolean := false;
begin
    if (IS_FAMILY_STRATIXII(device) or IS_FAMILY_HARDCOPYII(device) or FEATURE_FAMILY_STRATIXIIGX(device) )
    then
        var_family_base_stratixii := true;
    end if;
    return var_family_base_stratixii;
end FEATURE_FAMILY_BASE_STRATIXII;


function FEATURE_FAMILY_BASE_STRATIX (device : in string) return boolean is
variable var_family_base_stratix : boolean := false;
begin
    if (IS_FAMILY_STRATIX(device) or IS_FAMILY_STRATIXGX(device) or IS_FAMILY_HARDCOPYSTRATIX(device) )
    then
        var_family_base_stratix := true;
    end if;
    return var_family_base_stratix;
end FEATURE_FAMILY_BASE_STRATIX;


function FEATURE_FAMILY_BASE_CYCLONEII (device : in string) return boolean is
variable var_family_base_cycloneii : boolean := false;
begin
    if (IS_FAMILY_CYCLONEII(device) )
    then
        var_family_base_cycloneii := true;
    end if;
    return var_family_base_cycloneii;
end FEATURE_FAMILY_BASE_CYCLONEII;


function FEATURE_FAMILY_BASE_CYCLONE (device : in string) return boolean is
variable var_family_base_cyclone : boolean := false;
begin
    if (IS_FAMILY_CYCLONE(device) )
    then
        var_family_base_cyclone := true;
    end if;
    return var_family_base_cyclone;
end FEATURE_FAMILY_BASE_CYCLONE;


function FEATURE_FAMILY_BASE_CYCLONEIII (device : in string) return boolean is
variable var_family_base_cycloneiii : boolean := false;
begin
    if (IS_FAMILY_CYCLONEIII(device) )
    then
        var_family_base_cycloneiii := true;
    end if;
    return var_family_base_cycloneiii;
end FEATURE_FAMILY_BASE_CYCLONEIII;


function FEATURE_FAMILY_BASE_STRATIXIII (device : in string) return boolean is
variable var_family_base_stratixiii : boolean := false;
begin
    if (IS_FAMILY_STRATIXIII(device) )
    then
        var_family_base_stratixiii := true;
    end if;
    return var_family_base_stratixiii;
end FEATURE_FAMILY_BASE_STRATIXIII;


function FEATURE_FAMILY_STRATIX_NONGX (device : in string) return boolean is
variable var_family_stratix_nongx : boolean := false;
begin
    if (IS_FAMILY_STRATIX(device) or IS_FAMILY_HARDCOPYSTRATIX(device) )
    then
        var_family_stratix_nongx := true;
    end if;
    return var_family_stratix_nongx;
end FEATURE_FAMILY_STRATIX_NONGX;


function FEATURE_FAMILY_HAS_MEGARAM (device : in string) return boolean is
variable var_family_has_megaram : boolean := false;
begin
    if (IS_FAMILY_STRATIX(device) or FEATURE_FAMILY_STRATIX_HC(device) or IS_FAMILY_STRATIXGX(device) or FEATURE_FAMILY_STRATIXII(device) )
    then
        var_family_has_megaram := true;
    end if;
    return var_family_has_megaram;
end FEATURE_FAMILY_HAS_MEGARAM;


function FEATURE_FAMILY_HAS_M512 (device : in string) return boolean is
variable var_family_has_m512 : boolean := false;
begin
    if (IS_FAMILY_STRATIX(device) or FEATURE_FAMILY_STRATIX_HC(device) or IS_FAMILY_STRATIXGX(device) or IS_FAMILY_STRATIXII(device) or FEATURE_FAMILY_STRATIXIIGX(device) )
    then
        var_family_has_m512 := true;
    end if;
    return var_family_has_m512;
end FEATURE_FAMILY_HAS_M512;


function FEATURE_FAMILY_HAS_LUTRAM (device : in string) return boolean is
variable var_family_has_lutram : boolean := false;
begin
    if (FEATURE_FAMILY_STRATIXIII(device) )
    then
        var_family_has_lutram := true;
    end if;
    return var_family_has_lutram;
end FEATURE_FAMILY_HAS_LUTRAM;


function FEATURE_FAMILY_HAS_STRATIXII_STYLE_RAM (device : in string) return boolean is
variable var_family_has_stratixii_style_ram : boolean := false;
begin
    if (FEATURE_FAMILY_STRATIXII(device) or FEATURE_FAMILY_CYCLONEII(device) )
    then
        var_family_has_stratixii_style_ram := true;
    end if;
    return var_family_has_stratixii_style_ram;
end FEATURE_FAMILY_HAS_STRATIXII_STYLE_RAM;


function FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM (device : in string) return boolean is
variable var_family_has_stratixiii_style_ram : boolean := false;
begin
    if (FEATURE_FAMILY_STRATIXIII(device) or FEATURE_FAMILY_CYCLONEIII(device) )
    then
        var_family_has_stratixiii_style_ram := true;
    end if;
    return var_family_has_stratixiii_style_ram;
end FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM;


function FEATURE_FAMILY_HAS_STRATIX_STYLE_PLL (device : in string) return boolean is
variable var_family_has_stratix_style_pll : boolean := false;
begin
    if (FEATURE_FAMILY_CYCLONE(device) or FEATURE_FAMILY_STRATIX_HC(device) or IS_FAMILY_STRATIX(device) or FEATURE_FAMILY_STRATIXGX(device) )
    then
        var_family_has_stratix_style_pll := true;
    end if;
    return var_family_has_stratix_style_pll;
end FEATURE_FAMILY_HAS_STRATIX_STYLE_PLL;


function FEATURE_FAMILY_HAS_STRATIXII_STYLE_PLL (device : in string) return boolean is
variable var_family_has_stratixii_style_pll : boolean := false;
begin
    if (( ( FEATURE_FAMILY_STRATIXII(device) and NOT FEATURE_FAMILY_STRATIXIII(device)  ) or FEATURE_FAMILY_CYCLONEII(device)  ) and NOT FEATURE_FAMILY_CYCLONEIII(device) )
    then
        var_family_has_stratixii_style_pll := true;
    end if;
    return var_family_has_stratixii_style_pll;
end FEATURE_FAMILY_HAS_STRATIXII_STYLE_PLL;


function FEATURE_FAMILY_HAS_FLEXIBLE_LVDS (device : in string) return boolean is
variable var_family_has_flexible_lvds : boolean := false;
begin
    if (FEATURE_FAMILY_CYCLONE(device) or FEATURE_FAMILY_CYCLONEII(device) )
    then
        var_family_has_flexible_lvds := true;
    end if;
    return var_family_has_flexible_lvds;
end FEATURE_FAMILY_HAS_FLEXIBLE_LVDS;


function FEATURE_FAMILY_HAS_INVERTED_OUTPUT_DDIO (device : in string) return boolean is
variable var_family_has_inverted_output_ddio : boolean := false;
begin
    if (FEATURE_FAMILY_CYCLONEII(device) )
    then
        var_family_has_inverted_output_ddio := true;
    end if;
    return var_family_has_inverted_output_ddio;
end FEATURE_FAMILY_HAS_INVERTED_OUTPUT_DDIO;


function FEATURE_FAMILY_USES_STRATIXIII_PLL (device : in string) return boolean is
variable var_family_uses_stratixiii_pll : boolean := false;
begin
    if (FEATURE_FAMILY_STRATIXIII(device) or FEATURE_FAMILY_CYCLONEIII(device) )
    then
        var_family_uses_stratixiii_pll := true;
    end if;
    return var_family_uses_stratixiii_pll;
end FEATURE_FAMILY_USES_STRATIXIII_PLL;


function IS_VALID_FAMILY (device : in string) return boolean is
variable is_valid : boolean := false;
begin
    if (((device = "ACEX1K") or (device = "acex1k") or (device = "ACEX 1K") or (device = "acex 1k"))
    or ((device = "APEX20K") or (device = "apex20k") or (device = "APEX 20K") or (device = "apex 20k") or (device = "RAPHAEL") or (device = "raphael"))
    or ((device = "APEX20KC") or (device = "apex20kc") or (device = "APEX 20KC") or (device = "apex 20kc"))
    or ((device = "APEX20KE") or (device = "apex20ke") or (device = "APEX 20KE") or (device = "apex 20ke"))
    or ((device = "APEX II") or (device = "apex ii") or (device = "APEXII") or (device = "apexii") or (device = "APEX 20KF") or (device = "apex 20kf") or (device = "APEX20KF") or (device = "apex20kf"))
    or ((device = "EXCALIBUR_ARM") or (device = "excalibur_arm") or (device = "Excalibur ARM") or (device = "EXCALIBUR ARM") or (device = "excalibur arm") or (device = "ARM-BASED EXCALIBUR") or (device = "arm-based excalibur") or (device = "ARM_BASED_EXCALIBUR") or (device = "arm_based_excalibur"))
    or ((device = "FLEX10KE") or (device = "flex10ke") or (device = "FLEX 10KE") or (device = "flex 10ke"))
    or ((device = "FLEX10K") or (device = "flex10k") or (device = "FLEX 10K") or (device = "flex 10k"))
    or ((device = "FLEX10KA") or (device = "flex10ka") or (device = "FLEX 10KA") or (device = "flex 10ka"))
    or ((device = "FLEX6000") or (device = "flex6000") or (device = "FLEX 6000") or (device = "flex 6000") or (device = "FLEX6K") or (device = "flex6k"))
    or ((device = "MAX7000B") or (device = "max7000b") or (device = "MAX 7000B") or (device = "max 7000b"))
    or ((device = "MAX7000AE") or (device = "max7000ae") or (device = "MAX 7000AE") or (device = "max 7000ae"))
    or ((device = "MAX3000A") or (device = "max3000a") or (device = "MAX 3000A") or (device = "max 3000a"))
    or ((device = "MAX7000S") or (device = "max7000s") or (device = "MAX 7000S") or (device = "max 7000s"))
    or ((device = "MAX7000A") or (device = "max7000a") or (device = "MAX 7000A") or (device = "max 7000a"))
    or ((device = "Mercury") or (device = "MERCURY") or (device = "mercury") or (device = "DALI") or (device = "dali"))
    or ((device = "Stratix") or (device = "STRATIX") or (device = "stratix") or (device = "Yeager") or (device = "YEAGER") or (device = "yeager"))
    or ((device = "Stratix GX") or (device = "STRATIX GX") or (device = "stratix gx") or (device = "Stratix-GX") or (device = "STRATIX-GX") or (device = "stratix-gx") or (device = "StratixGX") or (device = "STRATIXGX") or (device = "stratixgx") or (device = "Aurora") or (device = "AURORA") or (device = "aurora"))
    or ((device = "Cyclone") or (device = "CYCLONE") or (device = "cyclone") or (device = "ACEX2K") or (device = "acex2k") or (device = "ACEX 2K") or (device = "acex 2k") or (device = "Tornado") or (device = "TORNADO") or (device = "tornado"))
    or ((device = "MAX II") or (device = "max ii") or (device = "MAXII") or (device = "maxii") or (device = "Tsunami") or (device = "TSUNAMI") or (device = "tsunami"))
    or ((device = "HardCopy Stratix") or (device = "HARDCOPY STRATIX") or (device = "hardcopy stratix") or (device = "Stratix HC") or (device = "STRATIX HC") or (device = "stratix hc") or (device = "StratixHC") or (device = "STRATIXHC") or (device = "stratixhc") or (device = "HardcopyStratix") or (device = "HARDCOPYSTRATIX") or (device = "hardcopystratix"))
    or ((device = "Stratix II") or (device = "STRATIX II") or (device = "stratix ii") or (device = "StratixII") or (device = "STRATIXII") or (device = "stratixii") or (device = "Armstrong") or (device = "ARMSTRONG") or (device = "armstrong"))
    or ((device = "Stratix II GX") or (device = "STRATIX II GX") or (device = "stratix ii gx") or (device = "StratixIIGX") or (device = "STRATIXIIGX") or (device = "stratixiigx"))
    or ((device = "Arria GX") or (device = "ARRIA GX") or (device = "arria gx") or (device = "ArriaGX") or (device = "ARRIAGX") or (device = "arriagx") or (device = "Stratix II GX Lite") or (device = "STRATIX II GX LITE") or (device = "stratix ii gx lite") or (device = "StratixIIGXLite") or (device = "STRATIXIIGXLITE") or (device = "stratixiigxlite"))
    or ((device = "Cyclone II") or (device = "CYCLONE II") or (device = "cyclone ii") or (device = "Cycloneii") or (device = "CYCLONEII") or (device = "cycloneii") or (device = "Magellan") or (device = "MAGELLAN") or (device = "magellan"))
    or ((device = "HardCopy II") or (device = "HARDCOPY II") or (device = "hardcopy ii") or (device = "HardCopyII") or (device = "HARDCOPYII") or (device = "hardcopyii") or (device = "Fusion") or (device = "FUSION") or (device = "fusion"))
    or ((device = "Stratix III") or (device = "STRATIX III") or (device = "stratix iii") or (device = "StratixIII") or (device = "STRATIXIII") or (device = "stratixiii") or (device = "Titan") or (device = "TITAN") or (device = "titan") or (device = "SIII") or (device = "siii"))
    or ((device = "Cyclone III") or (device = "CYCLONE III") or (device = "cyclone iii") or (device = "CycloneIII") or (device = "CYCLONEIII") or (device = "cycloneiii") or (device = "Barracuda") or (device = "BARRACUDA") or (device = "barracuda") or (device = "Cuda") or (device = "CUDA") or (device = "cuda") or (device = "CIII") or (device = "ciii")))
    then
        is_valid := true;
    end if;
    return is_valid;
end IS_VALID_FAMILY;


end ALTERA_DEVICE_FAMILIES;
-- END OF PACKAGE

Library ieee;
use ieee.std_logic_1164.all;

-- START PACKAGE HEADER --------------------------------------------------------
--
-- Package Name : MF_pllpack
--
-- Description  : Used by altpll model to calculate required advanced parameters
--                for PLL simulation. Also has functions to do string->integer,
--                integer->string conversions.
--
-- END PACKAGE HEADER ----------------------------------------------------------

-- PACKAGE DECLARATION
package MF_pllpack is

-- FUNCTION DECLARATION
    function int2str (value : integer)
        return string;
function alt_conv_integer(arg : in std_logic_vector) return integer;


    procedure find_simple_integer_fraction( numerator   : in integer;
                                            denominator : in integer;
                                            max_denom   : in integer;
                                            fraction_num : out integer; 
                                            fraction_div : out integer);

    procedure find_m_and_n_4_manual_phase ( inclock_period : in integer;
                                            vco_phase_shift_step : in integer;
                                            clk0_mult: in integer; clk1_mult: in integer;
                                            clk2_mult: in integer; clk3_mult: in integer;
                                            clk4_mult: in integer; clk5_mult: in integer;
                                            clk6_mult: in integer; clk7_mult: in integer;
                                            clk8_mult: in integer; clk9_mult: in integer;
                                            clk0_div : in integer; clk1_div : in integer;
                                            clk2_div : in integer; clk3_div : in integer;
                                            clk4_div : in integer; clk5_div : in integer;
                                            clk6_div : in integer; clk7_div : in integer;
                                            clk8_div : in integer; clk9_div : in integer;
                                            m : out integer;
                                            n : out integer );

    function gcd (X: integer; Y: integer) return integer;

    function count_digit (X: integer) return integer;

    function scale_num (X: integer; Y: integer) return integer;

    function lcm (A1: integer; A2: integer; A3: integer; A4: integer;
                A5: integer; A6: integer; A7: integer;
                A8: integer; A9: integer; A10: integer; P: integer) return integer;

    function output_counter_value (clk_divide: integer; clk_mult : integer ;
            M: integer; N: integer ) return integer;

    function counter_mode (duty_cycle: integer; output_counter_value: integer) return string;

    function counter_high (output_counter_value: integer := 1; duty_cycle: integer)
                        return integer;

    function counter_low (output_counter_value: integer; duty_cycle: integer)
                        return integer;

    function mintimedelay (t1: integer; t2: integer; t3: integer; t4: integer;
                        t5: integer; t6: integer; t7: integer; t8: integer;
                        t9: integer; t10: integer) return integer;

    function maxnegabs (t1: integer; t2: integer; t3: integer; t4: integer;
                        t5: integer; t6: integer; t7: integer; t8: integer;
                        t9: integer; t10: integer) return integer;

    function counter_time_delay ( clk_time_delay: integer;
                        m_time_delay: integer; n_time_delay: integer)
                        return integer;

    function get_phase_degree (phase_shift: integer; clk_period: integer) return integer;

    function counter_initial (tap_phase: integer; m: integer; n: integer)
                        return integer;

    function counter_ph (tap_phase: integer; m : integer; n: integer) return integer;

    function ph_adjust (tap_phase: integer; ph_base : integer) return integer;

    function translate_string (mode : string) return string;
    
    function str2int (s : string) return integer;
end MF_pllpack;

-- BEGINNING OF PACKAGE
package body MF_pllpack is

-- convert integer to string
function int2str( value : integer ) return string is
variable ivalue : integer := 0;
variable index : integer := 1;
variable digit : integer := 0;
variable temp: string(10 downto 1) := "0000000000";

begin
    ivalue := value;
    index := 1;

    while (ivalue > 0) loop
        digit := ivalue mod 10;
        ivalue := ivalue/10;

        case digit is
            when 0 =>    temp(index) := '0';
            when 1 =>    temp(index) := '1';
            when 2 =>    temp(index) := '2';
            when 3 =>    temp(index) := '3';
            when 4 =>    temp(index) := '4';
            when 5 =>    temp(index) := '5';
            when 6 =>    temp(index) := '6';
            when 7 =>    temp(index) := '7';
            when 8 =>    temp(index) := '8';
            when 9 =>    temp(index) := '9';
            when others =>  ASSERT FALSE
                            REPORT "Illegal number!"
                            SEVERITY ERROR;
        end case;

        index := index + 1;
    end loop;

    if (value < 0) then
        return ('-'& temp(index downto 1));
    else
        return temp(index downto 1);
    end if;

end int2str;

function alt_conv_integer(arg : in std_logic_vector) return integer is
variable result : integer;
begin
    result := 0;
    for i in arg'range loop
        if arg(i) = '1' then
            result := result + 2**i;
        end if;
    end loop;
    return result;
end alt_conv_integer;


-- finds the closest integer fraction of a given pair of numerator and denominator. 
procedure find_simple_integer_fraction( numerator   : in integer;
                                        denominator : in integer;
                                        max_denom   : in integer;
                                        fraction_num : out integer; 
                                        fraction_div : out integer) is
    constant MAX_ITER : integer := 20; 
    type INT_ARRAY is array ((MAX_ITER-1) downto 0) of integer;

    variable quotient_array : INT_ARRAY;
    variable int_loop_iter : integer;
    variable int_quot  : integer;
    variable m_value   : integer;
    variable d_value   : integer;
    variable old_m_value : integer;
    variable swap  : integer;
    variable loop_iter : integer;
    variable num   : integer;
    variable den   : integer;
    variable i_max_iter : integer;

begin      
    loop_iter := 0;

    if (numerator = 0) then
        num := 1;
    else
        num := numerator;
    end if;

    if (denominator = 0) then
        den := 1;
    else
        den := denominator;
    end if;

    i_max_iter := max_iter;
   
    while (loop_iter < i_max_iter) loop
        int_quot := num / den;
        quotient_array(loop_iter) := int_quot;
        num := num - (den*int_quot);
        loop_iter := loop_iter+1;
        
        if ((num = 0) or (max_denom /= -1) or (loop_iter = i_max_iter)) then
            -- calculate the numerator and denominator if there is a restriction on the
            -- max denom value or if the loop is ending
            m_value := 0;
            d_value := 1;
            -- get the rounded value at this stage for the remaining fraction
            if (den /= 0) then
                m_value := (2*num/den);
            end if;
            -- calculate the fraction numerator and denominator at this stage
            for int_loop_iter in (loop_iter-1) downto 0 loop
                if (m_value = 0) then
                    m_value := quotient_array(int_loop_iter);
                    d_value := 1;
                else
                    old_m_value := m_value;
                    m_value := (quotient_array(int_loop_iter)*m_value) + d_value;
                    d_value := old_m_value;
                end if;
            end loop;
            -- if the denominator is less than the maximum denom_value or if there is no restriction save it
            if ((d_value <= max_denom) or (max_denom = -1)) then
                if ((m_value = 0) or (d_value = 0)) then
                    fraction_num := numerator;
                    fraction_div := denominator;
                else
                    fraction_num := m_value;
                    fraction_div := d_value;
                end if;
            end if;
            -- end the loop if the denomitor has overflown or the numerator is zero (no remainder during this round)
            if (((d_value > max_denom) and (max_denom /= -1)) or (num = 0)) then
                i_max_iter := loop_iter;
            end if;
        end if;
        -- swap the numerator and denominator for the next round
        swap := den;
        den := num;
        num := swap;
    end loop;
end find_simple_integer_fraction;

-- find the M and N values for Manual phase based on the following 5 criterias:
-- 1. The PFD frequency (i.e. Fin / N) must be in the range 5 MHz to 720 MHz
-- 2. The VCO frequency (i.e. Fin * M / N) must be in the range 300 MHz to 1300 MHz
-- 3. M is less than 512
-- 4. N is less than 512
-- 5. It's the smallest M/N which satisfies all the above constraints, and is within 2ps
--    of the desired vco-phase-shift-step
procedure find_m_and_n_4_manual_phase ( inclock_period : in integer;
                                        vco_phase_shift_step : in integer;
                                        clk0_mult: in integer; clk1_mult: in integer;
                                        clk2_mult: in integer; clk3_mult: in integer;
                                        clk4_mult: in integer; clk5_mult: in integer;
                                        clk6_mult: in integer; clk7_mult: in integer;
                                        clk8_mult: in integer; clk9_mult: in integer;
                                        clk0_div : in integer; clk1_div : in integer;
                                        clk2_div : in integer; clk3_div : in integer;
                                        clk4_div : in integer; clk5_div : in integer;
                                        clk6_div : in integer; clk7_div : in integer;
                                        clk8_div : in integer; clk9_div : in integer;
                                        m : out integer;
                                        n : out integer ) is
        constant MAX_M : integer := 511;
        constant MAX_N : integer := 511;
        constant MAX_PFD : integer := 720;
        constant MIN_PFD : integer := 5;
        constant MAX_VCO : integer := 1300;
        constant MIN_VCO : integer := 300;

        variable vco_period : integer;
        variable pfd_freq : integer;
        variable vco_freq : integer;
        variable vco_ps_step_value : integer;

        variable i_m : integer;
        variable i_n : integer;
        variable i_pre_m : integer;
        variable i_pre_n : integer;

        variable i_max_iter : integer;
        variable loop_iter : integer;
begin

    loop_iter  := 0;
    i_max_iter := MAX_N;
    vco_period := vco_phase_shift_step * 8;

    while (loop_iter < i_max_iter) loop
        loop_iter := loop_iter+1;

        i_pre_m := i_m;
        i_pre_n := i_n;

        find_simple_integer_fraction(inclock_period, vco_period,
                    loop_iter, i_m, i_n);

        if (((clk0_div * i_m) rem (clk0_mult * i_n) /= 0) or
            ((clk1_div * i_m) rem (clk1_mult * i_n) /= 0) or
            ((clk2_div * i_m) rem (clk2_mult * i_n) /= 0) or
            ((clk3_div * i_m) rem (clk3_mult * i_n) /= 0) or
            ((clk4_div * i_m) rem (clk4_mult * i_n) /= 0) or
            ((clk5_div * i_m) rem (clk5_mult * i_n) /= 0) or
            ((clk6_div * i_m) rem (clk6_mult * i_n) /= 0) or
            ((clk7_div * i_m) rem (clk7_mult * i_n) /= 0) or
            ((clk8_div * i_m) rem (clk8_mult * i_n) /= 0) or
            ((clk9_div * i_m) rem (clk9_mult * i_n) /= 0) )
        then
            if (loop_iter = 1)
            then
                n := 1;
                m := lcm  (clk0_mult, clk1_mult, clk2_mult, clk3_mult,
                        clk4_mult, clk5_mult, clk6_mult,
                        clk7_mult, clk8_mult, clk9_mult, inclock_period);
            else
                m := i_pre_m;
                n := i_pre_n;
            end if;

            i_max_iter := loop_iter;
        else
            m := i_m;
            n := i_n;
        end if;

        pfd_freq := 1000000 / (inclock_period * i_n);
        vco_freq := (1000000 * i_m) / (inclock_period * i_n);
        vco_ps_step_value := (inclock_period * i_n) / (8 * i_m);

        if ( (i_m < max_m) and (i_n < max_n) and (pfd_freq >= min_pfd) and (pfd_freq <= max_pfd) and
            (vco_freq >= min_vco) and (vco_freq <= max_vco) and 
            (abs(vco_ps_step_value - vco_phase_shift_step) <= 2) )
        then
            i_max_iter := loop_iter;
        end if;
    end loop;
end find_m_and_n_4_manual_phase;

-- find the greatest common denominator of X and Y
function gcd (X: integer; Y: integer) return integer is
variable L, S, R, G : integer := 1;
begin
    if (X < Y) then -- find which is smaller.
        S := X;
        L := Y;
    else
        S := Y;
        L := X;
    end if;

    R := S;
    while ( R > 1) loop
        S := L;
        L := R;
        R := S rem L;   -- divide bigger number by smaller.
                        -- remainder becomes smaller number.
    end loop;
    if (R = 0) then  -- if evenly divisible then L is gcd else it is 1.
        G := L;
    else
        G := R;
    end if;

    return G;
end gcd;

-- count the number of digits in the given integer
function count_digit (X: integer)
        return integer is
variable count, result: integer := 0;
begin
    result := X;
    while (result /= 0) loop
        result := (result / 10);
        count := count + 1;
    end loop;
    
    return count;
end count_digit;
    
-- reduce the given huge number to Y significant digits
function scale_num (X: integer; Y: integer)
        return integer is
variable count : integer := 0; 
variable lc, fac_ten, result: integer := 1;
begin
    count := count_digit(X);

    for lc in 1 to (count-Y) loop
        fac_ten := fac_ten * 10;
    end loop;
    
    result := (X / fac_ten);
    
    return result;
end scale_num;

-- find the least common multiple of A1 to A10
function lcm (A1: integer; A2: integer; A3: integer; A4: integer;
            A5: integer; A6: integer; A7: integer;
            A8: integer; A9: integer; A10: integer; P: integer)
        return integer is
variable M1, M2, M3, M4, M5 , M6, M7, M8, M9, R: integer := 1;
begin
    M1 := (A1 * A2)/gcd(A1, A2);
    M2 := (M1 * A3)/gcd(M1, A3);
    M3 := (M2 * A4)/gcd(M2, A4);
    M4 := (M3 * A5)/gcd(M3, A5);
    M5 := (M4 * A6)/gcd(M4, A6);
    M6 := (M5 * A7)/gcd(M5, A7);
    M7 := (M6 * A8)/gcd(M6, A8);
    M8 := (M7 * A9)/gcd(M7, A9);
    M9 := (M8 * A10)/gcd(M8, A10);
    if (M9 < 3) then
        R := 10;
    elsif (M9 = 3) then
        R := 9;
    elsif ((M9 <= 10) and (M9 > 3)) then
        R := 4 * M9;
    elsif (M9 > 1000) then
        R := scale_num(M9,3);
    else
        R := M9 ;
    end if;

    return R;
end lcm;

-- find the factor of division of the output clock frequency compared to the VCO
function output_counter_value (clk_divide: integer; clk_mult: integer ;
                                M: integer; N: integer ) return integer is
variable R: integer := 1;
begin
    R := (clk_divide * M)/(clk_mult * N);

    return R;
end output_counter_value;

-- find the mode of each PLL counter - bypass, even or odd
function counter_mode (duty_cycle: integer; output_counter_value: integer)
        return string is
variable R: string (1 to 6) := "      ";
variable counter_value: integer := 1;
begin
    counter_value := (2*duty_cycle*output_counter_value)/100;
    if output_counter_value = 1 then
        R := "bypass";
    elsif (counter_value REM 2) = 0 then
        R := "  even";
    else
        R := "   odd";
    end if;

    return R;
end counter_mode;

-- find the number of VCO clock cycles to hold the output clock high
function counter_high (output_counter_value: integer := 1; duty_cycle: integer)
        return integer is
variable R: integer := 1;
variable half_cycle_high : integer := 1;
begin
    half_cycle_high := (duty_cycle * output_counter_value *2)/100 ;
    if (half_cycle_high REM 2 = 0) then
        R := half_cycle_high/2 ;
    else
        R := (half_cycle_high/2) + 1;
    end if;

    return R;
end;

-- find the number of VCO clock cycles to hold the output clock low
function counter_low (output_counter_value: integer; duty_cycle: integer)
        return integer is
variable R, R1: integer := 1;
variable half_cycle_high : integer := 1;
begin
    half_cycle_high := (duty_cycle * output_counter_value*2)/100 ;
    if (half_cycle_high REM 2 = 0) then
        R1 := half_cycle_high/2 ;
    else
        R1 := (half_cycle_high/2) + 1;
    end if;

    R := output_counter_value - R1;

    return R;
end;

-- find the smallest time delay amongst t1 to t10
function mintimedelay (t1: integer; t2: integer; t3: integer; t4: integer;
                        t5: integer; t6: integer; t7: integer; t8: integer;
                        t9: integer; t10: integer) return integer is
variable m1,m2,m3,m4,m5,m6,m7,m8,m9 : integer := 0;
begin
    if (t1 < t2) then m1 := t1; else m1 := t2; end if;
    if (m1 < t3) then m2 := m1; else m2 := t3; end if;
    if (m2 < t4) then m3 := m2; else m3 := t4; end if;
    if (m3 < t5) then m4 := m3; else m4 := t5; end if;
    if (m4 < t6) then m5 := m4; else m5 := t6; end if;
    if (m5 < t7) then m6 := m5; else m6 := t7; end if;
    if (m6 < t8) then m7 := m6; else m7 := t8; end if;
    if (m7 < t9) then m8 := m7; else m8 := t9; end if;
    if (m8 < t10) then m9 := m8; else m9 := t10; end if;
    if (m9 > 0) then return m9; else return 0; end if;
end;

-- find the numerically largest negative number, and return its absolute value
function maxnegabs (t1: integer; t2: integer; t3: integer; t4: integer;
                    t5: integer; t6: integer; t7: integer; t8: integer;
                    t9: integer; t10: integer) return integer is
variable m1,m2,m3,m4,m5,m6,m7,m8,m9 : integer := 0;
begin
    if (t1 < t2) then m1 := t1; else m1 := t2; end if;
    if (m1 < t3) then m2 := m1; else m2 := t3; end if;
    if (m2 < t4) then m3 := m2; else m3 := t4; end if;
    if (m3 < t5) then m4 := m3; else m4 := t5; end if;
    if (m4 < t6) then m5 := m4; else m5 := t6; end if;
    if (m5 < t7) then m6 := m5; else m6 := t7; end if;
    if (m6 < t8) then m7 := m6; else m7 := t8; end if;
    if (m7 < t9) then m8 := m7; else m8 := t9; end if;
    if (m8 < t10) then m9 := m8; else m9 := t10; end if;
    if (m9 < 0) then return (0 - m9); else return 0; end if;
end;

-- adjust the phase (tap_phase) with the largest negative number (ph_base)
function ph_adjust (tap_phase: integer; ph_base : integer) return integer is
begin
    return (tap_phase + ph_base);
end;

-- find the time delay for each PLL counter
function counter_time_delay (clk_time_delay: integer;
                            m_time_delay: integer; n_time_delay: integer)
        return integer is
variable R: integer := 0;
begin
    R := clk_time_delay + m_time_delay - n_time_delay;

    return R;
end;

-- calculate the given phase shift (in ps) in terms of degrees
function get_phase_degree (phase_shift: integer; clk_period: integer)
        return integer is
variable result: integer := 0;
begin
    result := ( phase_shift * 360 ) / clk_period;
    -- to round up the calculation result
    if (result > 0) then
        result := result + 1;
    elsif (result < 0) then
        result := result - 1;
    else
        result := 0;
    end if;

    return result;
end;

-- find the number of VCO clock cycles to wait initially before the first rising
-- edge of the output clock
function counter_initial (tap_phase: integer; m: integer; n: integer)
        return integer is
variable R: integer;
variable R1: real;
begin
    R1 := (real(abs(tap_phase)) * real(m))/(360.0 * real(n)) + 0.5;
    -- Note NCSim VHDL had problem in rounding up for 0.5 - 0.99. 
    -- This checking will ensure that the rounding up is done.
    if (R1 >= 0.5) and (R1 <= 1.0) then
        R1 := 1.0;
    end if;

    R := integer(R1);

    return R;
end;

-- find which VCO phase tap (0 to 7) to align the rising edge of the output clock to
function counter_ph (tap_phase: integer; m: integer; n: integer) return integer is
variable R: integer := 0;
begin
    -- 0.5 is added for proper rounding of the tap_phase.
    R := (integer(real(tap_phase * m / n)+ 0.5) REM 360)/45;

    return R;
end;

-- convert given string to length 6 by padding with spaces
function translate_string (mode : string) return string is
variable new_mode : string (1 to 6) := "      ";
begin
    if (mode = "bypass") then
        new_mode := "bypass";
    elsif (mode = "even") then
        new_mode := "  even";
    elsif (mode = "odd") then
        new_mode := "   odd";
    end if;

    return new_mode;
end;

function str2int (s : string) return integer is
variable len : integer := s'length;
variable newdigit : integer := 0;
variable sign : integer := 1;
variable digit : integer := 0;
begin
    for i in 1 to len loop
        case s(i) is
            when '-' =>
                if i = 1 then
                    sign := -1;
                else
                    ASSERT FALSE
                    REPORT "Illegal Character "&  s(i) & "i n string parameter! "
                    SEVERITY ERROR;
                end if;
            when '0' =>
                digit := 0;
            when '1' =>
                digit := 1;
            when '2' =>
                digit := 2;
            when '3' =>
                digit := 3;
            when '4' =>
                digit := 4;
            when '5' =>
                digit := 5;
            when '6' =>
                digit := 6;
            when '7' =>
                digit := 7;
            when '8' =>
                digit := 8;
            when '9' =>
                digit := 9;
            when others =>
                ASSERT FALSE
                REPORT "Illegal Character "&  s(i) & "in string parameter! "
                SEVERITY ERROR;
        end case;
        newdigit := newdigit * 10 + digit;
    end loop;

    return (sign*newdigit);
end;
end MF_pllpack;
-- END OF PACKAGE MF_pllpack



---START_ENTITY_HEADER----------------------------------------------------------
--
-- Entity Name      : ALTSYNCRAM
--
-- Description      : Synchronous ram model for Stratix series family
--
-- Limitation       :
--
---END_ENTITY_HEADER------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.ALTERA_COMMON_CONVERSION.all;
use work.ALTERA_DEVICE_FAMILIES.all;

-- BEGINNING OF ENTITY

-- ENTITY DECLARATION

entity altsyncram is
-- GENERIC DECLARATION
    generic (
        -- PORT A PARAMETERS
        width_a                            :  natural := 1;
        widthad_a                          :  natural := 1;
        numwords_a                         :  natural := 0;
        outdata_reg_a                      :  string  := "UNREGISTERED";
        address_aclr_a                     :  string  := "NONE";
        outdata_aclr_a                     :  string  := "NONE";
        indata_aclr_a                      :  string  := "NONE";
        wrcontrol_aclr_a                   :  string  := "NONE";
        byteena_aclr_a                     :  string  := "NONE";
        width_byteena_a                    :  natural := 1;
        clock_enable_input_a               :  string  := "NORMAL";
        clock_enable_output_a              :  string  := "NORMAL";
        clock_enable_core_a                :  string  := "USE_INPUT_CLKEN";
        read_during_write_mode_port_a      :  string  := "NEW_DATA_NO_NBE_READ";

        -- PORT B PARAMETERS
        width_b                            :  natural := 1;
        widthad_b                          :  natural := 1;
        numwords_b                         :  natural := 0;
        rdcontrol_reg_b                    :  string  := "CLOCK1";
        address_reg_b                      :  string  := "CLOCK1";
        outdata_reg_b                      :  string  := "UNREGISTERED";
        outdata_aclr_b                     :  string  := "NONE";
        rdcontrol_aclr_b                   :  string  := "NONE";
        indata_reg_b                       :  string  := "CLOCK1";
        wrcontrol_wraddress_reg_b          :  string  := "CLOCK1";
        byteena_reg_b                      :  string  := "CLOCK1";
        indata_aclr_b                      :  string  := "NONE";
        wrcontrol_aclr_b                   :  string  := "NONE";
        address_aclr_b                     :  string  := "NONE";
        byteena_aclr_b                     :  string  := "NONE";
        width_byteena_b                    :  natural := 1;
        clock_enable_input_b               :  string  := "NORMAL";
        clock_enable_output_b              :  string  := "NORMAL";
        clock_enable_core_b                :  string  := "USE_INPUT_CLKEN";
        read_during_write_mode_port_b      :  string  := "NEW_DATA_NO_NBE_READ";

        -- ECC STATUS PARAMETERS
        enable_ecc                         :  string  := "FALSE";
        
        -- GLOBAL PARAMETERS
        operation_mode                     :  string  := "BIDIR_DUAL_PORT";
        byte_size                          :  natural := 0;
        read_during_write_mode_mixed_ports :  string  := "DONT_CARE";
        ram_block_type                     :  string  := "AUTO";
        init_file                          :  string  := "UNUSED";
        init_file_layout                   :  string  := "UNUSED";
        maximum_depth                      :  natural := 0;
        intended_device_family             :  string  := "Stratix";
        power_up_uninitialized             :  string  := "FALSE";
        implement_in_les                   :  string  := "OFF";

        lpm_hint                           :  string  := "UNUSED";
        lpm_type                           :  string  := "altsyncram"
        );

-- PORT DECLARATION
    port (
        -- INPUT PORT DECLARATION
        wren_a    : in std_logic := '0'; -- Port A write/read enable input
        wren_b    : in std_logic := '0'; -- Port B write enable input
        rden_a    : in std_logic := '1'; -- Port A read enable input
        rden_b    : in std_logic := '1'; -- Port B read enable input
        data_a    : in std_logic_vector(width_a - 1 downto 0) := (others => '1');
                        -- Port A data input
        data_b    : in std_logic_vector(width_b - 1 downto 0) := (others => '1');
                        -- Port B data input
        address_a : in std_logic_vector(widthad_a - 1 downto 0);
                        -- Port A address input
        address_b : in std_logic_vector(widthad_b - 1 downto 0) := (others => '1');
                        -- Port B address input

        -- clock inputs on both ports and here are their usages:
        -- Port A
        -- 1. all input registers must be clocked by clock0.
        -- 2. output register can be clocked by  either by clock0, clock1 or none.
        -- Port B
        -- 1. all input registers must be clocked by either clock0 or clock1.
        -- 2. output register can be clocked by either clock0, clock1 or none.
        clock0    : in std_logic := '1';
        clock1    : in std_logic := '1';

        -- clock enable inputs and here are their usages:
        -- clocken0 -- can only be used for enabling clock0.
        -- clocken1 -- can only be used for enabling clock1.
        -- clocken2 -- as an alternative for enabling clock0.
        -- clocken3 -- as an alternative for enabling clock1.
        clocken0  : in std_logic := '1';
        clocken1  : in std_logic := '1';
        clocken2  : in std_logic := '1';
        clocken3  : in std_logic := '1';

        -- clear inputs on both ports and here are their usages:
        -- Port A
        -- 1. all input registers can only be cleared by clear0 or none.
        -- 2. output register can be cleared by either clear0, clear1 or none.
        -- Port B
        -- 1. all input registers can be cleared by either clear0, clear1 or none.
        -- 2. output register can be cleared by either clear0, clear1  or none.
        aclr0     : in std_logic := '0';
        aclr1     : in std_logic := '0';

        addressstall_a  : in std_logic := '0';
        addressstall_b  : in std_logic := '0';

        byteena_a : in std_logic_vector( (width_byteena_a) - 1 downto 0) := (others => '1');
                        -- Port A byte enable input
        byteena_b : in std_logic_vector( (width_byteena_b) - 1 downto 0) := (others => '1');
                        -- Port B byte enable input

        -- OUTPUT PORT DECLARATION
        q_a       : out std_logic_vector(width_a - 1 downto 0); -- Port A output
        q_b       : out std_logic_vector(width_b - 1 downto 0); -- Port B output
        eccstatus : out std_logic_vector(2 downto 0)            -- ECC status flag
        );

-- TYPE DECLARATION

    constant pow_widthad_a : natural := 2 ** widthad_a;
		constant pow_widthad_b : natural := 2 ** widthad_b;

    type width_a_array is array (pow_widthad_a - 1 downto 0) of std_logic_vector(width_a - 1 downto 0);
    type width_b_array is array (pow_widthad_b - 1 downto 0) of std_logic_vector(width_b - 1 downto 0);


-- FUNCTION DEFINITION

    -- This procedure read the hex file into the memory content
    procedure read_my_memory (
            constant use_a : in boolean;
            variable mem_data_a : out width_a_array;
            variable mem_data_b : out width_b_array
            ) is

        variable m_mem_data_word_a : std_logic_vector(width_a-1 downto 0);
        variable m_mem_data_word_b : std_logic_vector(width_b-1 downto 0);
        variable i : integer := 0;
        variable j : integer := 0;
        variable m_num_of_bytes : integer := 0;
        variable m_line_no : integer := 0;
        variable m_line_buf : line ;
        variable m_err_check : boolean := true;
        variable m_base : string(2 downto 1);
        variable m_ibase : integer := 0;
        variable m_byte_str : string(2 downto 1);
        variable m_rec_type : string(2 downto 1);
        variable m_datain : string(2 downto 1);
        variable m_character : string(1 downto 1);
        variable m_addr : string(2 downto 1);
        variable m_checksum : string(2 downto 1);
        variable m_startadd : string(4 downto 1);
        variable m_istartadd : integer := 0;
        variable m_byte_int : natural := 0;
        variable m_check_sum_vec : unsigned(7 downto 0);
        variable m_check_sum_vec_tmp : std_logic_vector(7 downto 0);
        variable m_string : string(1 to 15);
        variable m_data_radix : string(1 to 3);
        variable m_address_radix : string(1 to 3);
        variable m_width : integer;
        variable m_depth : integer;
        variable m_start_address_int : integer := 0;
        variable m_end_address_int : integer := 0;
        variable m_address_int : integer := 0;
        variable m_data_int : unsigned(width_a+width_b+4 downto 0) := (OTHERS => '0');
        variable found_keyword_content : boolean := false;
        variable get_memory_content : boolean := false;
        variable get_start_Address : boolean := false;
        variable get_end_Address : boolean := false;
        file m_mem_data_file : text;

        begin

        -- Initialize memory content
        if (use_a) then
            for i in mem_data_a'low to mem_data_a'high loop
                mem_data_a(i) := (others => '0');
            end loop;
        else
            for i in mem_data_b'low to mem_data_b'high loop
                mem_data_b(i) := (others => '0');
            end loop;
        end if;

        file_open(m_mem_data_file, init_file, read_mode);

        if (ALPHA_TOLOWER(init_file(init_file'length -3 to init_file'length)) = ".hex") then
            while not endfile(m_mem_data_file) loop
                m_err_check := true;
                readline(m_mem_data_file, m_line_buf);
                m_line_no := m_line_no + 1;
                m_check_sum_vec := (others=> '0');
    
                if (m_line_buf(m_line_buf'low) = ':') then
                    i := 1;
                    SHRINK_LINE(m_line_buf, i);
                    read(l=>m_line_buf, value=>m_byte_str, good=>m_err_check);
    
                    if not (m_err_check) then
                        assert false
                        report "[Line "& INT_TO_STR_RAM(m_line_no) & "]:Illegal Intel Hex Format!"
                        severity error;
                    end if;
    
                    m_byte_int := natural(HEX_STR_TO_INT(m_byte_str));
                    m_check_sum_vec :=  m_check_sum_vec + natural(m_byte_int); -- to_unsigned(m_byte_int, 8);
					--unsigned(conv_std_logic_vector(m_byte_int, 8));
                    read(l=>m_line_buf, value=>m_startadd, good=>m_err_check);
    
                    if not (m_err_check) then
                        assert false
                        report "[Line "& INT_TO_STR_RAM(m_line_no) & "]:Illegal Intel Hex Format! "
                        severity error;
                    end if;
    
                    m_istartadd := HEX_STR_TO_INT(m_startadd);
                    m_addr(2) := m_startadd(4);
                    m_addr(1) := m_startadd(3);
                    m_check_sum_vec :=  m_check_sum_vec + natural(HEX_STR_TO_INT(m_addr));
                                        --unsigned(conv_std_logic_vector(HEX_STR_TO_INT(m_addr), 8));
                    m_addr(2) := m_startadd(2);
                    m_addr(1) := m_startadd(1);
                    m_check_sum_vec :=  m_check_sum_vec + natural(HEX_STR_TO_INT(m_addr));
                                        --unsigned(conv_std_logic_vector(HEX_STR_TO_INT(m_addr), 8));
                    read(l=>m_line_buf, value=>m_rec_type, good=>m_err_check);
    
                    if not (m_err_check) then
                        assert false
                        report "[Line "& INT_TO_STR_RAM(m_line_no) & "]:Illegal Intel Hex Format! "
                        severity error;
                    end if;
    
                    m_check_sum_vec :=  m_check_sum_vec + natural(HEX_STR_TO_INT(m_rec_type));
                                        --unsigned(conv_std_logic_vector(HEX_STR_TO_INT(m_rec_type), 8));
    
                else
                    assert false
                    report "[Line "& INT_TO_STR_RAM(m_line_no) & "]:Illegal Intel Hex Format! "
                    severity error;
                end if;
    
                case m_rec_type is
                    when "00"=>     -- Data record
                        i := 0;
                        if (use_a) then
                            m_num_of_bytes := (width_a + 7) / 8;
                        else
                            m_num_of_bytes := (width_b + 7) / 8;
                        end if;
    
                        while (i < m_byte_int) loop
    
                            if (use_a) then
                                m_mem_data_word_a := (others => '0');
                            else
                                m_mem_data_word_b := (others => '0');
                            end if;
    
                            j := 1;
                            while ( j <= m_num_of_bytes and  i < m_byte_int ) loop
                                read(l => m_line_buf, value => m_datain, good => m_err_check);
                                if not (m_err_check) then
                                    assert false
                                    report "[Line "& INT_TO_STR_RAM(m_line_no) & "]:Illegal Intel Hex Format! "
                                    severity error;
                                end if;
    
                                m_check_sum_vec :=  m_check_sum_vec + natural(HEX_STR_TO_INT(m_datain));
                                                    --unsigned(conv_std_logic_vector(HEX_STR_TO_INT(m_datain), 8));
    
                                if (use_a) then
                                    if (width_a > 8) then
                                        m_mem_data_word_a := m_mem_data_word_a(width_a - 9 downto 0)  & std_logic_vector(to_unsigned(natural(HEX_STR_TO_INT(m_datain)), 8));                                    
                                    else
                                        m_mem_data_word_a := std_logic_vector(to_unsigned(natural(HEX_STR_TO_INT(m_datain)), width_a));
                                    end if;
                                else
                                    if (width_b > 8) then
                                        m_mem_data_word_b := m_mem_data_word_b(width_b - 9 downto 0)  & std_logic_vector(to_unsigned(natural(HEX_STR_TO_INT(m_datain)), 8));
                                    else
                                        m_mem_data_word_b := std_logic_vector(to_unsigned(natural(HEX_STR_TO_INT(m_datain)), width_b));
                                    end if;
                                end if;
    

                                j := j + 1;
                                i := i + 1;
                            end loop;
        
                            if ((use_a) and ((m_ibase + m_istartadd) <= (2 ** widthad_a - 1)))then
                                mem_data_a(m_ibase + m_istartadd) := m_mem_data_word_a;
                            elsif ((m_ibase + m_istartadd) <= (2 ** widthad_b - 1)) then
                                mem_data_b(m_ibase + m_istartadd) := m_mem_data_word_b;
                            else
                                assert false
                                report "[Line "& INT_TO_STR_RAM(m_line_no) & "]: Unable to initialized memory with this data record since the specified address is out of valid address range!"
                                severity warning;                               
                            end if;
                            m_istartadd := m_istartadd + 1;
                        end loop;
    
                    when "01"=>
                        exit;
    
                    when "02"=>
                        m_ibase := 0;
                        if (m_byte_int /= 2) then
                            assert false
                            report "[Line "& INT_TO_STR_RAM(m_line_no) & "]:Illegal Intel Hex Format for record type 02! "
                            severity error;
                        end if;
    
                        for i in 0 to (m_byte_int-1) loop
                            read(l=>m_line_buf, value=>m_base,good=>m_err_check);
                            m_ibase := m_ibase * 256 + HEX_STR_TO_INT(m_base);
    
                            if not (m_err_check) then
                                assert false
                                report "[Line "& INT_TO_STR_RAM(m_line_no) & "]:Illegal Intel Hex Format! "
                                severity error;
                            end if;
    
                            m_check_sum_vec :=  m_check_sum_vec + natural(HEX_STR_TO_INT(m_base));
                                                --unsigned(conv_std_logic_vector(HEX_STR_TO_INT(m_base), 8));
                        end loop;
    
                        m_ibase := m_ibase * 16;
    
                    when "03"=>
                        if (m_byte_int /= 4) then
                            ASSERT FALSE
                            REPORT  "[Line "& INT_TO_STR_RAM(m_line_no) & 
                                    "]:Illegal Intel Hex Format for record type 03! "
                            SEVERITY ERROR;
                        end if;
                        for i in 0 to (m_byte_int-1) loop
                            READ(L=>m_line_buf, VALUE=>m_base,good=>m_err_check);
                            if not (m_err_check) then
                                ASSERT FALSE
                                REPORT  "[Line "& INT_TO_STR_RAM(m_line_no) & 
                                        "]:Illegal Intel Hex Format! "
                                SEVERITY ERROR;
                            end if;
                            m_check_sum_vec := m_check_sum_vec + natural(HEX_STR_TO_INT(m_base));
																							--unsigned(CONV_STD_LOGIC_VECTOR(HEX_STR_TO_INT(m_base), 8));
                        end loop;
                    when "04"=>
                        m_ibase := 0;
                        if (m_byte_int /= 2) then
                            ASSERT FALSE
                            REPORT  "[Line "& INT_TO_STR_RAM(m_line_no) & 
                                    "]:Illegal Intel Hex Format for record type 04! "
                            SEVERITY ERROR;
                        end if;
                        for i in 0 to (m_byte_int-1) loop
                            READ(L=>m_line_buf, VALUE=>m_base,good=>m_err_check);
                            m_ibase := (m_ibase * 256) + HEX_STR_TO_INT(m_base);
                            if not (m_err_check) then
                                ASSERT FALSE
                                REPORT  "[Line "& INT_TO_STR_RAM(m_line_no) & 
                                        "]:Illegal Intel Hex Format! "
                                SEVERITY ERROR;
                            end if;
                            m_check_sum_vec := m_check_sum_vec + natural(HEX_STR_TO_INT(m_base));
																				--unsigned(CONV_STD_LOGIC_VECTOR(HEX_STR_TO_INT(m_base), 8));
                        end loop;
                        m_ibase := m_ibase * 65536;
                    when "05"=>
                        if (m_byte_int /= 4) then
                            ASSERT FALSE
                            REPORT  "[Line "& INT_TO_STR_RAM(m_line_no) & 
                                    "]:Illegal Intel Hex Format for record type 05! "
                            SEVERITY ERROR;
                        end if;
                        for i in 0 to (m_byte_int-1) loop
                            READ(L=>m_line_buf, VALUE=>m_base,good=>m_err_check);
                            if not (m_err_check) then
                                ASSERT FALSE
                                REPORT  "[Line "& INT_TO_STR_RAM(m_line_no) & 
                                        "]:Illegal Intel Hex Format! "
                                SEVERITY ERROR;
                            end if;
                            m_check_sum_vec := m_check_sum_vec + natural(HEX_STR_TO_INT(m_base));
																							--unsigned(CONV_STD_LOGIC_VECTOR(HEX_STR_TO_INT(m_base), 8));
                        end loop;
    
                    when others=>
                        assert false
                        report "[Line "& INT_TO_STR_RAM(m_line_no) & "]:Illegal record type in Intel Hex File! "
                        severity error;
    
                end case;
    
                read(l=>m_line_buf, value=>m_checksum, good=>m_err_check);
    
                if not (m_err_check) then
                    assert false
                    report"[Line "& INT_TO_STR_RAM(m_line_no) & "]:Checksum is missing! "
                    severity error;
                end if;
    
                m_check_sum_vec := unsigned(not (m_check_sum_vec)) + natural(1);
                m_check_sum_vec_tmp := std_logic_vector(to_unsigned(natural(HEX_STR_TO_INT(m_checksum)),8));
    
                if (unsigned(m_check_sum_vec) /= unsigned(m_check_sum_vec_tmp)) then
                    assert false
                    report "[Line "& INT_TO_STR_RAM(m_line_no) & "]:Incorrect checksum!"
                    severity error;
                end if;
            end loop;
        elsif (ALPHA_TOLOWER(init_file(init_file'length -3 to init_file'length)) = ".mif") then
            while not endfile(m_mem_data_file) loop
                m_err_check := true;
                readline(m_mem_data_file, m_line_buf);
                m_line_no := m_line_no + 1;
                m_check_sum_vec := (others=> '0');
                LOOP2 : while (m_line_buf'length > 0) loop
                    if (m_line_buf(m_line_buf'low) = '-') then
                        if (m_line_buf(m_line_buf'low) = '-') then
                            -- ignore comment started with --.
                            exit LOOP2;
                        end if;
                    elsif (m_line_buf(m_line_buf'low) = '%') then
                        i := 1;
                        
                        -- ignore comment which begin with % and end with another %.
                        while ((i < m_line_buf'high) and (m_line_buf(m_line_buf'low + i) /= '%')) loop
                            i := i+1;
                        end loop;
                        
                        if (i >= m_line_buf'high) then
                            exit LOOP2;
                        else
                            SHRINK_LINE(m_line_buf, i+1);
                        end if;
                    elsif ((m_line_buf(m_line_buf'low) = ' ') or (m_line_buf(m_line_buf'low) = HT)) then
                        i := 1;
                        -- ignore space or tab character.
                        while ((i < m_line_buf'high-1) and ((m_line_buf(m_line_buf'low +i) = ' ') or
                                (m_line_buf(m_line_buf'low+i) = HT))) loop
                            i := i+1;
                        end loop;
                        
                        if (i >= m_line_buf'high) then
                            exit LOOP2;
                        else
                            SHRINK_LINE(m_line_buf, i);
                        end if;
                    elsif (get_memory_content = true) then
                    
                        if ((m_line_buf(m_line_buf'low to m_line_buf'low +2) = "end") or
                            (m_line_buf(m_line_buf'low to m_line_buf'low +2) = "END") or
                            (m_line_buf(m_line_buf'low to m_line_buf'low +2) = "End")) then
                            get_memory_content := false;
                            exit LOOP2;
                        else
                            get_start_address := false;
                            get_end_address := false;
                            m_start_address_int := 0;
                            m_end_address_int := 0;
                            m_address_int := 0;
                            m_data_int := (others => '0');
                            if (m_line_buf(m_line_buf'low) = '[') then
                                get_start_Address := true;
                                SHRINK_LINE(m_line_buf, 1);
                            end if;

                            case m_address_radix is
                                when "hex" =>
                                    while ((m_line_buf(m_line_buf'low) /= ' ') and (m_line_buf(m_line_buf'low) /= HT) and
                                            (m_line_buf(m_line_buf'low) /= ':') and (m_line_buf(m_line_buf'low) /= '.')) loop
                                        read(l => m_line_buf, value => m_character, good => m_err_check);
                                        m_address_int := m_address_int *16 +  HEX_STR_TO_INT(m_character);
                                    end loop;
                                when "bin" =>
                                    while ((m_line_buf(m_line_buf'low) /= ' ') and (m_line_buf(m_line_buf'low) /= HT) and
                                            (m_line_buf(m_line_buf'low) /= ':') and (m_line_buf(m_line_buf'low) /= '.')) loop
                                        read(l => m_line_buf, value => m_character, good => m_err_check);
                                        m_address_int := m_address_int *2 +  BIN_STR_TO_INT(m_character);
                                    end loop;
                                when "dec" =>
                                    while ((m_line_buf(m_line_buf'low) /= ' ') and (m_line_buf(m_line_buf'low) /= HT) and
                                            (m_line_buf(m_line_buf'low) /= ':') and (m_line_buf(m_line_buf'low) /= '.')) loop
                                        read(l => m_line_buf, value => m_character, good => m_err_check);
                                        m_address_int := m_address_int *10 +  INT_STR_TO_INT(m_character);
                                    end loop;
                                when "uns" =>
                                    while ((m_line_buf(m_line_buf'low) /= ' ') and (m_line_buf(m_line_buf'low) /= HT) and
                                            (m_line_buf(m_line_buf'low) /= ':') and (m_line_buf(m_line_buf'low) /= '.')) loop
                                        read(l => m_line_buf, value => m_character, good => m_err_check);
                                        m_address_int := m_address_int *10 +  INT_STR_TO_INT(m_character);
                                    end loop;
                                when "oct" =>
                                    while ((m_line_buf(m_line_buf'low) /= ' ') and (m_line_buf(m_line_buf'low) /= HT) and
                                            (m_line_buf(m_line_buf'low) /= ':') and (m_line_buf(m_line_buf'low) /= '.')) loop
                                        read(l => m_line_buf, value => m_character, good => m_err_check);
                                        m_address_int := m_address_int *8 + OCT_STR_TO_INT(m_character);
                                    end loop;
                                when others =>
                                    assert false
                                    report "Unsupported address_radix!"
                                    severity error;
                            end case;

                            if (get_start_Address = true) then
                            
                                i := 0;
                                -- ignore space or tab character.
                                while ((i < m_line_buf'high-1) and ((m_line_buf(m_line_buf'low +i) = ' ') or
                                    (m_line_buf(m_line_buf'low+i) = HT))) loop
                                    i := i+1;
                                end loop;
                            
                                if (i > 0) then
                                    SHRINK_LINE(m_line_buf, i);
                                end if;
    
                                if ((m_line_buf(m_line_buf'low) = '.') and (m_line_buf(m_line_buf'low+1) = '.')) then
                                    get_start_Address := false;
                                    get_end_Address := true;
                                    m_start_address_int := m_address_int;
                                    SHRINK_LINE(m_line_buf, 2);    
                                end if;
                            end if;

                            if (get_end_address = true) then
                                i := 0;
                                -- ignore space or tab character.
                                while ((i < m_line_buf'high-1) and ((m_line_buf(m_line_buf'low +i) = ' ') or
                                    (m_line_buf(m_line_buf'low+i) = HT))) loop
                                    i := i+1;
                                end loop;
                            
                                if (i > 0) then
                                    SHRINK_LINE(m_line_buf, i);
                                end if;                                
                                
                                m_address_int := 0;
                                case m_address_radix is
                                    when "hex" =>
                                        while ((m_line_buf(m_line_buf'low) /= ' ') and (m_line_buf(m_line_buf'low) /= HT) and
                                                (m_line_buf(m_line_buf'low) /= ']')) loop
                                            read(l => m_line_buf, value => m_character, good => m_err_check);
                                            m_address_int := m_address_int *16 +  HEX_STR_TO_INT(m_character);
                                        end loop;
                                    when "bin" =>
                                        while ((m_line_buf(m_line_buf'low) /= ' ') and (m_line_buf(m_line_buf'low) /= HT) and
                                                (m_line_buf(m_line_buf'low) /= ']')) loop
                                            read(l => m_line_buf, value => m_character, good => m_err_check);
                                            m_address_int := m_address_int *2 +  BIN_STR_TO_INT(m_character);
                                        end loop;
                                    when "dec" =>
                                        while ((m_line_buf(m_line_buf'low) /= ' ') and (m_line_buf(m_line_buf'low) /= HT) and
                                                (m_line_buf(m_line_buf'low) /= ']')) loop
                                            read(l => m_line_buf, value => m_character, good => m_err_check);
                                            m_address_int := m_address_int *10 +  INT_STR_TO_INT(m_character);
                                        end loop;
                                    when "uns" =>
                                        while ((m_line_buf(m_line_buf'low) /= ' ') and (m_line_buf(m_line_buf'low) /= HT) and
                                                (m_line_buf(m_line_buf'low) /= ']')) loop
                                            read(l => m_line_buf, value => m_character, good => m_err_check);
                                            m_address_int := m_address_int *10 +  INT_STR_TO_INT(m_character);
                                        end loop;
                                    when "oct" =>
                                        while ((m_line_buf(m_line_buf'low) /= ' ') and (m_line_buf(m_line_buf'low) /= HT) and
                                                (m_line_buf(m_line_buf'low) /= ']')) loop
                                            read(l => m_line_buf, value => m_character, good => m_err_check);
                                            m_address_int := m_address_int *8 + OCT_STR_TO_INT(m_character);
                                        end loop;
                                    when others =>
                                        assert false
                                        report "Unsupported address_radix!"
                                        severity error;
                                end case;

                                if (m_line_buf(m_line_buf'low) = ']') then
                                    get_end_address := false;
                                    m_end_address_int := m_address_int;
                                    SHRINK_LINE(m_line_buf, 1);    
                                end if;
                            end if;
                                
                            i := 0;
                            -- ignore space or tab character.
                            while ((i < m_line_buf'high-1) and ((m_line_buf(m_line_buf'low +i) = ' ') or
                                (m_line_buf(m_line_buf'low+i) = HT))) loop
                                i := i+1;
                            end loop;
                            
                            if (i > 0) then
                                SHRINK_LINE(m_line_buf, i);
                            end if;                                
                            
                            if (m_line_buf(m_line_buf'low) = ':') then
                                SHRINK_LINE(m_line_buf, 1);    
                            end if;
                            
                            i := 0;
                            -- ignore space or tab character.
                            while ((i < m_line_buf'high-1) and ((m_line_buf(m_line_buf'low +i) = ' ') or
                                (m_line_buf(m_line_buf'low+i) = HT))) loop
                                i := i+1;
                            end loop;
                            
                            if (i > 0) then
                                SHRINK_LINE(m_line_buf, i);
                            end if;
    
                            case m_data_radix is
                                when "hex" =>
                                    while ((m_line_buf(m_line_buf'low) /= ';') and (m_line_buf(m_line_buf'low) /= ' ') and
                                            (m_line_buf(m_line_buf'low) /= HT)) loop
                                        read(l => m_line_buf, value => m_character, good => m_err_check);
                                        m_data_int(width_a+width_b+4 downto 0) := m_data_int(width_a+width_b-1 downto 0) * "10000" + to_unsigned(natural(HEX_STR_TO_INT(m_character)), 4);
                                    end loop;
                                when "bin" =>
                                    while ((m_line_buf(m_line_buf'low) /= ';') and (m_line_buf(m_line_buf'low) /= ' ') and
                                            (m_line_buf(m_line_buf'low) /= HT)) loop
                                        read(l => m_line_buf, value => m_character, good => m_err_check);
                                        m_data_int(width_a+width_b+1 downto 0) := m_data_int(width_a+width_b-1 downto 0) * "10" + to_unsigned(natural(BIN_STR_TO_INT(m_character)), 4);
                                    end loop;
                                when "dec" =>
                                    while ((m_line_buf(m_line_buf'low) /= ';') and (m_line_buf(m_line_buf'low) /= ' ') and
                                            (m_line_buf(m_line_buf'low) /= HT)) loop
                                        read(l => m_line_buf, value => m_character, good => m_err_check);
                                        m_data_int(width_a+width_b+3 downto 0) := m_data_int(width_a+width_b-1 downto 0) * "1010" + to_unsigned(natural(INT_STR_TO_INT(m_character)), 4);
                                    end loop;
                                when "uns" =>
                                    while ((m_line_buf(m_line_buf'low) /= ';') and (m_line_buf(m_line_buf'low) /= ' ') and
                                            (m_line_buf(m_line_buf'low) /= HT)) loop
                                        read(l => m_line_buf, value => m_character, good => m_err_check);
                                        m_data_int(width_a+width_b+3 downto 0) := m_data_int(width_a+width_b-1 downto 0) * "1010" + to_unsigned(natural(INT_STR_TO_INT(m_character)), 4);
                                    end loop;
                                when "oct" =>
                                    while ((m_line_buf(m_line_buf'low) /= ';') and (m_line_buf(m_line_buf'low) /= ' ') and
                                            (m_line_buf(m_line_buf'low) /= HT)) loop
                                        read(l => m_line_buf, value => m_character, good => m_err_check);
                                        m_data_int(width_a+width_b+3 downto 0) := m_data_int(width_a+width_b-1 downto 0) * "1000" + to_unsigned(natural(OCT_STR_TO_INT(m_character)), 4);
                                    end loop;
                                when others =>
                                    assert false
                                    report "Unsupported data_radix!"
                                    severity error;
                                end case;                           

                                if (use_a) then
                                    if (m_start_address_int /= m_end_address_int) then
                                        for i in m_start_address_int to m_end_address_int loop
                                            mem_data_a(i) := std_logic_vector(m_data_int(width_a-1 downto 0));
                                        end loop;
                                    else
                                        mem_data_a(m_address_int) := std_logic_vector(m_data_int(width_a-1 downto 0));
                                    end if;
                                else
                                    if (m_start_address_int /= m_end_address_int) then
                                        for i in m_start_address_int to m_end_address_int loop
                                            mem_data_b(i) := std_logic_vector(m_data_int(width_b-1 downto 0));
                                        end loop;
                                    else
                                        mem_data_b(m_address_int) := std_logic_vector(m_data_int(width_b-1 downto 0));
                                    end if;
                                end if;
                            exit LOOP2;
                        end if;                                
                    elsif ((m_line_buf(m_line_buf'low) = 'W') or (m_line_buf(m_line_buf'low) = 'w')) then
                        read(l=>m_line_buf, value=>m_string(1 to 5));

                        if (ALPHA_TOLOWER(m_string(1 to 5))  = "width") then
                            i := 0;

                            while ((m_line_buf(m_line_buf'low+i) = ' ') or (m_line_buf(m_line_buf'low+i) = HT)) loop
                                i := i+1;
                            end loop;
                           
                            if (m_line_buf(m_line_buf'low + i) = '=') then
                                i := i+1;
                            end if;

                            while ((m_line_buf(m_line_buf'low +i) = ' ') or (m_line_buf(m_line_buf'low +i) = HT)) loop
                                i := i+1;
                            end loop;
                                                           
                            SHRINK_LINE(m_line_buf, i);

                            i := 0;
                            while (m_line_buf(m_line_buf'low + i) /= ';') loop
                                i := i+1;
                            end loop;
                            
                            read(l=>m_line_buf, value=>m_string(1 to i));
                            
                            m_width := INT_STR_TO_INT(m_string(1 to i));
                        end if;
                        exit LOOP2;
                    elsif (((m_line_buf(m_line_buf'low) = 'D') or (m_line_buf(m_line_buf'low) = 'd')) and
                            ((m_line_buf(m_line_buf'low+1) = 'E') or (m_line_buf(m_line_buf'low+1) = 'e'))) then
                        read(l=>m_line_buf, value=>m_string(1 to 5));

                        if (ALPHA_TOLOWER(m_string(1 to 5))  = "depth") then
                            i := 0;

                            while ((m_line_buf(m_line_buf'low+i) = ' ') or (m_line_buf(m_line_buf'low+i) = HT)) loop
                                i := i+1;
                            end loop;
                           
                            if (m_line_buf(m_line_buf'low + i) = '=') then
                                i := i+1;
                            end if;

                            while ((m_line_buf(m_line_buf'low +i) = ' ') or (m_line_buf(m_line_buf'low +i) = HT)) loop
                                i := i+1;
                            end loop;
                                                           
                            SHRINK_LINE(m_line_buf, i);

                            i := 0;
                            while (m_line_buf(m_line_buf'low + i) /= ';') loop
                                i := i+1;
                            end loop;
                            
                            read(l=>m_line_buf, value=>m_string(1 to i));
                            
                            m_depth := INT_STR_TO_INT(m_string(1 to i));
                        end if;
                        exit LOOP2;
                    elsif ((m_line_buf(m_line_buf'low) = 'D') or (m_line_buf(m_line_buf'low) = 'd')) then
                        read(l=>m_line_buf, value=>m_string(1 to 10));

                        if (ALPHA_TOLOWER(m_string(1 to 10))  = "data_radix") then
                            i := 0;

                            while ((m_line_buf(m_line_buf'low+i) = ' ') or (m_line_buf(m_line_buf'low+i) = HT)) loop
                                i := i+1;
                            end loop;
                           
                            if (m_line_buf(m_line_buf'low + i) = '=') then
                                i := i+1;
                            end if;

                            while ((m_line_buf(m_line_buf'low+i) = ' ') or (m_line_buf(m_line_buf'low+i) = HT)) loop
                                i := i+1;
                            end loop;
                                                           
                            SHRINK_LINE(m_line_buf, i);

                            i := 0;
                            while (m_line_buf(m_line_buf'low + i) /= ';') loop
                                i := i+1;
                            end loop;
                            
                            read(l=>m_line_buf, value=>m_string(1 to 3));
                            
                            m_data_radix := ALPHA_TOLOWER(m_string(1 to 3));
                        end if;
                        exit LOOP2;
                    elsif ((m_line_buf(m_line_buf'low) = 'A') or (m_line_buf(m_line_buf'low) = 'a')) then
                        read(l=>m_line_buf, value=>m_string(1 to 13));

                        if (ALPHA_TOLOWER(m_string(1 to 13))  = "address_radix") then
                            i := 0;

                            while ((m_line_buf(m_line_buf'low+i) = ' ') or (m_line_buf(m_line_buf'low+i) = HT)) loop
                                i := i+1;
                            end loop;
                           
                            if (m_line_buf(m_line_buf'low + i) = '=') then
                                i := i+1;
                            end if;

                            while ((m_line_buf(m_line_buf'low+i) = ' ') or (m_line_buf(m_line_buf'low+i) = HT)) loop
                                i := i+1;
                            end loop;
                                                           
                            SHRINK_LINE(m_line_buf, i);

                            i := 0;
                            while (m_line_buf(m_line_buf'low + i) /= ';') loop
                                i := i+1;
                            end loop;
                            
                            read(l=>m_line_buf, value=>m_string(1 to 3));
                            
                            m_address_radix := ALPHA_TOLOWER(m_string(1 to 3));
                        end if;
                        exit LOOP2;
                    elsif ((m_line_buf(m_line_buf'low) = 'C') or (m_line_buf(m_line_buf'low) = 'c')) then
                        read(l=>m_line_buf, value=>m_string(1 to 7));
                        
                        if (ALPHA_TOLOWER(m_string(1 to 7))  = "content") then
                            found_keyword_content := true;
                        end if;
                    elsif ((m_line_buf(m_line_buf'low) = 'B') or (m_line_buf(m_line_buf'low) = 'b')) then
                        read(l=>m_line_buf, value=>m_string(1 to 5));
                        
                        if (ALPHA_TOLOWER(m_string(1 to 5))  = "begin") then
                            if (found_keyword_content = true) then
                                get_memory_content := true;
                            end if;
                        end if;
                    end if;
                end loop;
            end loop;
        
        else
            assert false
            report "Unsupported memory initialization file type (" & init_file(init_file'length -3 to init_file'length) & ")!"
            severity error;
        end if;
            file_close(m_mem_data_file);
    end read_my_memory;

end altsyncram;

-- END OF ENTITY

-- BEGINNING OF ARCHITECTURE

architecture translated of altsyncram is

    function is_lutram (ram_block_type : string) return boolean is
    begin
        if ((ram_block_type = "LUTRAM") or (ram_block_type = "MLAB")) then
            return true;
        else
            return false;
        end if;
    end is_lutram;
    
    function get_write_mode(read_during_write_mode_mixed_ports : string; device : string) return string is
    begin
        if (FEATURE_FAMILY_CYCLONE(device) or FEATURE_FAMILY_CYCLONEII(device)) then
            return "OLD_DATA";
        elsif (read_during_write_mode_mixed_ports = "UNUSED") or
            (read_during_write_mode_mixed_ports = "DONT_CARE") then
            return "DONT_CARE";
        end if;
        return read_during_write_mode_mixed_ports;
    end get_write_mode;

    function get_read_operation(operation_mode : string; port_name : string) return boolean is
    begin
        if (port_name = "A") then
            if ((operation_mode = "BIDIR_DUAL_PORT") or
                (operation_mode = "SINGLE_PORT") or (operation_mode= "ROM")) then
                return true;
            else
                return false;            
            end if;
        else
            if ((operation_mode = "BIDIR_DUAL_PORT") or
                (operation_mode = "DUAL_PORT")) then
                return true;
            else
                return false;
            end if; 
        end if;
    end get_read_operation;
    
    function get_write_operation(operation_mode : string; port_name : string) return boolean is
    begin
        if (port_name = "A") then
            if ((operation_mode = "BIDIR_DUAL_PORT") or
                (operation_mode = "SINGLE_PORT") or (operation_mode= "DUAL_PORT")) then
                return true;
            else
                return false;            
            end if;
        else
            if (operation_mode = "BIDIR_DUAL_PORT")  then
                return true;
            else
                return false;
            end if; 
        end if;
    end get_write_operation;
    
    function check_simultaneous(operation_mode : string; ram_type : string; cread : string) return boolean is
    begin
        if (operation_mode = "BIDIR_DUAL_PORT") then
            if ((ram_type = "MEGARAM") or (ram_type = "M-RAM") or 
                ((cread = "DONT_CARE") and (ram_type = "AUTO")) or
                ((cread = "NEW_DATA") and (is_lutram(ram_type)))) then
                return true;
            else
                return false;
            end if;
        else
            return false;
        end if;
    end check_simultaneous;
    
    function get_ram_block_type (intended_device_family : string; ram_block_type : string) return string is
    begin
        if (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) then
            if (((ram_block_type = "M-RAM") or (ram_block_type = "MEGARAM")) and FEATURE_FAMILY_STRATIXIII(intended_device_family)) then
                return "M144K";
            elsif ((((ram_block_type = "M144K") or (is_lutram(ram_block_type))) and FEATURE_FAMILY_STRATIXIII(intended_device_family)) or
                    (ram_block_type = "M9K")) then 
                return ram_block_type;
            else
                return "AUTO";
            end if;
        else
            if ((ram_block_type /= "AUTO") and (ram_block_type /= "M-RAM") and (ram_block_type /= "MEGARAM") and 
                    (ram_block_type /= "M512") and (ram_block_type /= "M4K")) then
                return "AUTO";
            else
                return ram_block_type;
            end if;
        end if;
    end get_ram_block_type;
    
    function get_byte_size (byte_size : integer; width_byteena_a : integer; width_a : integer; device_family : string) return integer is
    variable temp : integer;
    begin
        if ((byte_size = 0) and (width_byteena_a > 1)) then
            temp := width_a / width_byteena_a;
            
            if ((FEATURE_FAMILY_STRATIX(device_family) and (temp /= 8) and (temp /= 9)) or
                ((FEATURE_FAMILY_BASE_STRATIXII(device_family) or FEATURE_FAMILY_BASE_CYCLONEII(device_family)) and (temp /= 1) and (temp /= 2) and (temp /= 4)) or
                (FEATURE_FAMILY_STRATIXIII(device_family) and (temp /= 5) and (temp /= 10))) then
                return 8;
            else
                return temp;
            end if;
        elsif (byte_size = 0) then
            return 8;
        else
            return byte_size;
        end if;
    end get_byte_size;
    
    function get_write_edge (ram_block_type : string; device_family : string) return boolean is
    begin
        if ((ram_block_type = "M-RAM") or (ram_block_type = "MEGARAM") or
            (ram_block_type = "M9K") or (ram_block_type = "M144K") or
            ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(device_family) and (ram_block_type = "AUTO")))) then
            return true;
        else
            return false;
        end if;
    end get_write_edge;
    
    function get_numwords(numwords : integer; widthad : integer) return integer is
    begin
        if (numwords /= 0) then
            return numwords;
        else
            return (2 ** widthad);
        end if;
    end get_numwords;
    
    function is_lutram_single_port_fast_read(ram_block_type : string; read_during_write : string; operation_mode : string) return boolean is
    begin
        if ((is_lutram(ram_block_type)) and 
            ((read_during_write = "DONT_CARE") or ((outdata_reg_a = "UNREGISTERED") AND 
            (operation_mode = "SINGLE_PORT")))) then
            return true;
        else
            return false;
        end if;
    end is_lutram_single_port_fast_read;
    
    function is_lutram_dual_port_fast_read (ram_block_type : string; read_during_write_mixed_ports : string; address_reg_b : string; operation_mode : string) return boolean is
    begin
        if ((is_lutram(ram_block_type)) and 
            (operation_mode = "DUAL_PORT") and
            ((read_during_write_mixed_ports = "NEW_DATA") or 
            (read_during_write_mixed_ports = "DONT_CARE") or
            ((read_during_write_mixed_ports = "OLD_DATA") and (outdata_reg_b = "UNREGISTERED")))) then
            return true;
        else
            return false;
        end if;
    end is_lutram_dual_port_fast_read;
    
    function get_rden_reg_initial_value(device : string) return std_logic is
    begin
        if (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) then
            return '0';
        else
            return '1';
        end if;
    end get_rden_reg_initial_value;
    

-- CONSTANT DECLARATION
    constant i_is_lutram : boolean := is_lutram(ram_block_type);

    constant i_ram_block_type : string := get_ram_block_type(intended_device_family, ram_block_type);
    
    constant cread_during_write_mode_mixed_ports :  string  := get_write_mode(read_during_write_mode_mixed_ports, intended_device_family);

    constant read_operation_a : boolean := get_read_operation(operation_mode, "A");
    
    constant write_operation_a : boolean := get_write_operation(operation_mode, "A");
    
    constant read_operation_b : boolean := get_read_operation(operation_mode, "B");
    
    constant write_operation_b : boolean := get_write_operation(operation_mode, "B");

    constant check_simultaneous_read_write : boolean := check_simultaneous(operation_mode, ram_block_type, cread_during_write_mode_mixed_ports);

    constant i_byte_size : integer := get_byte_size(byte_size, width_byteena_a, width_a, intended_device_family);
    
    constant is_write_positive_edge : boolean := get_write_edge(i_ram_block_type, intended_device_family);
    
    constant i_numwords_a : integer := get_numwords(numwords_a, widthad_a);
    
    constant i_numwords_b : integer := get_numwords(numwords_b, widthad_b);
    
    constant i_lutram_single_port_fast_read : boolean := is_lutram_single_port_fast_read(ram_block_type, read_during_write_mode_port_a, operation_mode);    
    
    constant i_lutram_dual_port_fast_read : boolean := is_lutram_dual_port_fast_read(ram_block_type, read_during_write_mode_mixed_ports, address_reg_b, operation_mode);
    
    constant rden_reg_initial_value : std_logic := get_rden_reg_initial_value(intended_device_family);
		
		
    

-- SIGNAL DECLARATION

    signal i_data_reg_a             : std_logic_vector(width_a - 1 downto 0) := (others => '0');
    signal i_data_reg_b             : std_logic_vector(width_b - 1 downto 0) := (others => '0');

    signal i_q_reg_a                : std_logic_vector(width_a - 1 downto 0) := (others => '0');
    signal i_q_tmp_a                : std_logic_vector(width_a - 1 downto 0) := (others => '0');
    signal i_q_tmp2_a               : std_logic_vector(width_a - 1 downto 0) := (others => '0');
    signal i_q_tmp_wren_a           : std_logic_vector(width_a - 1 downto 0) := (others => '0');
    signal i_q_tmp2_wren_a          : std_logic_vector(width_a - 1 downto 0) := (others => '0');
    signal i_q_tmp_wren_b           : std_logic_vector(width_b - 1 downto 0) := (others => '0');
    signal i_q_reg_b                : std_logic_vector(width_b - 1 downto 0) := (others => '0');
    signal i_q_tmp_b                : std_logic_vector(width_b - 1 downto 0) := (others => '0');
    signal i_q_tmp2_b               : std_logic_vector(width_b - 1 downto 0) := (others => '0');
    signal i_q_output_latch         : std_logic_vector(width_b - 1 downto 0) := (others => '0');
    
    signal i_current_written_data_a       : std_logic_vector(width_a - 1 downto 0) := (others => '0');
    signal i_original_data_a              : std_logic_vector(width_a - 1 downto 0) := (others => '0');
    signal i_original_data_b              : std_logic_vector(width_b - 1 downto 0) := (others => '0');

    signal i_byteena_mask_reg_a           : std_logic_vector(width_a - 1 downto 0) := (others => '1');
    signal i_byteena_mask_reg_b           : std_logic_vector(width_b - 1 downto 0) := (others => '1');
    signal i_byteena_mask_reg_a_out       : std_logic_vector(width_a - 1 downto 0) := (others => '1');
    signal i_byteena_mask_reg_b_out       : std_logic_vector(width_b - 1 downto 0) := (others => '1');
    signal i_byteena_mask_reg_a_x         : std_logic_vector(width_a - 1 downto 0) := (others => '0');
    signal i_byteena_mask_reg_b_x         : std_logic_vector(width_b - 1 downto 0) := (others => '0');
    signal i_byteena_mask_reg_a_out_b     : std_logic_vector(width_a - 1 downto 0) := (others => '1');
    signal i_byteena_mask_reg_b_out_a     : std_logic_vector(width_b - 1 downto 0) := (others => '1');
    
    signal i_address_reg_a          : std_logic_vector(widthad_a - 1 downto 0) := (others => '0');
    signal i_address_reg_b          : std_logic_vector(widthad_b - 1 downto 0) := (others => '0');

    signal i_wren_reg_a             : std_logic := '0';
    signal i_wren_reg_b             : std_logic := '0';
    signal i_rden_reg_a             : std_logic := rden_reg_initial_value;
    signal i_rden_reg_b             : std_logic := rden_reg_initial_value;
    signal i_read_flag_a            : std_logic := '0';
    signal i_read_flag_b            : std_logic := '0';
    signal i_reread_flag_a          : std_logic := '0';
    signal i_reread_flag_b          : std_logic := '0';
    signal i_reread_flag2_a         : std_logic := '0';
    signal i_reread_flag2_b         : std_logic := '0';
    signal i_write_flag_a           : std_logic := '0';
    signal i_write_flag_b           : std_logic := '0';
    signal i_nmram_write_a          : std_logic := '0';
    signal i_nmram_write_b          : std_logic := '0';

    signal i_indata_aclr_a          : std_logic := '0';
    signal i_address_aclr_a         : std_logic := '0';
    signal i_wrcontrol_aclr_a       : std_logic := '0';
    signal i_indata_aclr_b          : std_logic := '0';
    signal i_address_aclr_b         : std_logic := '0';
    signal i_wrcontrol_aclr_b       : std_logic := '0';
    signal i_outdata_aclr_a         : std_logic := '0';
    signal i_outdata_aclr_b         : std_logic := '0';
    signal i_rdcontrol_aclr_b       : std_logic := '0';
    signal i_byteena_aclr_a         : std_logic := '0';
    signal i_byteena_aclr_b         : std_logic := '0';

    signal good_to_go_a             : std_logic := '0';
    signal good_to_go_b             : std_logic := '0';

    signal i_core_clocken_a         : std_logic := '1';
    signal i_core_clocken_b         : std_logic := '1';
    signal i_core_clocken_b0        : std_logic := '1';
    signal i_core_clocken_b1        : std_logic := '1';
    signal i_inclocken0             : std_logic := '0';
    signal i_input_clocken_b        : std_logic := '0';
    signal i_outdata_clken_b        : std_logic := '0';
    signal i_outdata_clken_a        : std_logic := '0';

    signal default_val              : std_logic := '0';

    signal i_data_zero_a : std_logic_vector (width_a - 1 downto 0) := (others => '0');
    signal i_data_zero_b : std_logic_vector (width_b - 1 downto 0) := (others => '0');
    signal i_data_ones_a : std_logic_vector (width_a - 1 downto 0) := (others => '1');
    signal i_data_ones_b : std_logic_vector (width_b - 1 downto 0) := (others => '1');

    signal same_clock_pulse : std_logic := '0';
    
    signal i_force_reread_a : std_logic := '0';
    signal i_force_reread_b : std_logic := '0';
    signal i_force_reread_signal_a : std_logic := '0';
    signal i_force_reread_signal_b : std_logic := '0';
    
    signal i_good_to_write_a : std_logic := '1';
    signal i_good_to_write_b : std_logic := '1';


begin


    -- Parameter Checking
    process
    begin
        if ((operation_mode /= "BIDIR_DUAL_PORT") and (operation_mode /= "SINGLE_PORT") and
            (operation_mode /= "DUAL_PORT") and (operation_mode /= "ROM")) then
            assert false
            report "Error: Not a valid operation mode."
            severity error;
        end if;

        if ((ram_block_type /= "M4K") and (ram_block_type /= "M512") and
            (ram_block_type /= "LARGE") and (ram_block_type /= "MEGARAM") and
            (ram_block_type /= "M-RAM") and (ram_block_type /= "AUTO") and
            (ram_block_type /= "M9K") and (ram_block_type /= "M144K") and
            (not i_is_lutram)) then
            assert false
            report "Error: RAM_BLOCK_TYPE has an invalid value. It can only be M512, M4K, M-RAM or AUTO"
            severity error;
        end if;
        
        if (ram_block_type /= i_ram_block_type) then
            assert false
            report "Warning: RAM block type is assumed as " & i_ram_block_type
            severity warning;
        end if;
        
        if ((cread_during_write_mode_mixed_ports /= "DONT_CARE") and
            (cread_during_write_mode_mixed_ports /= "OLD_DATA") and
            (cread_during_write_mode_mixed_ports /= "NEW_DATA")) then
            assert false
            report "Error: Invalid value for READ_DURING_WRITE_MODE_MIXED_PORTS parameter. It has to be OLD_DATA or DONT_CARE or NEW_DATA"
            severity error;
        end if;
        
        if (read_during_write_mode_mixed_ports /= cread_during_write_mode_mixed_ports) then
            assert false
            report "Warning: READ_DURING_WRITE_MODE_MIXED_PORTS is assumed as " & cread_during_write_mode_mixed_ports
            severity warning;
        end if;

        if (((i_ram_block_type = "M-RAM") or (i_ram_block_type = "MEGARAM")) and
            (init_file /= "UNUSED")) then
            assert false
            report "Error: M-RAM block type doesn't support the use of an initialization file"
            severity error;
        end if;
        
        if ((i_byte_size /= 8) and (i_byte_size /= 9) and 
            (not FEATURE_FAMILY_BASE_STRATIXII(intended_device_family))) then
            assert false
            report "Error: BYTE_SIZE has to be either 8 or 9"
            severity error;
        end if;

        if ((i_byte_size /= 8) and (i_byte_size /= 9) and 
            (i_byte_size /= 1) and (i_byte_size /= 2) and (i_byte_size /= 4) and 
            (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))) then
            assert false
            report "Error: BYTE_SIZE has to be either 1, 2, 4, 8 or 9"
            severity error;
        end if;
        
        if ((i_byte_size /= 8) and (i_byte_size /= 9) and 
            (i_byte_size /= 5) and (i_byte_size /= 10) and 
            (FEATURE_FAMILY_STRATIXIII(intended_device_family))) then
            assert false
            report "Error: BYTE_SIZE has to be either 5, 8, 9 or 10"
            severity error;
        end if;

        if (width_a <= 0) then
            assert false
            report "Error: Invalid value for WIDTH_A parameter"
            severity error;
        end if;

        if ((width_b <= 0) and
            ((operation_mode /= "SINGLE_PORT") or (operation_mode /= "ROM"))) then
            assert false
            report "Error: Invalid value for WIDTH_B parameter"
            severity error;
        end if;

        if (widthad_a <= 0) then
            assert false
            report "Error: Invalid value for WIDTHAD_A parameter"
            severity error;
        end if;

        if ((width_b <= 0) and
            ((operation_mode /= "SINGLE_PORT") or (operation_mode /= "ROM"))) then
            assert false
            report "Error: Invalid value for WIDTHAD_B parameter"
            severity error;
        end if;

        if ((operation_mode = "ROM") and
            ((i_ram_block_type = "M-RAM") or (i_ram_block_type = "MEGARAM"))) then
            assert false
            report "Error: ROM mode does not support ram_block_type = M-RAM"
            severity error;
        end if;
        
        if ((FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family)) and
            (((indata_aclr_a /= "UNUSED") and (indata_aclr_a /= "NONE")) or
            ((wrcontrol_aclr_a /= "UNUSED") and (wrcontrol_aclr_a /= "NONE")) or
            ((byteena_aclr_a  /= "UNUSED") and (byteena_aclr_a /= "NONE")) or
            ((address_aclr_a /= "UNUSED") and (address_aclr_a /= "NONE")) or
            ((indata_aclr_b /= "UNUSED") and (indata_aclr_b /= "NONE")) or
            ((rdcontrol_aclr_b /= "UNUSED") and (rdcontrol_aclr_b /= "NONE")) or
            ((wrcontrol_aclr_b /= "UNUSED") and (wrcontrol_aclr_b /= "NONE")) or
            ((byteena_aclr_b /= "UNUSED") and (byteena_aclr_b /= "NONE")) or
            ((address_aclr_b /= "UNUSED") and (address_aclr_b /= "NONE")))) then
            assert false
            report "Warning: " & intended_device_family & " device family does not support aclr signal on input ports. The aclr to input ports will be ignored."
            severity warning;
        end if;

        if ((not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))
            and (read_during_write_mode_port_a /= "NEW_DATA_NO_NBE_READ")) then
            assert false
            report "Warning: " & read_during_write_mode_port_a & " value for read_during_write_mode_port_a is not supported in " & intended_device_family & " device family, it might cause incorrect behavioural simulation result"
            severity warning;
        end if;

        if ((not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))
            and (read_during_write_mode_port_b /= "NEW_DATA_NO_NBE_READ")) then
            assert false
            report "Warning: " & read_during_write_mode_port_b & " value for read_during_write_mode_port_b is not supported in " & intended_device_family & " device family, it might cause incorrect behavioural simulation result"
            severity warning;
        end if;
        
        if (not (i_is_lutram or ((i_ram_block_type = "AUTO") and (FEATURE_FAMILY_HAS_LUTRAM(intended_device_family)))) and 
            (operation_mode /= "SINGLE_PORT") and (read_during_write_mode_port_a = "DONT_CARE")) then
            assert false
            report "Error: " & read_during_write_mode_port_a & " value for read_during_write_mode_port_a is not supported in " & 
                    intended_device_family & " device family for " & ram_block_type & " ram block type in " & operation_mode & " operation mode"
            severity error;
        end if;
        
        if ((not i_is_lutram) and (cread_during_write_mode_mixed_ports = "NEW_DATA")) then
            assert false
            report "Warning : read_during_write_mode_mixed_ports cannot be set to NEW_DATA for non-LUTRAM ram block type. This will cause incorrect simulation result."
            severity warning;
        end if;

        if ((operation_mode = "DUAL_PORT") and (outdata_reg_b /= "CLOCK0") and (i_is_lutram)) then
            assert false
            report "Warning: Value for read_during_write_mode_mixed_ports is not honoured in " & operation_mode & " operation mode when output registers are not clocked by clock0 for ram_block_type LUTRAM"
            severity warning;
        end if;
        
        if ((i_is_lutram) and (operation_mode = "BIDIR_DUAL_PORT")) then
            assert false
            report "Error: LUTRAM RAM block type does not support BIDIR_DUAL_PORT operation mode"
            severity error;
        end if;
        
        if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (indata_aclr_a /= "NONE") and (indata_aclr_a /= "UNUSED")) then
            assert false
            report "Warning : " & indata_aclr_a & "value for indata_aclr_a is not supported in " & intended_device_family & " device family. The aclr to data_a registers will be ignored."
            severity warning;
        end if;

        if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (wrcontrol_aclr_a /= "NONE") and (wrcontrol_aclr_a /= "UNUSED")) then
            assert false
            report "Warning : " & wrcontrol_aclr_a & " value for wrcontrol_aclr_a is not supported in " & intended_device_family & " device family. The aclr to data_a registers will be ignored."
            severity warning;
        end if;

        if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (byteena_aclr_a /= "NONE") and (byteena_aclr_a /= "UNUSED")) then
            assert false
            report "Warning : " & byteena_aclr_a & " value for byteena_aclr_a is not supported in " & intended_device_family & " device family. The aclr to data_a registers will be ignored."
            severity warning;
        end if;

        if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (address_aclr_a /= "NONE") and (address_aclr_a /= "UNUSED") and (operation_mode /= "ROM")) then
            assert false
            report "Warning : " & address_aclr_a & " value for address_aclr_a is not supported for write port in " & intended_device_family & " device family. The aclr to data_a registers will be ignored."
            severity warning;
        end if;

        if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (indata_aclr_b /= "NONE") and (indata_aclr_b /= "UNUSED")) then
            assert false
            report "Warning : " & indata_aclr_b & " value for indata_aclr_b is not supported in " & intended_device_family & " device family. The aclr to data_a registers will be ignored."
            severity warning;
        end if;

        if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (rdcontrol_aclr_b /= "NONE") and (rdcontrol_aclr_b /= "UNUSED")) then
            assert false
            report "Warning : " & rdcontrol_aclr_b & " value for rdcontrol_aclr_b is not supported in " & intended_device_family & " device family. The aclr to data_a registers will be ignored."
            severity warning;
        end if;

        if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (wrcontrol_aclr_b /= "NONE") and (wrcontrol_aclr_b /= "UNUSED")) then
            assert false
            report "Warning : " & wrcontrol_aclr_b & " value for wrcontrol_aclr_b is not supported in " & intended_device_family & " device family. The aclr to data_a registers will be ignored."
            severity warning;
        end if;

        if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (byteena_aclr_b /= "NONE") and (byteena_aclr_b /= "UNUSED")) then
            assert false
            report "Warning : " & byteena_aclr_b & " value for byteena_aclr_b is not supported in " & intended_device_family & " device family. The aclr to data_a registers will be ignored."
            severity warning;
        end if;

        if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (address_aclr_b /= "NONE") and (address_aclr_b /= "UNUSED") and (operation_mode = "BIDIR_DUAL_PORT")) then
            assert false
            report "Warning : " & address_aclr_b & " value for address_aclr_b is not supported for write port in " & intended_device_family & " device family. The aclr to data_a registers will be ignored."
            severity warning;
        end if;

        if ((i_is_lutram) and (address_aclr_b /= "NONE") and (address_aclr_b /= "UNUSED") and (operation_mode = "DUAL_PORT") and (cread_during_write_mode_mixed_ports = "OLD_DATA")) then
            assert false
            report "Warning : aclr signal for address_b is ignored for RAM block type " & ram_block_type & " when read_during_write_mode_mixed_ports is set to OLD_DATA"
            severity warning;
        end if;
        
        if (((not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) and 
            ((clock_enable_core_a /= "USE_INPUT_CLKEN") and
            (clock_enable_core_a /= clock_enable_input_a))) then
            assert false
            report "Warning: clock_enable_core_a value must be 'USE_INPUT_CLKEN' or same as clock_enable_input_a in " & intended_device_family & " device family. It will be set to follow clock_enable_input_a value."
            severity warning;
        end if;

        if (((not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) and 
            ((clock_enable_core_b /= "USE_INPUT_CLKEN") and (clock_enable_core_b /= clock_enable_input_b))) then
            assert false
            report "Warning: clock_enable_core_b value must be 'USE_INPUT_CLKEN' or same as clock_enable_input_b in " & intended_device_family & " device family. It will be set to follow clock_enable_input_b value."
            severity warning;
        end if;
        
        if ((not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and
            (clock_enable_input_a = "ALTERNATE")) then
            assert false
            report "Error: ALTERNATE value for clock_enable_input_a is not supported in " & intended_device_family
            severity error;
        end if;
        
        if ((not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and
            (clock_enable_input_b = "ALTERNATE")) then
            assert false
            report "Error: ALTERNATE value for clock_enable_input_b is not supported in " & intended_device_family
            severity error;
        end if;

        if ((i_ram_block_type /= "M144K") and (operation_mode /= "DUAL_PORT") and ((enable_ecc /= "FALSE") and (enable_ecc /= "NONE"))) then
            assert false
            report "Warning: " & enable_ecc & " value for enable_ecc is not supported in " & ram_block_type & " ram block type for " & intended_device_family & " device family in " & operation_mode & " operation mode."
            severity warning;
        end if;
        
        if ((cread_during_write_mode_mixed_ports = "OLD_DATA") and (enable_ecc = "TRUE") and (i_ram_block_type = "M144K")) then
            assert false
            report "Error : ECC is not supported for read-before-write mode."
            severity error;
        end if;

        if (((wrcontrol_aclr_a /= "NONE") and (wrcontrol_aclr_a /= "UNUSED")) and (i_ram_block_type = "M512") and (operation_mode = "SINGLE_PORT")) then
            assert false
            report "Error: Wren_a cannot have clear in single port mode for M512 block"
            severity error;
        end if;

        if ((operation_mode = "DUAL_PORT") and (numwords_a * width_a /= numwords_b * width_b)) then
            assert false
            report "Error: Total number of bits of port A and port B should be the same for dual port mode"
            severity error;
        end if;

        if (((rdcontrol_aclr_b /= "NONE") and (rdcontrol_aclr_b /= "UNUSED")) and (i_ram_block_type = "M512") and (operation_mode = "DUAL_PORT")) then
            assert false
            report "Error: rden_b cannot have clear in simple dual port mode for M512 block"
            severity error;
        end if;

        if ((operation_mode = "BIDIR_DUAL_PORT") and (numwords_a * width_a /= numwords_b * width_b)) then
            assert false
            report "Error: Total number of bits of port A and port B should be the same for bidir dual port mode"
            severity error;
        end if;

        if ((operation_mode = "BIDIR_DUAL_PORT") and (i_ram_block_type = "M512")) then
            assert false
            report "Error: M512 block type doesn't support bidir dual mode"
            severity error;
        end if;

        if (((i_ram_block_type = "M-RAM") or (i_ram_block_type = "MEGARAM")) and
            (cread_during_write_mode_mixed_ports = "OLD_DATA")) then
            assert false
            report "Error: M-RAM doesn't support OLD_DATA value for READ_DURING_WRITE_MODE_MIXED_PORTS parameter"
            severity error;
        end if;

        if  ((not FEATURE_FAMILY_HAS_STRATIXII_STYLE_RAM(intended_device_family)) and
            (clock_enable_input_a = "BYPASS")) then
            assert false
            report "Error: BYPASS value for CLOCK_ENABLE_INPUT_A is not supported in "& intended_device_family &" device family"
            severity error;
        end if;
        if  ((not FEATURE_FAMILY_HAS_STRATIXII_STYLE_RAM(intended_device_family)) and
            (clock_enable_output_a = "BYPASS")) then
            assert false
            report "Error: BYPASS value for CLOCK_ENABLE_OUTPUT_A is not supported in "& intended_device_family &" device family"
            severity error;
        end if;
        if  ((not FEATURE_FAMILY_HAS_STRATIXII_STYLE_RAM(intended_device_family)) and
            (clock_enable_input_b = "BYPASS")) then
            assert false
            report "Error: BYPASS value for CLOCK_ENABLE_INPUT_B is not supported in "& intended_device_family &" device family"
            severity error;
        end if;

        if  ((not FEATURE_FAMILY_HAS_STRATIXII_STYLE_RAM(intended_device_family)) and
            (clock_enable_output_b = "BYPASS")) then
            assert false
            report "Error: BYPASS value for CLOCK_ENABLE_OUTPUT_B is not supported in "& intended_device_family &" device family"
            severity error;
        end if;

        if ((implement_in_les /= "OFF") and (implement_in_les /= "ON")) then
            assert false
            report "Error: Illegal parameter value for implement_in_les"
            severity error;
        end if;

        if ((not FEATURE_FAMILY_HAS_M512(intended_device_family)) and (i_ram_block_type = "M512")) then
            assert false
            report "Error: M512 as ram_block_type is not supported in "& intended_device_family &" device family"
            severity error;
        end if;
        
        if ((not FEATURE_FAMILY_HAS_MEGARAM(intended_device_family)) and (i_ram_block_type = "MEGARAM")) then
            assert false
            report "Error: MEGARAM as ram_block_type is not supported in "& intended_device_family &" device family"
            severity error;
        end if;
        
        if ((rdcontrol_reg_b /= address_reg_b) or (indata_reg_b /= address_reg_b) or
            (wrcontrol_wraddress_reg_b /= address_reg_b) or (byteena_reg_b /= address_reg_b)) then
            assert false
            report "Warning: Port B will take the address_reg_b parameter as reference clock source for Port B, which is " & address_reg_b
            severity warning;
        end if;
                
        wait;

    end process;


-- SIGNAL ASSIGNMENTS

    -- Checking for same clock phase
    process (clock0, clock1)
    begin
        if ((rising_edge(clock0) and rising_edge(clock1)) or
            (falling_edge(clock0) and falling_edge(clock1)) or 
            (address_reg_b = "CLOCK0"))  then
            same_clock_pulse <= '1';
        else
            same_clock_pulse <= '0';
        end if;
    end process;


    -- Checking ram_block_type and setting default_val
    IFG01: if ((((i_ram_block_type = "AUTO") and
                (cread_during_write_mode_mixed_ports = "DONT_CARE")) or
                (i_ram_block_type = "MEGARAM") or
                (i_ram_block_type = "M-RAM")) and
                (operation_mode /= "ROM") and 
                not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) generate
        default_val <= 'X';
    end generate IFG01;

    IFG02: if (not ((((i_ram_block_type = "AUTO") and
                (cread_during_write_mode_mixed_ports = "DONT_CARE")) or
                (i_ram_block_type = "MEGARAM") or
                (i_ram_block_type = "M-RAM")) and
                (operation_mode /= "ROM") and 
                not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)))) generate
        default_val <= '0';
    end generate IFG02;


    -- Assigning the correct clock enable signals based on the input clock
    
    -- for input ports in a
    IFG03: if (clock_enable_input_a = "NORMAL") generate
        i_inclocken0 <= clocken0;
    end generate IFG03;
    IFG03a: if (clock_enable_input_a = "BYPASS") generate
        i_inclocken0 <= '1';
    end generate IFG03a;
    IFG03b: if (clock_enable_input_a = "ALTERNATE") generate
        i_inclocken0 <= clocken2;
    end generate IFG03b;

    -- for input ports in b
    IFG14: if ((address_reg_b = "CLOCK0") and (clock_enable_input_b = "NORMAL")) generate
        i_input_clocken_b <= clocken0;
    end generate IFG14;
    IFG14b: if ((address_reg_b = "CLOCK0") and (clock_enable_input_b = "ALTERNATE")) generate
        i_input_clocken_b <= clocken2;
    end generate IFG14b;
    IFG14a: if (clock_enable_input_b = "BYPASS") generate
        i_input_clocken_b <= '1';
    end generate IFG14a;
    IFG15: if ((address_reg_b = "CLOCK1") and (clock_enable_input_b = "NORMAL")) generate
        i_input_clocken_b <= clocken1;
    end generate IFG15;
    IFG14c: if ((address_reg_b = "CLOCK1") and (clock_enable_input_b = "ALTERNATE")) generate
        i_input_clocken_b <= clocken3;
    end generate IFG14c;

    -- for data out a
    IFG171: if ((outdata_reg_a = "CLOCK0") and (clock_enable_output_a = "NORMAL")) generate
        i_outdata_clken_a <= clocken0;
    end generate IFG171;
    IFG172: if  (clock_enable_output_a = "BYPASS") generate
        i_outdata_clken_a <= '1';
    end generate IFG172;
    IFG173 : if ((outdata_reg_a = "CLOCK1") and (clock_enable_output_a = "NORMAL")) generate
        i_outdata_clken_a <= clocken1;
    end generate IFG173;

    -- for data out b
    IFG17: if ((outdata_reg_b = "CLOCK0") and (clock_enable_output_b = "NORMAL")) generate
        i_outdata_clken_b <= clocken0;
    end generate IFG17;
    IFG17a: if  (clock_enable_output_b = "BYPASS") generate
        i_outdata_clken_b <= '1';
    end generate IFG17a;
    IFG18 : if ((outdata_reg_b = "CLOCK1") and (clock_enable_output_b = "NORMAL")) generate
        i_outdata_clken_b <= clocken1;
    end generate IFG18;

    -- for core clock a
    IFG50a: if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (clock_enable_core_a = "USE_INPUT_CLKEN")) generate
        i_core_clocken_a <= i_inclocken0;
    end generate IFG50a;
    IFG50b: if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (clock_enable_core_a = "ALTERNATE")) generate
        i_core_clocken_a <= clocken2;
    end generate IFG50b;
    IFG50d: if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (clock_enable_core_a = "BYPASS")) generate
        i_core_clocken_a <= '1';
    end generate IFG50d;
    IFG50c: if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (clock_enable_core_a = "NORMAL")) generate
        i_core_clocken_a <= clocken0;
    end generate IFG50c;
    IFG50e: if (not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) generate
        i_core_clocken_a <= i_inclocken0;
    end generate IFG50e;

    -- for core clock b 
    IFG51a: if (((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (clock_enable_core_b = "USE_INPUT_CLKEN")) or
                (not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) generate
        i_core_clocken_b0 <= i_input_clocken_b;
        i_core_clocken_b1 <= i_input_clocken_b;
    end generate IFG51a;
    IFG51e: if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (clock_enable_core_b = "NORMAL")) generate
        i_core_clocken_b0 <= clocken0;
        i_core_clocken_b1 <= clocken1;
    end generate IFG51e;
    IFG51b: if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (clock_enable_core_b = "ALTERNATE")) generate
        i_core_clocken_b0 <= clocken2;
        i_core_clocken_b1 <= clocken3;
    end generate IFG51b;
    IFG51c: if ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and (clock_enable_core_b = "BYPASS")) generate
        i_core_clocken_b0 <= '1';
        i_core_clocken_b1 <= '1';
    end generate IFG51c;
    IFG52a: if (address_reg_b = "CLOCK0") generate
        i_core_clocken_b <= i_core_clocken_b0;
    end generate IFG52a;
    IFG52b: if (address_reg_b = "CLOCK1") generate
        i_core_clocken_b <= i_core_clocken_b1;
    end generate IFG52b;



    -- Assigning the correct clear signals

    -- for data in a
    IFG20: if ((indata_aclr_a = "CLEAR0") and (not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) or
                (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))))) generate
        i_indata_aclr_a <= aclr0;
    end generate IFG20;

    -- for address a
    IFG22: if ((address_aclr_a = "CLEAR0") and 
                (not ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) and (operation_mode /= "ROM")) or
                (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))))) generate
        i_address_aclr_a <= aclr0;
    end generate IFG22;

    -- for wren a
    IFG24: if ((wrcontrol_aclr_a = "CLEAR0") and (not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) or
                (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))))) generate
        i_wrcontrol_aclr_a <= aclr0;
    end generate IFG24;

    -- for byteena a
    IFG26: if ((byteena_aclr_a = "CLEAR0") and (not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) or
                (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))))) generate
        i_byteena_aclr_a <= aclr0;
    end generate IFG26;
    IFG27: if ((byteena_aclr_a = "CLEAR1") and (not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) or
                (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))))) generate
        i_byteena_aclr_a <= aclr1;
    end generate IFG27;

    -- for data out a
    IFG29: if (outdata_aclr_a = "CLEAR0") generate
        i_outdata_aclr_a <= aclr0;
    end generate IFG29;
    IFG30: if (outdata_aclr_a = "CLEAR1") generate
        i_outdata_aclr_a <= aclr1;
    end generate IFG30;

    -- for data out b
    IFG31a: if (outdata_aclr_b = "CLEAR0") generate
        i_outdata_aclr_b <= aclr0;
    end generate IFG31a;
    IFG31b: if (outdata_aclr_b = "CLEAR1") generate
        i_outdata_aclr_b <= aclr1;
    end generate IFG31b;
    
    -- for data in b
    IFG32: if ((indata_aclr_b = "CLEAR0") and (not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) or
                (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))))) generate
        i_indata_aclr_b <= aclr0;
    end generate IFG32;
    IFG33: if ((indata_aclr_b = "CLEAR1") and (not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) or
                (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))))) generate
        i_indata_aclr_b <= aclr1;
    end generate IFG33;

    -- for address b
    IFG35: if ((address_aclr_b = "CLEAR0") and 
                not (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family)) and
                not (FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family)) and
                not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) generate
        i_address_aclr_b <= aclr0;
    end generate IFG35;
    IFG35a: if ((address_aclr_b = "CLEAR0") and (operation_mode = "DUAL_PORT") and
                (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) generate
        i_address_aclr_b <= aclr0;
    end generate IFG35a;
    IFG36: if ((address_aclr_b = "CLEAR1") and 
                not (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family)) and
                not (FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family)) and
                not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) generate
        i_address_aclr_b <= aclr1;
    end generate IFG36;
    IFG36a: if ((address_aclr_b = "CLEAR1") and (operation_mode = "DUAL_PORT") and
                (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) generate
        i_address_aclr_b <= aclr1;
    end generate IFG36a;

    -- for wren b
    IFG38:if ((wrcontrol_aclr_b = "CLEAR0") and (not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) or
            (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))))) generate
        i_wrcontrol_aclr_b <= aclr0;
    end generate IFG38;
    IFG39: if ((wrcontrol_aclr_b = "CLEAR1") and (not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) or
            (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))))) generate
        i_wrcontrol_aclr_b <= aclr1;
    end generate IFG39;

    -- for rden b
    IFG41: if ((rdcontrol_aclr_b = "CLEAR0") and (not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) or
            (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))))) generate
        i_rdcontrol_aclr_b <= aclr0;
    end generate IFG41;
    IFG42: if ((rdcontrol_aclr_b = "CLEAR1") and (not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) or
            (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))))) generate
        i_rdcontrol_aclr_b <= aclr1;
    end generate IFG42;

    -- for byteena b
    IFG44: if ((byteena_aclr_b = "CLEAR0") and (not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) or
            (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))))) generate
        i_byteena_aclr_b <= aclr0;
    end generate IFG44;
    IFG45: if ((byteena_aclr_b = "CLEAR1") and (not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) or
            (FEATURE_FAMILY_BASE_STRATIXII(intended_device_family) or FEATURE_FAMILY_BASE_CYCLONEII(intended_device_family))))) generate
        i_byteena_aclr_b <= aclr1;
    end generate IFG45;

  

    -- This process initializes and updates the memory content in the RAM accordingly
    MEMORY: process (i_read_flag_a, i_write_flag_a, i_read_flag_b, i_write_flag_b, default_val, i_reread_flag_a, i_reread_flag_b, i_reread_flag2_a, i_reread_flag2_b)

        variable j : integer := 0;
        variable port_a_bit_count_low : integer := 0;
        variable port_a_bit_count_high : integer := 0;
        variable port_b_bit_count_low : integer := 0;
        variable port_b_bit_count_high : integer := 0;
        variable i_byteena_count : integer := 0;
        variable m_mem_data_a : width_a_array;
        variable m_mem_data_b : width_b_array;
        variable m_temp_wa : std_logic_vector(width_a - 1 downto 0);
        variable m_temp_wa2 : std_logic_vector(width_a - 1 downto 0) := (others => 'U');
        variable m_temp_wa3 : std_logic_vector(width_a - 1 downto 0);
        variable m_temp_wb : std_logic_vector(width_b - 1 downto 0);
        variable m_temp_wb2 : std_logic;
        variable m_init_file_b_port : boolean := false;
        variable m_temp_wb3 : std_logic_vector(width_a - 1 downto 0);
        variable m_current_written_data_b : std_logic_vector(width_b - 1 downto 0);

        variable m_address_a : integer := 0;
        variable m_address_b : integer := 0;
        variable m_original_address_a : integer := 0;
        variable m_data_write_time_a : time := 0 ps;
        variable m_q_tmp2_a : std_logic_vector(width_a - 1 downto 0);
        variable write_by_a      : integer := 0;
        variable prev_write_by_a : integer := 0;

        variable write_by_b      : integer := 0;
        variable prev_write_by_b : integer := 0;

        variable ctime : time := 0 ps;
        variable reread_a        : boolean := false;
        variable reread_b        : boolean := false;
        variable last_read_a_event : boolean := false;
        variable last_read_b_event : boolean := false;
        variable need_init_var : boolean := true;
        variable m_current_written_data_a : std_logic_vector(width_a - 1 downto 0);
        variable m_original_data_a : std_logic_vector(width_a - 1 downto 0);
        variable m_original_data_b : std_logic_vector(width_b - 1 downto 0);
        variable m_data_a_x : std_logic_vector(width_a - 1 downto 0) := (others => 'X');
        variable m_data_b_x : std_logic_vector(width_b - 1 downto 0) := (others => 'X');

    begin
        if (need_init_var) then
        -- Begin of initializations
            m_original_data_a := (others => default_val);
            m_original_data_b := (others => default_val);
        
            if (init_file = "UNUSED" or init_file = "") then
            -- No memory file used
                if (operation_mode /= "ROM") then
                    if (( ((i_ram_block_type = "AUTO") and (cread_during_write_mode_mixed_ports = "DONT_CARE")) or
                        FEATURE_FAMILY_STRATIX_HC(intended_device_family) or
                        FEATURE_FAMILY_HARDCOPYII(intended_device_family) or
                        (i_ram_block_type = "MEGARAM") or (i_ram_block_type = "M-RAM") or 
                        (power_up_uninitialized = "TRUE")) and 
                        (implement_in_les = "OFF") and
                        not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) then
                        
                        for i in 0 to (pow_widthad_a-1) loop --(2**widthad_a - 1) loop
                            m_mem_data_a(i) := (others => 'X');
                        end loop;
                    else
                    
                        for i in 0 to (pow_widthad_a-1) loop --(2**widthad_a - 1) loop
                            m_mem_data_a(i) := (others => '0');
                        end loop;
                    end if;

                end if;
            else
            -- Using memory file to initialize memory content
                if (( ((i_ram_block_type = "AUTO") and (cread_during_write_mode_mixed_ports = "DONT_CARE")) or
                    FEATURE_FAMILY_STRATIX_HC(intended_device_family) or 
                    FEATURE_FAMILY_HARDCOPYII(intended_device_family) or
                    (power_up_uninitialized = "TRUE") or
                    (i_ram_block_type = "MEGARAM") or
                    (i_ram_block_type = "M-RAM")) and
                    not (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and
                    (operation_mode /= "ROM") ) then
                    for i in 0 to (pow_widthad_a-1) loop --(2 ** widthad_a - 1) loop
                        m_mem_data_a(i) := (others => 'X');
                    end loop;
                else
                    for i in 0 to (pow_widthad_a-1) loop --(2 ** widthad_a - 1) loop
                        m_mem_data_a(i) := (others => '0');
                    end loop;
                end if;

                if (init_file_layout = "UNUSED") then
                    if (operation_mode = "DUAL_PORT") then
                        m_init_file_b_port := true;
                    else
                        m_init_file_b_port := false;
                    end if;
                else
                    if (init_file_layout = "PORT_A") then
                        m_init_file_b_port := false;
                    elsif (init_file_layout = "PORT_B") then
                        m_init_file_b_port := true;
                    end if;
                end if;

                if (m_init_file_b_port) then
                    read_my_memory (false, m_mem_data_a, m_mem_data_b);

                    for i in 0 to (i_numwords_b * width_b - 1) loop
                        m_temp_wb := m_mem_data_b(i / width_b);
                        m_temp_wb2 := m_temp_wb((i)mod width_b);
                        m_temp_wa := m_mem_data_a(i / width_a);
                        m_temp_wa(i mod width_a) := m_temp_wb2;
                        m_mem_data_a(i / width_a) := m_temp_wa;
                    end loop;
                else
                    read_my_memory (true, m_mem_data_a, m_mem_data_b);
                end if;
            end if;
            
            if (i_is_lutram) then
                if (operation_mode = "DUAL_PORT") then
                    for i in 0 to (width_b - 1) loop
                        m_temp_wa2 := m_mem_data_a(i / width_a);
                        m_temp_wb(i) := m_temp_wa2(i mod width_a);
                    end loop;
                    i_q_tmp2_b <= m_temp_wb;
                end if;
                
                if ((operation_mode = "SINGLE_PORT") or (operation_mode = "ROM")) then
                    i_q_tmp2_a <= m_mem_data_a(0);
                end if;
                
            end if;
            
            need_init_var := false;
           
        -- End of initializations

        end if;

        -- Port A writing
        if ((rising_edge(i_write_flag_a) or falling_edge(i_write_flag_a)) and (need_init_var = false)) then
            if ((write_operation_a) and (i_good_to_write_a = '1')) then
                    m_original_data_a := m_mem_data_a(to_integer(unsigned(i_address_reg_a)));
                    i_original_data_a <= m_mem_data_a(to_integer(unsigned(i_address_reg_a)));

                    if (i_wren_reg_a = '1') then
                        if ((i_address_aclr_a = '1') and (to_integer(unsigned(i_address_reg_a)) /= 0)) then
                            for i in 0 to (i_numwords_a - 1) loop
                                m_mem_data_a(i) := (others => 'X');
                            end loop;
                        elsif (((i_indata_aclr_a = '1') and (i_data_reg_a /= i_data_zero_a)) or
                                ((i_byteena_aclr_a = '1') and (i_byteena_mask_reg_a /= i_data_ones_a)) or
                                ((i_wrcontrol_aclr_a = '1') and (i_wren_reg_a /= '0'))) then
                            m_mem_data_a (to_integer(unsigned(i_address_reg_a))) := (others => 'X');
                        else
                            port_a_bit_count_low := (to_integer(unsigned(i_address_reg_a)) * width_a);
                            port_b_bit_count_low := (to_integer(unsigned(i_address_reg_b)) * width_b);
                            port_b_bit_count_high := ((to_integer(unsigned(i_address_reg_b)) * width_b) + width_b);
                            m_temp_wa := m_mem_data_a(to_integer(unsigned(i_address_reg_a)));
    
                            for i in 0 to (width_a - 1) loop
                                port_a_bit_count_high := port_a_bit_count_low + i;
                                i_byteena_count := port_a_bit_count_high mod width_b;
                                
                                if ((port_a_bit_count_high >= port_b_bit_count_low) and (port_a_bit_count_high < port_b_bit_count_high)) then
                                    if ((i_core_clocken_b = '1') and (i_wren_reg_b = '1') and (same_clock_pulse = '1') and
                                        (i_byteena_mask_reg_b(i_byteena_count) = '1') and (i_byteena_mask_reg_a(i) = '1') and i_write_flag_b'event) then
                                        m_temp_wa(i) := 'X';
                                    elsif (i_byteena_mask_reg_a(i) = '1') then
                                        m_temp_wa(i) := i_data_reg_a(i);
                                    end if;
                                elsif (i_byteena_mask_reg_a(i) = '1') then
                                    m_temp_wa(i) := i_data_reg_a(i);
                                end if;
                            end loop;
                            
                            m_mem_data_a (to_integer(unsigned(i_address_reg_a))) := m_temp_wa;
                            m_original_address_a := to_integer(unsigned(i_address_reg_a)); 
                            m_data_write_time_a := now;
                            write_by_a := write_by_a + 1;
                        end if;
                    end if;
                    
                    m_current_written_data_a := m_mem_data_a(to_integer(unsigned(i_address_reg_a)));
                    i_current_written_data_a <= m_mem_data_a(to_integer(unsigned(i_address_reg_a)));
            end if;
        end if;
            
        -- Port B writing
        if ((rising_edge(i_write_flag_b) or falling_edge(i_write_flag_b)) and (need_init_var = false)) then
            if ((write_operation_b) and (i_good_to_write_b = '1')) then

                j := to_integer(unsigned(i_address_reg_b))  * width_b;
                for i in 0 to (width_b - 1) loop
                    m_temp_wb3 := m_mem_data_a((j + i) / width_a);
                    m_original_data_b(i) := m_temp_wb3((j + i) mod width_a);
                    i_original_data_b(i) <= m_temp_wb3((j + i) mod width_a);
                end loop;

                if (i_wren_reg_b = '1') then
                    if ((i_wrcontrol_aclr_b = '1') and (to_integer(unsigned(i_address_reg_b)) /= 0)) then
                        for i in 0 to (i_numwords_a - 1) loop
                            m_mem_data_a(i) := (others => 'X');
                        end loop;
                    elsif (((i_byteena_aclr_b = '1') and (i_byteena_mask_reg_b /= i_data_ones_b)) or
                            ((i_indata_aclr_b = '1') and (i_data_reg_b /= i_data_zero_b)) or
                            ((i_wrcontrol_aclr_b = '1') and (i_wren_reg_b /= '0'))) then
                                
                        if (width_a = width_b) then
                            j := to_integer(unsigned(i_address_reg_b));
                            m_mem_data_a(j) := (others => 'X');
                        else
                            j := to_integer(unsigned(i_address_reg_b)) * width_b;
                            for i in 0 to (width_b - 1) loop
                                m_temp_wa2 := m_mem_data_a((j + i) / width_a);
                                m_temp_wa2((j + i) mod width_a) := 'X';
                                m_mem_data_a((j + i) / width_a) := m_temp_wa2;
                            end loop;
                        end if;

                    else

                            port_b_bit_count_low := (to_integer(unsigned(i_address_reg_b)) * width_b);
                            port_a_bit_count_low := (to_integer(unsigned(i_address_reg_a)) * width_a);
                            port_a_bit_count_high := (to_integer(unsigned(i_address_reg_a)) * width_a) + width_a;
    
                            for i in 0 to (width_b - 1) loop
                                port_b_bit_count_high := port_b_bit_count_low + i;
                                m_temp_wa2 := m_mem_data_a((port_b_bit_count_high) / width_a);
                                if ((port_b_bit_count_high >= port_a_bit_count_low) and (port_b_bit_count_high < port_a_bit_count_high) and
                                    (i_core_clocken_a = '1') and (i_wren_reg_a = '1') and (same_clock_pulse = '1') and
                                    (i_byteena_mask_reg_a((port_b_bit_count_high) mod width_a) = '1') and (i_byteena_mask_reg_b(i) = '1') and i_write_flag_a'event) then
                                    m_temp_wa2((port_b_bit_count_high) mod width_a) := 'X';
                                elsif (i_byteena_mask_reg_b(i) = '1') then
                                    m_temp_wa2((port_b_bit_count_high) mod width_a) := i_data_reg_b(i);
                                end if;
                                
                                m_mem_data_a((port_b_bit_count_high) / width_a) := m_temp_wa2;
                                
                                m_current_written_data_b(i) := m_temp_wa2((port_b_bit_count_high) mod width_a);
                            end loop;

                        write_by_b := write_by_b + 1;
                    end if; -- end of choice selection
                end if; -- i_wren_reg_b = '1'
                
            end if;-- write_operation_b
        end if; -- i_write_flag_b'event

        -- To ensure that the model will reread port if two event (read & write) event triggered
        -- at the different time quantum
        reread_a := false;
        reread_b := false;
        if (ctime /= 0 ps) and (ctime = now) and
            ((i_write_flag_a'event) or
            (i_write_flag_b'event)) then
            if last_read_a_event then
                reread_a := true;
            end if;
            if last_read_b_event then
                reread_b := true;
            end if;
        end if;
        
        if (i_write_flag_a'event and i_lutram_dual_port_fast_read) then
            reread_b := true;
        end if;

        last_read_a_event := i_read_flag_a'event;
        last_read_b_event := i_read_flag_b'event;
        ctime := now;


        -- Port A reading
        if ((rising_edge(i_read_flag_a) or falling_edge(i_read_flag_a)) or (reread_a) or 
            rising_edge(i_reread_flag_a) or falling_edge(i_reread_flag_a) or rising_edge(i_reread_flag2_a) or falling_edge(i_reread_flag2_a)) then
            if (write_by_a /= prev_write_by_a) then
                prev_write_by_a :=  write_by_a;
            end if;

            if (read_operation_a) then
                if (i_rden_reg_a = '1') then
                    m_address_a := to_integer(unsigned(i_address_reg_a));
                
                    if (i_wren_reg_a = '1') then
                        if (i_core_clocken_a = '1') then
                            if (read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ") then
                                if (i_is_lutram and (clock0 = '1')) then
                                    m_q_tmp2_a := m_mem_data_a(m_address_a);
                                else
                                    m_q_tmp2_a := ((i_data_reg_a and i_byteena_mask_reg_a) or (m_data_a_x and not i_byteena_mask_reg_a));
                                end if;
                            elsif (read_during_write_mode_port_a = "NEW_DATA_WITH_NBE_READ") then
                                if (i_is_lutram and (clock0 = '1')) then
                                    m_q_tmp2_a := m_mem_data_a(m_address_a);
                                else
                                    m_q_tmp2_a := ((i_data_reg_a and i_byteena_mask_reg_a) or (m_mem_data_a(m_address_a) and not i_byteena_mask_reg_a)) xor i_byteena_mask_reg_a_x;
                                end if;
                            elsif (read_during_write_mode_port_a = "OLD_DATA") then
                                m_q_tmp2_a := m_original_data_a;
                            else
                                m_q_tmp2_a := i_data_reg_a xor i_byteena_mask_reg_a_out;
                            end if;
                        end if;
                        
                        if (i_lutram_single_port_fast_read) then
                            m_q_tmp2_a := m_mem_data_a(m_address_a);
                        end if;
                    else

                        m_address_a := to_integer(unsigned(i_address_reg_a));
                        m_q_tmp2_a := m_mem_data_a(m_address_a);
    
                        -- This is to output an "X" when the other ports is writing into the same location
                        -- when read_during_write_mode_mixed_ports = "DONT_CARE"
    
                            if (((address_reg_b = "CLOCK0") or (same_clock_pulse = '1')) and (is_write_positive_edge)) then
                                if ((i_wren_reg_b = '1') and 
                                    (((i_core_clocken_b = '1') and (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) or
                                    ((i_input_clocken_b = '1') and (not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))))) then
    
                                    m_address_b := to_integer(unsigned(i_address_reg_b));
    
                                    if (width_a = width_b) then
                                        if (m_address_b = m_address_a) then
                                            if (cread_during_write_mode_mixed_ports = "OLD_DATA") then
                                                m_q_tmp2_a := m_original_data_b;
                                            else
                                                m_q_tmp2_a := m_q_tmp2_a xor i_byteena_mask_reg_b_out_a;
                                            end if;
                                        end if;
                                    else
        
                                            for i in (m_address_a * width_a) to ((m_address_a * width_a) + width_a - 1) loop
                                                if ((i >= (m_address_b * width_b)) and (i <= ((m_address_b * width_b) + width_b - 1))) then
                                                    j := i - (m_address_a * width_a);
                                                    i_byteena_count := i - (m_address_b * width_b);
                                                    
                                                    if (cread_during_write_mode_mixed_ports = "OLD_DATA") then
                                                        m_q_tmp2_a(j) := m_original_data_b(i_byteena_count);
                                                    else
                                                        m_q_tmp2_a(j) := m_q_tmp2_a(j) xor i_byteena_mask_reg_b_out_a(i_byteena_count);
                                                    end if;
                                                end if;
                                            end loop;
                                    end if;
                                end if;
                            end if;
                    end if;

                    if (to_integer(unsigned(i_address_reg_a)) >= i_numwords_a) then
                        if ((i_wren_reg_a = '0') or (i_core_clocken_a = '0')) then
                            i_q_tmp2_a <= (others => 'X');
                        else
                            i_q_tmp2_a <= m_q_tmp2_a;
                        end if;
                        assert false
                        report "Address pointed at port A is out of bound! "
                        severity warning;
                    else
                    
                        if ((FEATURE_FAMILY_CYCLONEIII(intended_device_family)) and 
                                (((outdata_aclr_a = "CLEAR0") and (aclr0 = '1')) or
                                ((outdata_aclr_a = "CLEAR1") and (aclr1 = '1'))) and
                                (outdata_reg_a = "UNREGISTERED")) then
                            i_q_tmp2_a <= (others => '0');
                        else
                            i_q_tmp2_a <= m_q_tmp2_a;
                        end if;
                    
                        if (i_is_lutram and (i_address_aclr_a = '1') and (operation_mode = "ROM")) then
                            i_q_tmp2_a <= m_mem_data_a(0);
                        end if;
                    end if;

                else
                    if ((FEATURE_FAMILY_CYCLONEIII(intended_device_family)) and 
                            (not i_is_lutram) and
                            (((outdata_aclr_a = "CLEAR0") and (aclr0 = '1')) or
                            ((outdata_aclr_a = "CLEAR1") and (aclr1 = '1'))) and
                            (outdata_reg_a /= "CLOCK0") and (outdata_reg_a /= "CLOCK1")) then
                        i_q_tmp2_a <= (others => '0');
                    end if;
                
                end if;
            end if; -- end read_operation_a

        end if;

        -- Port B reading
        if ((rising_edge(i_read_flag_b) or falling_edge(i_read_flag_b)) or (reread_b) or 
            rising_edge(i_reread_flag_b) or falling_edge(i_reread_flag_b) or rising_edge(i_reread_flag2_b) or falling_edge(i_reread_flag2_b)) then

            if (write_by_b /= prev_write_by_b) then
                prev_write_by_b :=  write_by_b;
            end if;

            if (read_operation_b) then
                if (i_rden_reg_b = '1') then
                    m_address_a := to_integer(unsigned(i_address_reg_a));
                    m_address_b := to_integer(unsigned(i_address_reg_b));
                    
                    -- No address conversion calculation if width_a is equals to width_b
                    if (width_a = width_b) then
                    
                        if (i_wren_reg_b = '1') then
                            if (i_core_clocken_b = '1') then
                                if (read_during_write_mode_port_b = "NEW_DATA_NO_NBE_READ") then
                                    i_q_tmp2_b <= ((i_data_reg_b and i_byteena_mask_reg_b) or 
                                                    (m_data_b_x and not i_byteena_mask_reg_b));
                                elsif (read_during_write_mode_port_b = "NEW_DATA_WITH_NBE_READ") then
                                    i_q_tmp2_b <= ((i_data_reg_b and i_byteena_mask_reg_b) or (m_mem_data_a(m_address_b) and 
                                                    not i_byteena_mask_reg_b)) xor i_byteena_mask_reg_b_x;
                                elsif (read_during_write_mode_port_b = "OLD_DATA") then
                                    i_q_tmp2_b <= m_original_data_b;
                                else
                                    i_q_tmp2_b <= (others => 'X');
                                end if;
                            end if;
                        elsif (((m_data_write_time_a = now) and (operation_mode = "DUAL_PORT") and
                                (not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)))) then
                            if ((m_address_a = m_address_b) and (m_address_a = m_original_address_a)) then
                                if (address_reg_b /= "CLOCK0") then
                                    i_q_tmp2_b <= m_mem_data_a(m_address_b) xor i_byteena_mask_reg_a_out_b;
                                elsif (cread_during_write_mode_mixed_ports = "OLD_DATA") then
                                    i_q_tmp2_b <= m_original_data_a;
                                elsif (cread_during_write_mode_mixed_ports = "DONT_CARE") then
                                    i_q_tmp2_b <= m_mem_data_a(m_address_b) xor i_byteena_mask_reg_a_out_b;
                                else
                                    i_q_tmp2_b <= m_mem_data_a(m_address_b);
                                end if;
                            else
                                i_q_tmp2_b <= m_mem_data_a(m_address_b);
                            end if;
                        else 
                            if (m_address_a = m_address_b) then
                                if (i_is_lutram) then
                                    if (((address_reg_b = "CLOCK0") or (same_clock_pulse = '1')) and (is_write_positive_edge)) then 
                                        if ((i_wren_reg_a = '1') and
                                            (((i_core_clocken_a = '1') and FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) or
                                            ((i_inclocken0 = '1') and not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)))) then 
                                            if ((cread_during_write_mode_mixed_ports = "OLD_DATA") and (outdata_reg_b = "CLOCK0")) then
                                                i_q_tmp2_b <= m_mem_data_a(m_address_b);
                                            else
                                                i_q_tmp2_b <= m_current_written_data_a;
                                            end if;
                                        else
                                            i_q_tmp2_b <= m_mem_data_a(m_address_b);
                                        end if;
                                    else
                                        i_q_tmp2_b <= m_mem_data_a(m_address_b);
                                    end if;
                                elsif ((i_ram_block_type = "MEGARAM") or 
                                    (i_ram_block_type = "M-RAM") or
                                    ((cread_during_write_mode_mixed_ports = "DONT_CARE") and (i_ram_block_type = "AUTO"))) then
                                    if (((address_reg_b = "CLOCK0") or (same_clock_pulse = '1')) and (is_write_positive_edge)) then
                                        if ((i_wren_reg_a = '1') and
                                            (((i_core_clocken_a = '1') and FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) or
                                            ((i_inclocken0 = '1') and not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)))) then 
                                            i_q_tmp2_b <= m_mem_data_a(m_address_b) xor i_byteena_mask_reg_a_out_b;
                                        else
                                            i_q_tmp2_b <= m_mem_data_a(m_address_b);
                                        end if;
                                    else 
                                        i_q_tmp2_b <= m_mem_data_a(m_address_b);
                                    end if;
                                else
                                    if (((address_reg_b = "CLOCK0") or (same_clock_pulse = '1')) and (is_write_positive_edge)) then
                                        if ((i_wren_reg_a = '1') and
                                            (((i_core_clocken_a = '1') and FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) or
                                            ((i_inclocken0 = '1') and not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) and
                                            (is_write_positive_edge)) then 
                                            i_q_tmp2_b <= m_original_data_a;
                                        else
                                            i_q_tmp2_b <= m_mem_data_a(m_address_b);
                                        end if;
                                    else
                                        i_q_tmp2_b <= m_mem_data_a(m_address_b);
                                    end if;
                                end if;
                            else
                                i_q_tmp2_b <= m_mem_data_a(m_address_b);
                            end if;
                        end if;
                        
                    else

                        j := m_address_b * width_b;
                        
                        for i in 0 to (width_b - 1) loop
                        
                            if (i_wren_reg_b = '1') then
                                if (read_during_write_mode_port_b = "NEW_DATA_NO_NBE_READ") then
                                    m_temp_wb(i) := ((i_data_reg_b(i) and i_byteena_mask_reg_b(i)) or 
                                                    (m_data_b_x(i) and not i_byteena_mask_reg_b(i)));
                                elsif (read_during_write_mode_port_b = "NEW_DATA_WITH_NBE_READ") then
                                    m_temp_wa2 := m_mem_data_a((j + i) / width_a);
                                    m_temp_wb(i) := ((i_data_reg_b(i) and i_byteena_mask_reg_b(i)) or (m_temp_wa2((j + i) mod width_a) and not i_byteena_mask_reg_b(i))) xor i_byteena_mask_reg_b_x(i);
                                elsif (read_during_write_mode_port_b = "OLD_DATA") then
                                    m_temp_wb(i) := m_original_data_b(i);
                                else
                                    m_temp_wb(i) := 'X';
                                end if;
                            elsif ((m_data_write_time_a = now) and (operation_mode = "DUAL_PORT") and
                                (not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) then
                                if ((m_address_a = ((j + i) / width_a)) and (m_address_a = m_original_address_a)) then
                                    if (address_reg_b /= "CLOCK0") then
                                        m_temp_wa2 := (m_mem_data_a((j + i) / width_a)) xor i_byteena_mask_reg_a_out_b;
                                        m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                                    elsif (cread_during_write_mode_mixed_ports = "OLD_DATA") then
                                        m_temp_wb(i) := m_original_data_a((j + i) mod width_a);
                                    elsif (cread_during_write_mode_mixed_ports = "DONT_CARE") then
                                        m_temp_wa2 := (m_mem_data_a((j + i) / width_a)) xor i_byteena_mask_reg_a_out_b;
                                        m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                                    else
                                        m_temp_wa2 := m_mem_data_a((j + i) / width_a);
                                        m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                                    end if;
                                else
                                    m_temp_wa2 := m_mem_data_a((j + i) / width_a);
                                    m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                                end if;
                            else
                                if (((j + i) / width_a) = m_address_a) then
                                    if (i_is_lutram) then
                                        if (((address_reg_b = "CLOCK0") or (same_clock_pulse = '1')) and (is_write_positive_edge)) then
                                            if ((i_wren_reg_a = '1') and
                                                (((i_core_clocken_a = '1') and FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) or
                                                ((i_inclocken0 = '1') and not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)))) then 
                                                if ((cread_during_write_mode_mixed_ports = "OLD_DATA") and (outdata_reg_b = "CLOCK0")) then
                                                    m_temp_wa2 := m_mem_data_a((j + i) / width_a);
                                                    m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                                                else
                                                    m_temp_wb(i) := m_current_written_data_a((j + i) mod width_a);
                                                end if;
                                            else
                                                m_temp_wa2 := m_mem_data_a((j + i) / width_a);
                                                m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                                            end if;
                                        else
                                            m_temp_wa2 := m_mem_data_a((j + i) / width_a);
                                            m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                                        end if;
                                    elsif ((i_ram_block_type = "MEGARAM") or (i_ram_block_type = "M-RAM") or
                                        ((cread_during_write_mode_mixed_ports = "DONT_CARE") and
                                        (i_ram_block_type = "AUTO"))) then
                                        if (((address_reg_b = "CLOCK0") or (same_clock_pulse = '1')) and (is_write_positive_edge)) then
                                            if ((i_wren_reg_a = '1') and
                                                (((i_core_clocken_a = '1') and FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) or
                                                ((i_inclocken0 = '1') and FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)))) then 
                                                m_temp_wa2 := (m_mem_data_a((j + i) / width_a)) xor i_byteena_mask_reg_a_out_b;
                                                m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                                            else
                                                m_temp_wa2 := m_mem_data_a((j + i) / width_a);
                                                m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                                            end if;
                                        else
                                            m_temp_wa2 := m_mem_data_a((j + i) / width_a);
                                            m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                                        end if;
                                    else
                                        if (((address_reg_b = "CLOCK0") or (same_clock_pulse = '1')) and (is_write_positive_edge)) then
                                            if ((i_wren_reg_a = '1') and
                                                (((i_core_clocken_a = '1') and FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) or
                                                ((i_inclocken0 = '1') and FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) and
                                                (is_write_positive_edge)) then 
                                                m_temp_wb(i) := m_original_data_a((j + i) mod width_a);
                                            else
                                                m_temp_wa2 := m_mem_data_a((j + i) / width_a);
                                                m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                                            end if;
                                        else
                                            m_temp_wa2 := m_mem_data_a((j + i) / width_a);
                                            m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                                        end if;
                                    end if;
                                else
                                    m_temp_wa2 := m_mem_data_a((j + i) / width_a);
                                    m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                                end if;
                            end if;
                        end loop;
                            
                        i_q_tmp2_b <= m_temp_wb;
                    end if;
                end if;
                
                if (i_is_lutram and (i_address_aclr_b = '1') and operation_mode = "DUAL_PORT") then
                    for i in 0 to (width_b - 1) loop
                        m_temp_wa2 := m_mem_data_a(i / width_a);
                        m_temp_wb(i) := m_temp_wa2(i mod width_a);
                    end loop;
                    i_q_tmp2_b <= m_temp_wb;
                elsif (i_is_lutram and operation_mode = "DUAL_PORT") then
                    j := m_address_b * width_b;

                    for i in 0 to (width_b - 1) loop
                        m_temp_wa2 := m_mem_data_a((j + i) / width_a);
                        m_temp_wb(i) := m_temp_wa2((j + i) mod width_a);
                    end loop;
                    i_q_tmp2_b <= m_temp_wb;
                end if;
                        
                if ((((outdata_aclr_b = "CLEAR0") and (aclr0 = '1')) or ((outdata_aclr_b = "CLEAR1") and (aclr1 = '1'))) and 
                    (outdata_reg_b /= "CLOCK0") and (outdata_reg_b /= "CLOCK1") and
                    ((FEATURE_FAMILY_CYCLONEIII(intended_device_family)) and 
                    (not i_is_lutram))) then
                    i_q_tmp2_b <= (others => '0');
                end if;
            end if;
        end if;

    end process memory;


    -- Port A inputs registered : indata, address, byeteena, wren
    process (clock0)
        variable m_byteena_mask_reg_a : std_logic_vector(width_a - 1 downto 0);
        variable m_byteena_mask_reg_a_out : std_logic_vector(width_a - 1 downto 0);
        variable m_byteena_mask_reg_a_x : std_logic_vector(width_a - 1 downto 0):= (others => '0');
        variable m_indata_reg_aclr_a   : std_logic := '0';
        variable m_wren_reg_aclr_a    : std_logic := '0';
        variable m_byteena_reg_aclr_a : std_logic := '0';
        variable m_address_reg_aclr_a : std_logic := '0';
        variable m_byteena_mask_reg_a_out_b : std_logic_vector(width_a - 1 downto 0);
        variable need_init_var : boolean := true;
    begin

        if (need_init_var = true) then
            if ((FEATURE_FAMILY_STRATIX_HC(intended_device_family) or FEATURE_FAMILY_HARDCOPYII(intended_device_family)) and
                (ram_block_type = "M4K") and (operation_mode /= "SINGLE_PORT") and (clock0 = '1')) then
                i_good_to_write_b <= '0';
            end if;
            
            need_init_var := false;
        end if;

        if (rising_edge(clock0)) then
            
            if (i_address_aclr_a = '1') then
                i_address_reg_a <= (others => '0');
            end if;
        
            if (i_force_reread_a = '1') then
                i_force_reread_signal_a <= not i_force_reread_signal_a;
            end if;

            if (i_core_clocken_a = '1') then

                if (FEATURE_FAMILY_STRATIXIII(intended_device_family) and (not i_is_lutram)) then

                    good_to_go_a <= '1';

                    if (i_wrcontrol_aclr_a = '1') then
                        i_wren_reg_a <= '0';
                    else
                        i_wren_reg_a <= wren_a;
                    end if;
                    
                    i_rden_reg_a <= rden_a;
                
                end if;
                
                if ((not i_is_lutram) and FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) then
                    i_read_flag_a <= not i_read_flag_a;
                end if;
                
                if ((is_write_positive_edge) and ((wren_a = '1') or (i_wren_reg_a = '1'))) then
                    i_write_flag_a <= not i_write_flag_a;
                end if;

                if (operation_mode /= "ROM") then
                    i_nmram_write_a <= '1';
                end if;
            else
                if (operation_mode /= "ROM") then
                    i_nmram_write_a <= '0';
                end if;
            end if;

            if (i_is_lutram) then
                if (i_wrcontrol_aclr_a = '1') then
                    i_wren_reg_a <= '0';
                elsif (i_core_clocken_a = '1') then
                    i_wren_reg_a <= wren_a;
                end if;
            end if;
                    
            if (((clock_enable_input_a = "NORMAL") and (clocken0 = '1')) or
                ((clock_enable_input_a = "ALTERNATE") and (clocken2 = '1')) or
                (clock_enable_input_a = "BYPASS")) then

                if (not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family) or i_is_lutram) then
                    i_read_flag_a <= not i_read_flag_a;
                end if;
                
                if (i_indata_aclr_a = '1') then
                    i_data_reg_a <= (others => '0');
                else
                    i_data_reg_a <= data_a;
                end if;
                
                if ((not FEATURE_FAMILY_STRATIXIII(intended_device_family)) or (i_is_lutram)) then

                    good_to_go_a <= '1';

                    if (i_wrcontrol_aclr_a = '1') then
                        i_wren_reg_a <= '0';
                    else
                        i_wren_reg_a <= wren_a;
                    end if;
                    
                    i_rden_reg_a <= rden_a;
                
                end if;

                if (i_byteena_aclr_a = '1') then
                    m_byteena_mask_reg_a := (others => '1');
                    m_byteena_mask_reg_a_out := (others => '0');
                    m_byteena_mask_reg_a_out_b := (others => 'X');
                else
                    if (width_byteena_a = 1) then
                        m_byteena_mask_reg_a := (others => byteena_a(0));
                        if (byteena_a(0) = '1') then
                            m_byteena_mask_reg_a_out := (others => '0');
                            m_byteena_mask_reg_a_x := (others => '0');
                            m_byteena_mask_reg_a_out_b := (others => 'X');
                        elsif (byteena_a(0) = '0') then
                            m_byteena_mask_reg_a_x := (others => '0');
                            m_byteena_mask_reg_a_out := (others => 'X');
                            m_byteena_mask_reg_a_out_b := (others => '0');
                        else
                            m_byteena_mask_reg_a_x := (others => 'X');
                            m_byteena_mask_reg_a_out := (others => 'X');
                            m_byteena_mask_reg_a_out_b := (others => 'X');
                        end if;
                        
                    else
                        for k in 0 to (width_a - 1) loop
                            m_byteena_mask_reg_a(k) := byteena_a(k / i_byte_size);
                            if (m_byteena_mask_reg_a(k) = '1') then
                                m_byteena_mask_reg_a_out(k) := '0';
                                m_byteena_mask_reg_a_x(k) := '0';
                                m_byteena_mask_reg_a_out_b(k) := 'X';
                            elsif (m_byteena_mask_reg_a(k) = '0') then
                                m_byteena_mask_reg_a_x(k) := '0';
                                m_byteena_mask_reg_a_out(k) := 'X';
                                m_byteena_mask_reg_a_out_b(k) := '0';
                            else
                                m_byteena_mask_reg_a_out(k) := 'X';
                                m_byteena_mask_reg_a_x(k) := 'X';
                                m_byteena_mask_reg_a_out_b(k) := 'X';
                            end if;
                        end loop;
                    end if;
                end if;

                i_byteena_mask_reg_a_out <= m_byteena_mask_reg_a_out;
                i_byteena_mask_reg_a <= m_byteena_mask_reg_a;
                i_byteena_mask_reg_a_x <= m_byteena_mask_reg_a_x;
                i_byteena_mask_reg_a_out_b <= m_byteena_mask_reg_a_out_b;

                if (i_address_aclr_a = '1') then
                    i_address_reg_a <= (others => '0');
                elsif (addressstall_a /= '1') then
                    i_address_reg_a <= address_a;
                end if;
            end if;

        end if;

        if (falling_edge(clock0)) then
        
            if (i_core_clocken_a = '1') then
                i_good_to_write_b <= '1';
            end if;

            if (not is_write_positive_edge) then
                if (i_nmram_write_a = '1') then
                    i_write_flag_a <= not i_write_flag_a;
                    if (i_is_lutram) then
                        i_read_flag_a <= not i_read_flag_a;
                    end if;
                end if;
            end if;
        end if;

    end process;
    
    IFCLR01 : if (FEATURE_FAMILY_CYCLONEIII(intended_device_family)) generate
        process (i_outdata_aclr_a)
        begin
            if ((outdata_reg_a /= "CLOCK0") and (outdata_reg_a /= "CLOCK1")) then
                if (rising_edge(i_outdata_aclr_a)) then
                    i_reread_flag_a <= not i_reread_flag_a;
                end if;
            end if;
        end process;
        
        process (i_outdata_aclr_b)
        begin
            if ((outdata_reg_b /= "CLOCK0") and (outdata_reg_b /= "CLOCK1")) then
                if (rising_edge(i_outdata_aclr_b)) then
                    i_reread_flag_b <= not i_reread_flag_b;
                end if;
            end if;
        end process;
    end generate IFCLR01;
    
    IFCLR02 : if (i_is_lutram and (operation_mode = "DUAL_PORT")) generate
        process (i_address_aclr_b)
        begin
            if (rising_edge(i_address_aclr_b)) then
                i_reread_flag2_b <= not i_reread_flag2_b;
            end if;
        end process;
    end generate IFCLR02;
    
    IFCLR03 : if (i_is_lutram and (operation_mode = "ROM")) generate
        process (i_address_aclr_a)
        begin
            if (rising_edge(i_address_aclr_a)) then
                i_reread_flag2_a <= not i_reread_flag2_a;
            end if;
        end process;
    end generate IFCLR03;
    

    -- Port B address input registered (for dual_port mode)
    IFG48: if (((address_reg_b = "CLOCK0") or (address_reg_b = "CLOCK1")) and
                (operation_mode = "DUAL_PORT")) generate
        process (clock0, clock1, i_address_aclr_b)
            variable need_init_var : boolean := true;
        begin
        
            if (need_init_var = true) then
                if ((FEATURE_FAMILY_STRATIX_HC(intended_device_family) or FEATURE_FAMILY_HARDCOPYII(intended_device_family)) and
                    (ram_block_type = "M4K") and (operation_mode /= "SINGLE_PORT") and
                    (((address_reg_b = "CLOCK0") and (clock0 = '1')) or ((address_reg_b = "CLOCK1") and (clock1 = '1')))) then
                    i_good_to_write_a <= '0';
                end if;
                
                need_init_var := false;
            end if;
            
            if (rising_edge(i_address_aclr_b)) then
                if (i_address_aclr_b = '1') then
                    if (i_is_lutram) then
                        i_address_reg_b <= (others => '0');
                        i_read_flag_b <= not i_read_flag_b;
                    end if;
                end if;
            end if;

            if ((rising_edge(clock0) and (address_reg_b = "CLOCK0")) or
                (rising_edge(clock1) and (address_reg_b = "CLOCK1"))) then
            
                if (i_force_reread_b = '1') then
                    i_force_reread_signal_b <= not i_force_reread_signal_b;
                end if;
                
                if (i_address_aclr_b = '1') then
                    i_address_reg_b <= (others => '0');
                end if;
                        
                if (i_core_clocken_b = '1') then
                    if (FEATURE_FAMILY_STRATIXIII(intended_device_family) and not i_is_lutram) then
                        good_to_go_b <= '1';

                        if (i_rdcontrol_aclr_b = '1') then
                            i_rden_reg_b <= '1';
                        else
                            i_rden_reg_b <= rden_b;
                        end if;
                    end if;
                end if;
                
                if (i_input_clocken_b = '1') then

                    if ((not FEATURE_FAMILY_STRATIXIII(intended_device_family)) or i_is_lutram) then
                        good_to_go_b <= '1';
                        
                        if (i_rdcontrol_aclr_b = '1') then
                            i_rden_reg_b <= '1';
                        else
                            i_rden_reg_b <= rden_b;
                        end if;
                    end if;
                
                    if (i_indata_aclr_b = '1') then
                        i_data_reg_b <= (others => '0');
                    else
                        i_data_reg_b <= data_b;
                    end if;
                    
                    if (i_address_aclr_b = '1') then
                        i_address_reg_b <= (others => '0');
                    elsif (addressstall_b /= '1') then
                        i_address_reg_b <= address_b;
                    end if;

                end if;

                if (not i_lutram_dual_port_fast_read and FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) then
                    if (i_core_clocken_b = '1') then
                        i_read_flag_b <= not i_read_flag_b;
                    end if;
                elsif ((not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) or (i_is_lutram)) then
                    if (i_input_clocken_b = '1') then
                        i_read_flag_b <= not i_read_flag_b;
                    end if;
                end if;

            end if;
            
            if (((i_is_lutram) and 
                (i_lutram_dual_port_fast_read)) and 
                falling_edge(clock0)) then
                if (i_core_clocken_b = '1') then
                    i_read_flag_b <= not i_read_flag_b;
                end if;
            end if;
            
            if ((falling_edge(clock0) and (address_reg_b = "CLOCK0")) or
                (falling_edge(clock1) and (address_reg_b = "CLOCK1"))) then
                    if (i_core_clocken_b = '1') then
                        i_good_to_write_a <= '1';
                    end if;
            end if;
            
        end process;
    end generate IFG48;


    -- Port B inputs registered : wren, address, byteena (for bidir_dual_port mode)
    IFG49: if (((address_reg_b = "CLOCK0") or
                (address_reg_b = "CLOCK1")) and
                (operation_mode = "BIDIR_DUAL_PORT")) generate
        process (clock0, clock1)
            variable m_byteena_mask_reg_b  : std_logic_vector(width_b - 1 downto 0);
            variable m_byteena_mask_reg_b_out  : std_logic_vector(width_b - 1 downto 0);
            variable m_byteena_mask_reg_b_x  : std_logic_vector(width_b - 1 downto 0) := (others => '0');
            variable m_byteena_mask_reg_b_out_a  : std_logic_vector(width_b - 1 downto 0);
            variable need_init_var : boolean := true;
        begin
        
            if (need_init_var = true) then
                if ((FEATURE_FAMILY_STRATIX_HC(intended_device_family) or FEATURE_FAMILY_HARDCOPYII(intended_device_family)) and
                    (ram_block_type = "M4K") and (operation_mode /= "SINGLE_PORT") and
                    (((address_reg_b = "CLOCK0") and (clock0 = '1')) or ((address_reg_b = "CLOCK1") and (clock1 = '1')))) then
                    i_good_to_write_a <= '0';
                end if;
                
                need_init_var := false;
            end if;
            
            if (((address_reg_b = "CLOCK0") and
                (rising_edge(clock0))) or
                ((address_reg_b = "CLOCK1") and
                (rising_edge(clock1)))) then
                
                if (i_force_reread_b = '1') then
                    i_force_reread_signal_b <= not i_force_reread_signal_b;
                end if;
                
                if (i_core_clocken_b = '1') then
                    if (FEATURE_FAMILY_STRATIXIII(intended_device_family)) then
                        good_to_go_b <= '1';
                
                        if (i_rdcontrol_aclr_b = '1') then
                            i_rden_reg_b <= '1';
                        else
                            i_rden_reg_b <= rden_b;
                        end if;
    
                        if (i_wrcontrol_aclr_b = '1') then
                            i_wren_reg_b <= '0';
                        else
                            i_wren_reg_b <= wren_b;
                        
                            i_read_flag_b <= not i_read_flag_b;
                        end if;
                    end if;
                else
                    i_nmram_write_b <= '0';
                end if;

                if (i_input_clocken_b = '1') then

                    if (not FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) then
                        i_read_flag_b <= not i_read_flag_b;
                    end if;

                    if (i_indata_aclr_b = '1') then
                        i_data_reg_b <= (others => '0');
                    else
                        i_data_reg_b <= data_b;
                    end if;

                    if (not FEATURE_FAMILY_STRATIXIII(intended_device_family)) then
                        good_to_go_b <= '1';
                
                        if (i_rdcontrol_aclr_b = '1') then
                            i_rden_reg_b <= '1';
                        else
                            i_rden_reg_b <= rden_b;
                        end if;
    
                        if (i_wrcontrol_aclr_b = '1') then
                            i_wren_reg_b <= '0';
                        else
                            i_wren_reg_b <= wren_b;
                        
                        end if;
                    end if;
                    
                    if (i_wrcontrol_aclr_b = '1') then
                        i_address_reg_b <= (others => '0');
                    elsif (addressstall_b /= '1') then
                        i_address_reg_b <= address_b;
                    end if;

                    if (i_byteena_aclr_b = '1') then
                        m_byteena_mask_reg_b := (others => '1');
                        m_byteena_mask_reg_b_out := (others => '0');
                        m_byteena_mask_reg_b_x := (others => '0');
                        m_byteena_mask_reg_b_out_a := (others => 'X');
                    else
                        if (width_byteena_b = 1) then
                            m_byteena_mask_reg_b := (others => byteena_b(0));
                            if (byteena_b(0) = '1') then
                                m_byteena_mask_reg_b_out := (others => '0');
                                m_byteena_mask_reg_b_x := (others => '0');
                                m_byteena_mask_reg_b_out_a := (others => 'X');
                            elsif (byteena_b(0) = '0') then
                                m_byteena_mask_reg_b_x := (others => '0');
                                m_byteena_mask_reg_b_out := (others => 'X');
                                m_byteena_mask_reg_b_out_a := (others => '0');
                            else
                                m_byteena_mask_reg_b_x := (others => 'X');
                                m_byteena_mask_reg_b_out := (others => 'X');
                                m_byteena_mask_reg_b_out_a := (others => 'X');
                            end if;
                        else
                            for k in 0 to (width_b - 1) loop
                                m_byteena_mask_reg_b(k) := byteena_b(k / i_byte_size);
                                    
                                if (m_byteena_mask_reg_b(k) = '1') then
                                    m_byteena_mask_reg_b_out(k) := '0';   
                                    m_byteena_mask_reg_b_x(k) := '0'; 
                                    m_byteena_mask_reg_b_out_a(k) := 'X';   
                                elsif (m_byteena_mask_reg_b(k) = '0') then
                                    m_byteena_mask_reg_b_out(k) := 'X';
                                    m_byteena_mask_reg_b_x(k) := '0';
                                    m_byteena_mask_reg_b_out_a(k) := '0';
                                else
                                    m_byteena_mask_reg_b_out(k) := 'X';
                                    m_byteena_mask_reg_b_x(k) := 'X';
                                    m_byteena_mask_reg_b_out_a(k) := 'X';
                                end if;
                            end loop;
                        end if;
                    end if;

                    i_byteena_mask_reg_b_out <= m_byteena_mask_reg_b_out;
                    i_byteena_mask_reg_b <= m_byteena_mask_reg_b;
                    i_byteena_mask_reg_b_x <= m_byteena_mask_reg_b_x;
                    i_byteena_mask_reg_b_out_a <= m_byteena_mask_reg_b_out_a;
                end if;

                if ((i_core_clocken_b = '1') and (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family))) then
                    i_read_flag_b <= not i_read_flag_b;
                end if;

                if ((i_core_clocken_b = '1') and ((wren_b = '1') or (i_wren_reg_b = '1'))) then
                    if (is_write_positive_edge) then
                        i_write_flag_b <= not i_write_flag_b;
                    end if;

                    i_nmram_write_b <= '1';
                end if;

            end if;

            if (((address_reg_b = "CLOCK0") and
                (falling_edge(clock0))) or
                ((address_reg_b = "CLOCK1") and
                (falling_edge(clock1)))) then
                
                    if (i_core_clocken_b = '1') then
                        i_good_to_write_a <= '1';
                    end if;

                    if (not is_write_positive_edge) then
                        if ((i_nmram_write_b = '1') and (i_wren_reg_b = '1')) then
                            i_write_flag_b <= not i_write_flag_b;
                        end if;
                    end if;
            end if;

        end process;
    end generate IFG49;

    -- Port A : assigning the correct output values for i_q_tmp_a (non-registered output)

    process (i_q_tmp2_a, i_force_reread_signal_a, i_outdata_aclr_a, good_to_go_a, default_val)
    begin
        if (not good_to_go_a = '1') then
            if (i_is_lutram) then
                i_q_tmp_a <= i_q_tmp2_a;
            else
                i_q_tmp_a <= (others => default_val);
            end if;
        else
            if ((i_outdata_aclr_a = '1')and 
                    (outdata_reg_a /= "CLOCK0") and
                    (outdata_reg_a /= "CLOCK1") and
                    ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and 
                    (not i_is_lutram))) then
                i_q_tmp_a <= (others => '0');
            elsif (falling_edge(i_outdata_aclr_a)and 
                    (outdata_reg_a /= "CLOCK0") and
                    (outdata_reg_a /= "CLOCK1") and
                    ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and 
                    (not i_is_lutram))) then
                i_force_reread_a <= '1';
            else
                i_q_tmp_a <= i_q_tmp2_a;
                i_force_reread_a <= '0';
            end if;
        end if;
    end process;

    -- Port A outdata output registered
    process (clock0, clock1, i_outdata_aclr_a, i_address_aclr_a, i_rden_reg_a)
        variable i_address_aclr_a_flag  : std_logic := '0';
    begin
        if ((i_address_aclr_a'event) and (i_address_aclr_a = '1') and
            (i_rden_reg_a = '1')) then
            i_address_aclr_a_flag := '1';
        end if;
        if (i_outdata_aclr_a = '1') then
            i_q_reg_a <= (others => '0');
            i_address_aclr_a_flag := '0';
        elsif (((outdata_reg_a = "CLOCK0") and (rising_edge(clock0))) or
                ((outdata_reg_a = "CLOCK1") and (rising_edge(clock1)))) then            
            if i_outdata_clken_a = '1' then
                -- clear for 1 clock cycle
                if ((i_address_aclr_a_flag = '1') and
                    (FEATURE_FAMILY_BASE_STRATIXIII(intended_device_family)) and
                    (outdata_reg_a = "CLOCK0") and (not i_is_lutram)) then
                    i_q_reg_a <= (others => 'X');
                else
                    i_q_reg_a <= i_q_tmp_a;
                end if;
                if (i_core_clocken_a = '1') then
                i_address_aclr_a_flag := '0';
                end if;
            elsif (i_core_clocken_a = '1') then
                i_address_aclr_a_flag := '0';
            end if;
        end if;
    end process;


    -- Port A : assigning the correct output values for q_a

    IFG52: if (((outdata_reg_a = "CLOCK0") or (outdata_reg_a = "CLOCK1")) and
                (operation_mode /= "DUAL_PORT"))  generate
        q_a <= i_q_reg_a;
    end generate IFG52;

    IFG53: if (((outdata_reg_a /= "CLOCK0") and (outdata_reg_a /= "CLOCK1")) and
                (operation_mode /= "DUAL_PORT"))  generate
        q_a <= i_q_tmp_a;
    end generate IFG53;

    IFG54: if (operation_mode = "DUAL_PORT") generate
        q_a <= (others => '0');
    end generate IFG54;


    -- Port B : assigning the correct output values for i_q_tmp_b (non-registered output)
    process (i_q_tmp2_b, good_to_go_b, i_rden_reg_b, i_wren_reg_b, i_data_reg_b,
            i_byteena_mask_reg_b_out, default_val, i_address_reg_b, i_core_clocken_b,
            i_original_data_b, i_outdata_aclr_b, i_force_reread_signal_b)
    begin
        if ((operation_mode = "DUAL_PORT") or (operation_mode = "BIDIR_DUAL_PORT")) then
            if (not good_to_go_b = '1') then
                if (i_is_lutram) then
                    i_q_tmp_b <= i_q_tmp2_b;
                else
                    i_q_tmp_b <= (others => default_val);
                end if;
            else
            
                if (i_q_tmp2_b'event or good_to_go_b'event or i_rden_reg_b'event or i_wren_reg_b'event or
                    i_data_reg_b'event or i_byteena_mask_reg_b_out'event or i_address_reg_b'event or
                    i_original_data_b'event or i_force_reread_signal_b'event) then
            
                    if ((to_integer(unsigned(i_address_reg_b)) >= i_numwords_b)) then
                        if ((i_wren_reg_b = '1') and (i_core_clocken_b = '1')) then
                            i_q_tmp_b <= i_q_tmp2_b;
                        else
                            i_q_tmp_b <= (others => 'X');
                        end if;
                        assert false
                        report "Address pointed at port B is out of bound! "
                        severity warning;
                    else
                        if ((i_rden_reg_b = '1') or i_is_lutram) then
                            i_q_tmp_b <= i_q_tmp2_b;
                        end if;
                    end if;
                
                end if;
                
                if ((i_outdata_aclr_b = '1') and 
                    (outdata_reg_b /= "CLOCK0") and
                    (outdata_reg_b /= "CLOCK1") and
                    ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and 
                    (not i_is_lutram))) then
                    i_q_tmp_b <= (others => '0');
                elsif (falling_edge(i_outdata_aclr_b)and 
                    (outdata_reg_b /= "CLOCK0") and
                    (outdata_reg_b /= "CLOCK1") and
                    ((FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)) and 
                    (not i_is_lutram))) then
                    i_force_reread_b <= '1';
                end if;
                
            end if;
        end if;

    end process;

    -- Port B outdata output registered
    process (clock0, clock1, i_outdata_aclr_b, i_address_aclr_b, i_rden_reg_b)
        variable i_address_aclr_b_flag  : std_logic := '0';
    begin
        if ((i_address_aclr_b'event) and (i_address_aclr_b = '1') and
            (i_rden_reg_b = '1')) then
            i_address_aclr_b_flag := '1';
        end if;
        if (i_outdata_aclr_b = '1') then
            i_q_reg_b <= (others => '0');
            i_address_aclr_b_flag := '0';
        elsif (((outdata_reg_b = "CLOCK0") and (rising_edge(clock0))) or
                ((outdata_reg_b = "CLOCK1") and (rising_edge(clock1)))) then
            if (i_outdata_clken_b = '1') then
                if ((i_is_lutram) and (cread_during_write_mode_mixed_ports = "OLD_DATA") and
                    (outdata_reg_b = "CLOCK0")) then
                    i_q_reg_b <= i_q_output_latch;
                else
                    if ((i_address_aclr_b_flag = '1') and
                        (FEATURE_FAMILY_BASE_STRATIXIII(intended_device_family)) and
                        (outdata_reg_b = "CLOCK0") and (not i_is_lutram)) then
                        i_q_reg_b <= (others => 'X');
                    else
                    i_q_reg_b <= i_q_tmp_b;
                end if;
                    if (i_core_clocken_b = '1') then
                        i_address_aclr_b_flag := '0';
                    end if;
                end if;
            elsif (i_core_clocken_b = '1') then
                i_address_aclr_b_flag := '0';
            end if;
        end if;
        
        if ((outdata_reg_b = "CLOCK0") and (falling_edge(clock0))) then
            if (i_core_clocken_a = '1') then
                i_q_output_latch <= i_q_tmp_b;
            end if;
        end if;
    end process;

    -- Port B : assigning the correct output values for q_b

    IFG55: if (((outdata_reg_b = "CLOCK0") or (outdata_reg_b = "CLOCK1")) and
                (operation_mode /= "SINGLE_PORT") and (operation_mode /= "ROM")) generate
        q_b <= i_q_reg_b;
    end generate IFG55;

    IFG56: if (((outdata_reg_b /= "CLOCK0") and (outdata_reg_b /= "CLOCK1")) and
                (operation_mode /= "SINGLE_PORT") and (operation_mode /= "ROM"))  generate
        q_b <= i_q_tmp_b;
    end generate IFG56;

    IFG57: if ((operation_mode = "SINGLE_PORT") or (operation_mode = "ROM")) generate
        q_b <= (others => '0');
    end generate IFG57;

    -- ECC status

    eccstatus <= (others => '0');

end translated;

-- END OF ARCHITECTURE ALTSYNCRAM


--------------------------------------------------------------------------------
-- Module Name      : altshift_taps
--
-- Description      : Parameterized shift register with taps megafunction.
--                    Implements a RAM-based shift register for efficient
--                    creation of very large shift registers
--
-- Limitation       : This megafunction is provided only for backward
--                    compatibility in Cyclone, Stratix, and Stratix GX
--                    designs.
--
-- Results expected : Produce output from the end of the shift register
--                    and from the regularly spaced taps along the
--                    shift register.
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

-- ENTITY DECLARATION
entity altshift_taps is
generic (
        number_of_taps : natural := 4; -- Specifies the number of regularly spaced
                                        --  taps along the shift register
        tap_distance   : natural := 3; -- Specifies the distance between the
                                        --  regularly spaced taps in clock cycles
                                        --  This number translates to the number of
                                        --  RAM words that will be used
        width          : natural := 8;
        power_up_state : string := "CLEARED";
        lpm_hint       : string := "UNUSED";
        lpm_type       : string := "altshift_taps" 
    );

port (-- data input to the shifter
        shiftin   : in std_logic_vector (width-1 downto 0);
        -- Positive-edge triggered clock
        clock     : in std_logic;
        -- Clock enable for the clock port
        clken     : in std_logic := '1';
        -- Output from the end of the shift register
        shiftout  : out std_logic_vector (width-1 downto 0);
        -- Output from the regularly spaced taps along the shift register
        taps      : out std_logic_vector ((width*number_of_taps)-1 downto 0)
    );
                                        
end altshift_taps;


-- ARCHITECTURE DECLARATION
architecture behavioural of altshift_taps is

-- CONSTANT DECLARATION
constant TOTAL_TAP_DISTANCE : natural := number_of_taps * tap_distance;

-- TYPE DECLARATION
type mxn_array is array (TOTAL_TAP_DISTANCE-1 downto 0) of
    std_logic_vector (width downto 0);

-- SIGNAL DECLARATION
signal contents     : mxn_array;
signal head_pipe    : natural := 0;
signal i            : natural := 0;

begin

-- PROCESS BLOCKS
    SHIFT: process (clock)
    variable head: natural := 0;
    variable init : boolean := true;
    begin
        if init and (power_up_state = "CLEARED") then 
            shiftout  <= (others => '0');
            taps      <= (others => '0');
            contents  <= (others => (others => '0'));
            init := false;
        end if;

        if (rising_edge(clock)) then
            if (clken = '1') then
                head := head_pipe;
    
                contents (head)(width-1 downto 0) <= shiftin;
                shiftout <= contents ((head+1) mod
                            TOTAL_TAP_DISTANCE)(width-1 downto 0);
                head := (head+1) mod TOTAL_TAP_DISTANCE;
    
                for i in 0 to (number_of_taps-1)
                loop
                    taps (((i+1)*width)-1 downto (i*width) ) <=
                        contents ((((number_of_taps - i - 1)*tap_distance) + head)
                        mod TOTAL_TAP_DISTANCE)(width-1 downto 0);
                end loop;
    
                head_pipe <= head;
            end if;
        end if;
    end process shift;


end behavioural; -- altshift_taps



---START_ENTITY_HEADER---------------------------------------------------------
--
-- Entity Name     :  scfifo
--
-- Description     :  Single Clock FIFO
--
-- Limitation      :  USE_EAB=OFF is not supported
--
-- Results Expected:
--
---END_ENTITY_HEADER-----------------------------------------------------------

-- BEGINNING OF ENTITY
library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
--use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use work.ALTERA_DEVICE_FAMILIES.all;

-- ENTITY DECLARATION
entity SCFIFO is
-- GENERIC DECLARATION
    generic (
    lpm_width               : natural := 8;
    lpm_widthu              : natural := 8;
    lpm_numwords            : natural := 64;
    lpm_showahead           : string := "OFF";
    lpm_type                : string := "scfifo";
    lpm_hint                : string := "USE_EAB=ON";
    intended_device_family  : string := "APEX20KE";    
    underflow_checking      : string := "ON";
    overflow_checking       : string := "ON";
    allow_rwcycle_when_full : string := "OFF";    
    use_eab                 : string := "ON";
    add_ram_output_register : string := "OFF";
    almost_full_value       : natural := 0;
    almost_empty_value      : natural := 0;
    maximum_depth           : natural := 0 
    );

-- PORT DECLARATION
    port (
-- INPUT PORT DECLARATION
    data         : in std_logic_vector(lpm_width-1 downto 0);
    clock        : in std_logic;
    wrreq        : in std_logic;
    rdreq        : in std_logic;
    aclr         : in std_logic := '0';
    sclr         : in std_logic := '0';
-- OUTPUT PORT DECLARATION
    q            : out std_logic_vector(lpm_width-1 downto 0);
    usedw        : out std_logic_vector(lpm_widthu-1 downto 0);
    full         : out std_logic;
    empty        : out std_logic;
    almost_full  : out std_logic;
    almost_empty : out std_logic);
end SCFIFO;
-- END OF ENTITY

-- BEGINNING OF ARCHITECTURE
-- ARCHITECTURE DECLARATION
architecture behavior of SCFIFO is

Constant pow_2_lpm_widthu : natural := 2**lpm_widthu;

-- TYPE DECLARATION
type lpm_memory is array (pow_2_lpm_widthu-1 downto 0) of std_logic_vector(lpm_width-1 downto 0);

-- CONSTANT DECLARATION
constant ZEROS    : std_logic_vector(lpm_width-1 downto 0)     := (OTHERS => '0');
constant NIL      : std_logic_vector(pow_2_lpm_widthu-1 downto 0) := (OTHERS => '0');
constant UNKNOWNS : std_logic_vector(lpm_width-1 downto 0)     := (OTHERS => 'X');

-- SIGNAL DECLARATION
signal i_count_id          : natural                                := 0;
signal i_read_id           : natural                                := 0;
signal i_full_flag         : std_logic                              := '0';
signal i_empty_flag        : std_logic                              := '1';
signal i_almost_full_flag  : std_logic                              := '0';
signal i_almost_empty_flag : std_logic                              := '1';
signal i_set_q_to_x        : std_logic                              := '0';
signal i_set_q_to_x_by_empty  : std_logic                              := '0';
signal i_tmp_q             : std_logic_vector(lpm_width-1 downto 0) := ZEROS;

signal i_write_id          : natural                                    := 0;
signal i_write_latency1    : natural                                    := 0;
signal i_write_latency2    : natural                                    := 0;
signal i_write_latency3    : natural                                    := 0;
signal i_wrt_count         : natural                                    := 0;
signal i_empty_latency1    : std_logic                                  := '1';
signal i_empty_latency2    : std_logic                                  := '1';
signal i_data_ready        : std_logic_vector(2**lpm_widthu-1 downto 0) := (OTHERS => '0');
signal i_data_shown        : std_logic_vector(2**lpm_widthu-1 downto 0) := (OTHERS => '0');

begin
-- PROCESS DECLARATION
    process (clock, aclr)
    -- VARIABLE DECLARATION
    variable mem_data               : lpm_memory := (OTHERS => ZEROS);
    variable tmp_data               : std_logic_vector(lpm_width-1 downto 0) := ZEROS;    
    variable write_flag             : boolean := false;
    variable full_flag              : boolean := false;
    variable valid_rreq             : boolean := false;
    variable valid_wreq             : boolean := false;
    variable max_widthu             : integer := 0;
    variable numwords_minus_one     : integer := 0;
    variable almost_full_minus_one  : integer := 0;
    variable almost_empty_minus_one : integer := 0;
    variable need_init              : boolean := true;
    variable stratix_family         : boolean := (  FEATURE_FAMILY_STRATIX(intended_device_family) ) ;
    variable showahead_area         : boolean := (lpm_showahead = "ON" and add_ram_output_register = "OFF");
    variable showahead_speed        : boolean := (lpm_showahead = "ON" and add_ram_output_register = "ON");
    variable legacy_speed           : boolean := (lpm_showahead = "OFF" and add_ram_output_register = "ON");

    begin
        if (need_init) then
            if ((lpm_showahead /= "ON") and (lpm_showahead /= "OFF")) then
                ASSERT FALSE
                REPORT "Illegal LPM_SHOWAHEAD property value for SCFIFO!"
                SEVERITY ERROR;
            end if;
            if ((underflow_checking /= "ON") and (underflow_checking /= "OFF")) then
                ASSERT FALSE
                REPORT "Illegal UNDERFLOW_CHECKING property value for SCFIFO!"
                SEVERITY ERROR;
            end if;
            if ((overflow_checking /= "ON") and (overflow_checking /= "OFF")) then
                ASSERT FALSE
                REPORT "Illegal OVERFLOW_CHECKING property value for SCFIFO!"
                SEVERITY ERROR;
            end if;
            if ((allow_rwcycle_when_full /= "ON") and (allow_rwcycle_when_full /= "OFF")) then
                ASSERT FALSE
                REPORT "Illegal ALLOW_RWCYCLE_WHEN_FULL property value for SCFIFO!"
                SEVERITY ERROR;
            end if;
            if (IS_VALID_FAMILY(intended_device_family) = false) then
                ASSERT FALSE
                REPORT "Illegal INTENDED_DEVICE_FAMILY for SCFIFO!"
                SEVERITY ERROR;
            end if;
            if ((add_ram_output_register /= "ON") and (add_ram_output_register /= "OFF"))
            then
                ASSERT FALSE
                REPORT "Error! ADD_RAM_OUTPUT_REGISTER must be ON or OFF."
                SEVERITY ERROR;
            end if;   

            for i in 0 to (lpm_widthu - 1) loop
                if (stratix_family)
                then
                    if ((add_ram_output_register = "ON") or (use_eab = "OFF") or
                        (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)))
                    then
                        mem_data(i) := ZEROS;
                    else
                        mem_data(i) := UNKNOWNS;
                    end if;
                else
                    mem_data(i) := ZEROS;
                end if;
            end loop;

            if (stratix_family)
            then
                if ((add_ram_output_register = "ON") or (use_eab = "OFF") or
                    (FEATURE_FAMILY_HAS_STRATIXIII_STYLE_RAM(intended_device_family)))
                then
                    i_tmp_q <= ZEROS;
                else
                    i_tmp_q <= UNKNOWNS;
                end if;
            else
                i_tmp_q <= ZEROS;
            end if;
            
            if (almost_full_value = 0)
            then
                i_almost_full_flag <= '1';
            else
                i_almost_full_flag <= '0';
            end if;

            if (almost_empty_value = 0)
            then
                i_almost_empty_flag <= '0';
            else
                i_almost_empty_flag <= '1';
            end if;

            max_widthu := (2 ** lpm_widthu) - 1;
            numwords_minus_one := lpm_numwords - 1;

            almost_full_minus_one := almost_full_value - 1;
            almost_empty_minus_one := almost_empty_value - 1;

            i_write_latency1 <= max_widthu+1;
            i_write_latency2 <= max_widthu+1;
            i_write_latency3 <= max_widthu+1;
            
            need_init := false;
        end if;

        if (aclr = '1') then
            full_flag := false;
            i_read_id <= 0;
            i_count_id <= 0;
            i_full_flag <= '0';
            i_empty_flag <= '1';
            i_empty_latency1 <= '1';
            i_empty_latency2 <= '1';
            i_set_q_to_x <= '0';
            i_set_q_to_x_by_empty <= '0';
            i_wrt_count <= 0;

            if (add_ram_output_register = "ON") then
                i_tmp_q <= ZEROS;
            elsif ((lpm_showahead = "ON") and (use_eab = "ON")) then
                i_tmp_q <= UNKNOWNS;
            else
                if (not stratix_family) then
                    i_tmp_q <= ZEROS;
                else
                    i_tmp_q <= UNKNOWNS;
                end if;
            end if;
        end if;

        if (clock'event and (clock = '1') and
            ((aclr = '0') or (stratix_family)))
        then        
            valid_rreq := rdreq = '1' and ((i_empty_flag = '0') or
                            (underflow_checking = "OFF"));
            valid_wreq := wrreq = '1' and ((i_full_flag = '0') or
                            (overflow_checking = "OFF") or ((rdreq = '1') and
                            (allow_rwcycle_when_full = "ON")));

            
            if ((sclr = '1') or (aclr = '1'))
            then       
                    if (add_ram_output_register = "ON") then
                        i_tmp_q <= ZEROS;
                    else
                        i_tmp_q <= UNKNOWNS;
                    end if;
                    
                    i_read_id <= 0;
                    i_count_id <= 0;
                    i_full_flag <= '0';
                    i_empty_flag <= '1';
                    i_empty_latency1 <= '1';
                    i_empty_latency2 <= '1';
                    i_set_q_to_x <= '0';
                    i_set_q_to_x_by_empty <= '0';
                    i_wrt_count <= 0;
                    
                    if (almost_full_value > 0)
                    then
                        i_almost_full_flag <= '0';
                    end if;
                    if (almost_empty_value > 0)
                    then
                        i_almost_empty_flag <= '1';
                    end if;
                    
                    full_flag := false; 

                    if (not(stratix_family))
                    then
                        if (valid_wreq)    
                        then
                            tmp_data := data;
                            write_flag := true;
                        else
                            i_write_id <= 0;
                        end if;
                    else
                        i_write_id <= 0;
                    end if;
            else

                -- WRITE operation only
                if (valid_wreq)
                then
                    if ((overflow_checking = "OFF" and full_flag and not valid_rreq) or (i_set_q_to_x = '1') or (i_set_q_to_x_by_empty = '1'))
                    then
                        i_tmp_q <= UNKNOWNS;
                        i_set_q_to_x <= '1';

                        if (i_count_id >= max_widthu)
                        then
                            i_count_id <= 0;
                        else
                            i_count_id <= i_count_id + 1; 
                        end if;
                    else
                        tmp_data := data;
                        write_flag := true;

                        if (not((use_eab = "ON") and (stratix_family) and (showahead_speed or showahead_area or legacy_speed)))
                        then
                            i_empty_flag <= '0'; 
                        else
                            i_empty_latency1 <= '0';
                        end if; 

                        if (not valid_rreq)
                        then
                            i_wrt_count <= i_wrt_count + 1; 
                        end if;

                        if (not valid_rreq)
                        then
                            if (i_count_id >= max_widthu)
                            then
                                i_count_id <= 0;
                            else
                                i_count_id <= i_count_id + 1; 
                            end if;
                        else
                            if (allow_rwcycle_when_full = "OFF")
                            then
                                i_full_flag <= '0';
                            end if;
                        end if;

                        if (not(stratix_family) or(stratix_family and not(showahead_speed or showahead_area or legacy_speed)))
                        then
                            if (not valid_rreq)
                            then
                                if ((i_count_id = numwords_minus_one) and (i_empty_flag = '0'))
                                then
                                    i_full_flag <= '1';
                                    full_flag := true;
                                end if;
                            end if;
                        else
                            if (not valid_rreq)
                            then
                                if (i_count_id = numwords_minus_one)
                                then    
                                    i_full_flag <= '1';
                                    full_flag := true;
                                end if;
                            end if;
                        end if;

                        if (lpm_showahead = "ON")
                        then
                            if ((use_eab = "ON") and (stratix_family) and (showahead_speed or showahead_area))
                            then
                                i_write_latency1 <= i_write_id;
                                
                                if (i_write_id <= max_widthu)
                                then
                                    i_data_shown(i_write_id) <= '1';
                                    i_data_ready(i_write_id) <= 'X';
                                end if;
                            else
                                if ((use_eab = "OFF") and stratix_family and (i_count_id = 0))
                                then
                                    i_tmp_q <= data;
                                else
                                    if ((not i_empty_flag = '0') and (not valid_rreq))
                                    then
                                        i_tmp_q <= mem_data(i_read_id);
                                    end if;
                                end if;
                            end if;
                        else
                            if ((use_eab = "ON") and stratix_family and legacy_speed) 
                            then
                                i_write_latency1 <= i_write_id;
                                
                                if (i_write_id <= max_widthu)
                                then
                                    i_data_shown(i_write_id) <= '1';
                                    i_data_ready(i_write_id) <= 'X';
                                end if;
                            end if;
                        end if;
                    end if;
                    
                end if;
                
                -- READ operation only
                if (valid_rreq)
                then
                    if (not i_set_q_to_x = '1') 
                    then
                        if (not valid_wreq)
                        then
                            i_wrt_count <= i_wrt_count - 1;
                        end if;
                    
                        if (not valid_wreq)
                        then
                            i_full_flag <= '0';
                            full_flag := false;
                            
                            if (i_count_id <= 0)
                            then
                                i_count_id <= max_widthu;
                            else
                                i_count_id <= i_count_id - 1; 
                            end if;
                        end if;
                    
                        if ((use_eab = "ON") and stratix_family and (showahead_speed or showahead_area or legacy_speed))
                        then
                            if ((i_wrt_count = 1) or ((i_wrt_count = 1) and valid_wreq and valid_rreq))
                            then
                                i_empty_flag <= '1';
                            else
                                if (showahead_speed)
                                then
                                    if (i_write_latency2 <= max_widthu)
                                    then
                                        if (i_data_shown(i_write_latency2) = '0')
                                        then
                                            i_empty_flag <= '1';
                                        end if;
                                    end if;
                                else if (showahead_area or legacy_speed)
                                    then
                                        if (i_write_latency1 <= max_widthu)
                                        then
                                            if (i_data_shown(i_write_latency1) = '0')
                                            then
                                                i_empty_flag <= '1';
                                            end if;
                                        end if;
                                    end if;
                                end if;
                            end if;
                        else
                            if (not(valid_wreq))
                            then
                                if (i_count_id = 1 and i_full_flag = '0')
                                then
                                    i_empty_flag <= '1'; 
                                end if;
                            end if;
                        end if;

                        if (i_empty_flag = '1')
                        then
                        
                            if (underflow_checking = "ON") then
                                if ((use_eab = "OFF") or stratix_family) then
                                    i_tmp_q <= ZEROS;
                                end if;
                            else
                                i_tmp_q <= UNKNOWNS;
                                i_set_q_to_x_by_empty <= '1';
                            end if;
                            
                        else
                            if (i_read_id >= max_widthu)
                            then                        
                                if (lpm_showahead = "ON")
                                then
                                    if ((use_eab = "ON") and stratix_family and (showahead_speed or showahead_area))
                                    then
                                        if (showahead_speed)
                                        then
                                            if ((i_write_latency2 = unsigned(ZEROS)) or (i_data_ready(0) = '1'))
                                            then
                                                if (i_data_shown(0) = '1')
                                                then
                                                    i_tmp_q <= mem_data(0);   
                                                    i_data_shown(0) <= '0';
                                                    i_data_ready(0) <= '0';
                                                end if;
                                            end if;
                                        else
                                            if (i_count_id = 1 and i_full_flag = '0')
                                            then
                                                if (underflow_checking = "ON") then
                                                    if ((use_eab = "OFF") or stratix_family) then
                                                        i_tmp_q <= ZEROS;
                                                    end if;
                                                else
                                                    i_tmp_q <= UNKNOWNS;
                                                end if;
                                            else
                                                if ((i_write_latency1 = unsigned(ZEROS)) or (i_data_ready(0) = '1'))
                                                then
                                                    if (i_data_shown(0) = '1')
                                                    then
                                                        i_tmp_q <= mem_data(0);   
                                                        i_data_shown(0) <= '0';
                                                        i_data_ready(0) <= '0';
                                                    end if;
                                                end if;
                                            end if;
                                        end if; 
                                    else
                                        if (i_count_id = 1 and i_full_flag = '0')
                                        then
                                            if (valid_wreq)
                                            then
                                                i_tmp_q <= data;
                                            else
                                                if (underflow_checking = "ON") then
                                                    if ((use_eab = "OFF") or stratix_family) then
                                                        i_tmp_q <= ZEROS;
                                                    end if;
                                                else
                                                    i_tmp_q <= UNKNOWNS;
                                                end if;
                                            end if;
                                        else
                                            i_tmp_q <= mem_data(0);
                                        end if;
                                    end if;
                                else
                                    if ((use_eab = "ON") and (stratix_family and legacy_speed))
                                    then
                                        if ((i_write_latency1 = i_read_id) or (i_data_ready(i_read_id) = '1'))
                                        then
                                            if (i_data_shown(i_read_id) = '1')
                                            then
                                                i_tmp_q <= mem_data(i_read_id);   
                                                i_data_shown(i_read_id) <= '0';
                                                i_data_ready(i_read_id) <= '0';
                                            end if;
                                        else
                                            i_tmp_q <= UNKNOWNS;
                                        end if;
                                    else
                                        i_tmp_q <= mem_data(i_read_id);
                                    end if;
                                end if;
                        
                                i_read_id <= 0;
                            else
                                if (lpm_showahead = "ON")
                                then
                                    if ((use_eab = "ON") and (stratix_family and (showahead_speed or showahead_area)))
                                    then
                                        if (showahead_speed)
                                        then
                                            if ((i_write_latency2 = i_read_id+1) or (i_data_ready(i_read_id+1) = '1'))
                                            then
                                                if (i_data_shown(i_read_id+1) = '1')
                                                then
                                                    i_tmp_q <= mem_data(i_read_id + 1);
                                                    i_data_shown(i_read_id+1) <= '0';
                                                    i_data_ready(i_read_id+1) <= '0';
                                                end if;
                                            end if;
                                        else
                                            if (i_count_id = 1 and i_full_flag = '0')
                                            then
                                                if (underflow_checking = "ON") then
                                                    if ((use_eab = "OFF") or stratix_family) then
                                                        i_tmp_q <= ZEROS;
                                                    end if;
                                                else
                                                    i_tmp_q <= UNKNOWNS;
                                                end if;
                                            else
                                                if ((i_write_latency1 = i_read_id+1) or (i_data_ready(i_read_id+1) = '1'))
                                                then
                                                    if (i_data_shown(i_read_id+1) = '1')
                                                    then
                                                        i_tmp_q <= mem_data(i_read_id + 1);
                                                        i_data_shown(i_read_id+1) <= '0';
                                                        i_data_ready(i_read_id+1) <= '0';
                                                    end if;
                                                end if;
                                            end if;
                                        end if;
                                    else
                                        if (i_count_id = 1 and i_full_flag = '0')
                                        then
                                            if ((use_eab = "OFF") and stratix_family)
                                            then
                                                if (valid_wreq) then
                                                    i_tmp_q <= data;
                                                else
                                                    if (underflow_checking = "ON") then
                                                        i_tmp_q <= ZEROS;
                                                    else
                                                        i_tmp_q <= UNKNOWNS;
                                                    end if;
                                                end if;
                                            else
                                                i_tmp_q <= UNKNOWNS;
                                            end if;
                                        else
                                            i_tmp_q <= mem_data(i_read_id + 1);
                                        end if;
                                    end if; 
                                else
                                    if ((use_eab = "ON") and stratix_family and legacy_speed)
                                    then
                                        if ((i_write_latency1 = i_read_id) or (i_data_ready(i_read_id) = '1'))
                                        then
                                            if (i_data_shown(i_read_id) = '1')
                                            then
                                                i_tmp_q <= mem_data(i_read_id);
                                                i_data_shown(i_read_id) <= '0'; 
                                                i_data_ready(i_read_id) <= '0'; 
                                            end if;
                                        else
                                            i_tmp_q <= UNKNOWNS;
                                        end if; 
                                    else
                                        i_tmp_q <= mem_data(i_read_id);
                                    end if;
                                end if;
                        
                                i_read_id <= i_read_id + 1;
                            end if;
                        end if;
                    end if;
                end if;

                if (almost_full_value = 0)
                then
                    i_almost_full_flag <= '1';
                elsif (lpm_numwords = almost_full_value)
                then
                    if (full_flag)
                    then
                        i_almost_full_flag <= '1';
                    else
                        i_almost_full_flag <= '0';
                    end if;
                else
                    if (i_almost_full_flag = '1')
                    then
                        if ((i_count_id = almost_full_value) and (wrreq = '0') and
                            (rdreq = '1'))
                        then
                            i_almost_full_flag <= '0';
                        end if;
                        else
                            if ((almost_full_value = 1) and (i_count_id = 0) and (wrreq = '1'))
                            then
                                i_almost_full_flag <= '1';
                            elsif ((almost_full_value > 1) and (i_count_id = almost_full_minus_one)
                                    and (wrreq = '1') and (rdreq = '0'))
                            then
                                i_almost_full_flag <= '1';
                            end if; 
                        end if;
                end if;

                if (almost_empty_value = 0)
                then
                    i_almost_empty_flag <= '0';
                elsif (lpm_numwords = almost_empty_value)
                then
                    if (full_flag)
                    then
                        i_almost_empty_flag <= '0';
                    else
                        i_almost_empty_flag <= '1';
                    end if;
                else
                    if (i_almost_empty_flag = '1')
                    then
                        if ((almost_empty_value = 1) and (i_count_id = 0) and (wrreq = '1'))
                        then
                            i_almost_empty_flag <= '0';
                        elsif ((almost_empty_value > 1) and (i_count_id = almost_empty_minus_one)
                                and (wrreq = '1') and (rdreq = '0'))
                        then
                            i_almost_empty_flag <= '0';
                        end if;
                    else
                        if ((i_count_id = almost_empty_value) and (wrreq = '0') and
                            (rdreq = '1'))
                        then
                            i_almost_empty_flag <= '1';
                        end if;
                    end if;
                end if; 
            end if;

            if ((clock'event and (clock = '1')) and ((use_eab = "ON") and stratix_family))
            then
                if (showahead_speed)
                then
                    i_write_latency2 <= i_write_latency1;
                    i_write_latency3 <= i_write_latency2;

                    if (i_write_latency3 /= i_write_latency2)
                    then
                        if (i_write_latency2 <= max_widthu)  
                        then
                            i_data_ready(i_write_latency2) <= '1';
                        end if;
                    end if;

                    i_empty_latency2 <= i_empty_latency1;

                    if ((aclr = '1') or (sclr = '1'))
                    then
                        i_write_latency1 <= max_widthu+1;
                        i_write_latency2 <= max_widthu+1;
                        i_data_shown <= NIL;
                        if (add_ram_output_register = "ON") then
                            i_tmp_q <= ZEROS;
                        else
                            i_tmp_q <= UNKNOWNS;
                        end if;
                    end if;

                    if (i_write_latency2 <= max_widthu)  
                    then
                        if (i_data_shown(i_write_latency2) = '1')
                        then
                            if ((i_read_id = i_write_latency2) or (aclr = '1') or (sclr = '1'))
                            then
                                if (not (aclr = '1') and (not(sclr = '1')))
                                then
                                    i_tmp_q <= mem_data(i_write_latency2);
                                    i_data_shown(i_write_latency2) <= '0';
                                    i_data_ready(i_write_latency2) <= '0';

                                    if (not valid_rreq)
                                    then
                                        i_empty_flag <= i_empty_latency2;
                                    end if;
                                end if;
                            end if;
                        end if;
                    end if;
                elsif (showahead_area)
                then
                    i_write_latency2 <= i_write_latency1;

                    if (i_write_latency2 /= i_write_latency1)
                    then
                        if (i_write_latency1 <= max_widthu)  
                        then
                            i_data_ready(i_write_latency1) <= '1';
                        end if;
                    end if;

                    if ((aclr = '1') or (sclr = '1'))
                    then
                        i_write_latency1 <= max_widthu+1;
                        i_write_latency2 <= max_widthu+1;
                        i_data_shown <= NIL;
                        if (add_ram_output_register = "ON") then
                            i_tmp_q <= ZEROS;
                        else
                            i_tmp_q <= UNKNOWNS;
                        end if;
                    end if;

                    if (i_write_latency1 <= max_widthu)  
                    then
                        if (i_data_shown(i_write_latency1) = '1')
                        then
                            if ((i_read_id = i_write_latency1) or (aclr = '1') or (sclr = '1'))
                            then
                                if (not (aclr = '1') and (not(sclr = '1')))
                                then
                                    i_tmp_q <= mem_data(i_write_latency1);
                                    i_data_shown(i_write_latency1) <= '0';
                                    i_data_ready(i_write_latency1) <= '0';

                                    if (not valid_rreq)
                                    then
                                        i_empty_flag <= i_empty_latency1;
                                    end if;
                                end if;
                            end if;
                        end if;
                    end if; 
                else
                    if (legacy_speed)
                    then
                        i_write_latency2 <= i_write_latency1;

                        if (i_write_latency2 /= i_write_latency1)
                        then
                            if (i_write_latency1 <= max_widthu)  
                            then
                                i_data_ready(i_write_latency1) <= '1';
                            end if;
                        end if;

                        if ((aclr = '1') or (sclr = '1'))
                        then
                            i_write_latency1 <= max_widthu+1;
                            i_write_latency2 <= max_widthu+1;
                            i_data_shown <= NIL;
                            if (add_ram_output_register = "ON") then
                                i_tmp_q <= ZEROS;
                            else
                                i_tmp_q <= UNKNOWNS;
                            end if;
                        end if;

                        if ((i_wrt_count = 0 and (not valid_wreq)) or (aclr = '1') or (sclr = '1') or (i_wrt_count = 1 and valid_rreq and (not valid_wreq)))
                        then
                            i_empty_flag <= '1';
                            i_empty_latency1 <= '1';
                        else
                            if (i_wrt_count = 1 and valid_wreq and valid_rreq)
                            then
                                i_empty_flag <= '1';
                            else
                                i_empty_flag <= i_empty_latency1;
                            end if;
                        end if;  
                    end if;
                end if;
            end if;
        elsif (clock'event and (clock = '0'))
        then
            if (write_flag)
            then
                write_flag := false;
                mem_data(i_write_id) := tmp_data;

                if ((aclr = '1') or (sclr = '1') or (i_write_id >= max_widthu))
                then
                    i_write_id <= 0;
                else
                    i_write_id <= i_write_id + 1;
                end if;
            end if;

            if (not(stratix_family))
            then
                if (not i_empty_flag = '1')
                then
                    if (lpm_showahead = "ON")
                    then
                        i_tmp_q <= mem_data(i_read_id);
                    end if;
                end if;
            end if;
        end if;

        if (aclr = '1') then
                i_full_flag <= '0'; 
                i_empty_flag <= '1';
                if (almost_full_value > 0)
                then
                    i_almost_full_flag <= '0';
                end if;
                if (almost_empty_value > 0)
                then
                    i_almost_empty_flag <= '1';
                end if;

                i_read_id <= 0;
                i_write_id <= 0;
                i_count_id <= 0;
                i_set_q_to_x <= '0';
                i_wrt_count <= 0;
        end if;

    end process;

    q <= i_tmp_q;
    full <= i_full_flag;
    empty <= i_empty_flag;
    almost_full <= i_almost_full_flag;
    almost_empty <= i_almost_empty_flag;
    usedw <= std_logic_vector(to_unsigned(i_count_id, lpm_widthu));

end behavior; -- scfifo
-- END OF ARCHITECTURE


