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
----------------------------------------------------------------------------
-- ALtera Megafunction Component Declaration File
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package altera_mf_components is
type altera_mf_logic_2D is array (NATURAL RANGE <>, NATURAL RANGE <>) of STD_LOGIC;


component altsyncram
    generic (
        operation_mode                 : string := "BIDIR_DUAL_PORT";
        -- port a parameters
        width_a                        : natural := 1;
        widthad_a                      : natural := 1;
        numwords_a                     : natural := 0;
        -- registering parameters
        -- port a read parameters
        outdata_reg_a                  : string := "UNREGISTERED";
        -- clearing parameters
        address_aclr_a                 : string := "NONE";
        outdata_aclr_a                 : string := "NONE";
        -- clearing parameters
        -- port a write parameters
        indata_aclr_a                  : string := "NONE";
        wrcontrol_aclr_a               : string := "NONE";
        -- clear for the byte enable port reigsters which are clocked by clk0
        byteena_aclr_a                 : string := "NONE";
        -- width of the byte enable ports. if it is used, must be WIDTH_WRITE_A/8 or /9
        width_byteena_a                : natural := 1;
        -- port b parameters
        width_b                        : natural := 1;
        widthad_b                      : natural := 1;
        numwords_b                     : natural := 0;
        -- registering parameters
        -- port b read parameters
        rdcontrol_reg_b                : string := "CLOCK1";
        address_reg_b                  : string := "CLOCK1";
        outdata_reg_b                  : string := "UNREGISTERED";
        -- clearing parameters
        outdata_aclr_b                 : string := "NONE";
        rdcontrol_aclr_b               : string := "NONE";
        -- registering parameters
        -- port b write parameters
        indata_reg_b                   : string := "CLOCK1";
        wrcontrol_wraddress_reg_b      : string := "CLOCK1";
        -- registering parameter for the byte enable reister for port b
        byteena_reg_b                  : string := "CLOCK1";
        -- clearing parameters
        indata_aclr_b                  : string := "NONE";
        wrcontrol_aclr_b               : string := "NONE";
        address_aclr_b                 : string := "NONE";
        -- clear parameter for byte enable port register
        byteena_aclr_b                 : string := "NONE";
        -- StratixII only : to bypass clock enable or using clock enable
        clock_enable_input_a           : string := "NORMAL";
        clock_enable_output_a          : string := "NORMAL";
        clock_enable_input_b           : string := "NORMAL";
        clock_enable_output_b          : string := "NORMAL";
        -- width of the byte enable ports. if it is used, must be WIDTH_WRITE_A/8 or /9
        width_byteena_b                : natural := 1;
        -- clock enable setting for the core
        clock_enable_core_a            : string := "USE_INPUT_CLKEN";
        clock_enable_core_b            : string := "USE_INPUT_CLKEN";
        -- read-during-write-same-port setting
        read_during_write_mode_port_a  : string := "NEW_DATA_NO_NBE_READ";
        read_during_write_mode_port_b  : string := "NEW_DATA_NO_NBE_READ";
        -- ECC status ports setting
        enable_ecc                     : string := "FALSE";
        -- global parameters
        -- width of a byte for byte enables
        byte_size                      : natural := 0;
        read_during_write_mode_mixed_ports: string := "DONT_CARE";
        -- ram block type choices are "AUTO", "M512", "M4K" and "MEGARAM"
        ram_block_type                 : string := "AUTO";
        -- determine whether LE support is turned on or off for altsyncram
        implement_in_les               : string := "OFF";
        -- determine whether RAM would be power up to uninitialized or not
        power_up_uninitialized         : string := "FALSE";

        -- general operation parameters
        init_file                      : string := "UNUSED";
        init_file_layout               : string := "UNUSED";
        maximum_depth                  : natural := 0;
        intended_device_family         : string := "Stratix";
        lpm_hint                       : string := "UNUSED";
        lpm_type                       : string := "altsyncram" );
    port (
        wren_a    : in std_logic := '0';
        wren_b    : in std_logic := '0';
        rden_a    : in std_logic := '1';
        rden_b    : in std_logic := '1';
        data_a    : in std_logic_vector(width_a - 1 downto 0):= (others => '1');
        data_b    : in std_logic_vector(width_b - 1 downto 0):= (others => '1');
        address_a : in std_logic_vector(widthad_a - 1 downto 0);
        address_b : in std_logic_vector(widthad_b - 1 downto 0) := (others => '1');

        clock0    : in std_logic := '1';
        clock1    : in std_logic := '1';
        clocken0  : in std_logic := '1';
        clocken1  : in std_logic := '1';
        clocken2  : in std_logic := '1';
        clocken3  : in std_logic := '1';
        aclr0     : in std_logic := '0';
        aclr1     : in std_logic := '0';
        byteena_a : in std_logic_vector( (width_byteena_a - 1) downto 0) := (others => '1');
        byteena_b : in std_logic_vector( (width_byteena_b - 1) downto 0) := (others => '1');

        addressstall_a : in std_logic := '0';
        addressstall_b : in std_logic := '0';

        q_a            : out std_logic_vector(width_a - 1 downto 0);
        q_b            : out std_logic_vector(width_b - 1 downto 0);

        eccstatus      : out std_logic_vector(2 downto 0) );
end component;


component scfifo
    generic (
        lpm_width               : natural := 8;
        lpm_widthu              : natural := 8;
        lpm_numwords            : natural := 64;
        lpm_showahead           : string := "OFF";
        lpm_hint                : string := "USE_EAB=ON";
        intended_device_family  : string := "NON_STRATIX";
        almost_full_value       : natural := 0;
        almost_empty_value      : natural := 0;
        overflow_checking       : string := "ON";
        underflow_checking      : string := "ON";
        allow_rwcycle_when_full : string := "OFF";
        add_ram_output_register : string  := "OFF";
        use_eab                 : string := "ON";        
        lpm_type                : string := "scfifo";
        maximum_depth           : natural := 0 );
    port (
        data         : in std_logic_vector(lpm_width-1 downto 0);
        clock        : in std_logic;
        wrreq        : in std_logic;
        rdreq        : in std_logic;
        aclr         : in std_logic := '0';
        sclr         : in std_logic := '0';
        full         : out std_logic;
        almost_full  : out std_logic;
        empty        : out std_logic;
        almost_empty : out std_logic;
        q            : out std_logic_vector(lpm_width-1 downto 0);
        usedw        : out std_logic_vector(lpm_widthu-1 downto 0) );
end component;


component altshift_taps
    generic (
        number_of_taps    : natural := 4;
        tap_distance      : natural := 3;
        width             : natural := 8;
        power_up_state : string := "CLEARED";
        lpm_hint          : string := "UNUSED";
        lpm_type          : string := "altshift_taps" );
    port (
        shiftin  : in std_logic_vector (width-1 downto 0);
        clock    : in std_logic;
        clken    : in std_logic := '1';
        shiftout : out std_logic_vector (width-1 downto 0);
        taps     : out std_logic_vector ((width*number_of_taps)-1 downto 0));
end component;

end altera_mf_components;
