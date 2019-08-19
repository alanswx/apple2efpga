  LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.all;
--use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;
--use ieee.numeric_std_unsigned.all ;

    use std.textio.all;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
use work.ghdl_access.all;


    ENTITY top IS
    END top;

    ARCHITECTURE behavior OF top IS 
      COMPONENT top  
      PORT(
        clk_in : IN  std_logic;
        reset  : IN  std_logic;
        clk_out: OUT std_logic
      );
      END COMPONENT;

      -- Inputs
      signal clk_in  : std_logic := '0';
      signal reset   : std_logic := '0';
      -- Outputs
      signal clk_out : std_logic;
      constant clk_in_t : time := 20 ns; 

signal VGA_R: std_logic_vector(7 downto 0);
signal VGA_G: std_logic_vector(7 downto 0);
signal VGA_B: std_logic_vector(7 downto 0);
      signal  hsync      : std_logic;
      signal  vsync      : std_logic;
      signal  csync      : std_logic;
      signal audio : std_logic;
      signal  hblank      : std_logic;
      signal  vblank      : std_logic;
      signal  video1 : std_logic;
      signal  video2 : std_logic;
      signal  hcnt_o      : std_logic_vector(8 downto 0);
      signal  vcnt_o      : std_logic_vector(8 downto 0);
      signal lamp1:std_logic;
      signal lamp2:std_logic;
      signal clk6:std_logic;
      signal vid_mono:std_logic_vector(7 downto 0);
      signal vid:std_logic_vector(1 downto 0);
      signal color:std_logic_vector(23 downto 0);
      --signal color:unsigned(31 downto 0);
      signal CINT: integer;
      signal vsi: integer;
      signal hsi: integer;



---

        signal CPU_WAIT :  std_logic;
        -- VGA output
        signal VGA_DE : std_logic;
        signal VGA_CLK : std_logic;
        -- Audio
        signal AUDIO_L : std_logic_vector(7 downto 0);
        signal AUDIO_R : std_logic_vector(7 downto 0);
        signal SPEAKER : std_logic;

        signal ps2_key        : std_logic_vector(10 downto 0);

        signal joy            : std_logic_vector(5 downto 0);
        signal joy_an         : std_logic_vector(15 downto 0);

        -- disk control
        signal TRACK          : unsigned(5 downto 0);
        signal TRACK_RAM_ADDR : unsigned(12 downto 0);
        signal TRACK_RAM_DI   : unsigned(7 downto 0);
        signal TRACK_RAM_WE   : std_logic;

        -- main RAM^M
        signal ram_addr      : std_logic_vector(17 downto 0);
        signal ram_dout      : std_logic_vector(7 downto 0);
        signal ram_din       : std_logic_vector(7 downto 0);
        signal ram_we        : std_logic;

        -- LEDG
        signal LED           : std_logic;
---



    BEGIN 

apple2: entity work.apple2
port map(
        -- Clocks
        CLK_14M=> clk_in, -- AJS FIX THIS
        CLK_2M=> clk_in, -- AJS FIX THIS
        CPU_WAIT=>CPU_WAIT,

        reset=> reset,

        -- VGA output
        VGA_DE => VGA_DE,
        VGA_CLK=>VGA_CLK,
        VGA_HS=>hsync,
        VGA_VS=>vsync,
        VGA_R=>VGA_R,
        VGA_G=>VGA_G,
        VGA_B=>VGA_B,
        SCREEN_MODE=>"00",
        -- Audio
        AUDIO_L=>AUDIO_L,
        AUDIO_R=>AUDIO_R,
        SPEAKER=>SPEAKER,

        ps2_key=>PS2_KEY,
        joy=>JOY,
        joy_an=>JOY_AN,

        -- mocking board
        mb_enabled=>'0',
        -- disk control
        TRACK=>TRACK,
        TRACK_RAM_ADDR=>TRACK_RAM_ADDR,
        TRACK_RAM_DI=>TRACK_RAM_DI,
        TRACK_RAM_WE=>TRACK_RAM_WE,

        -- main RAM
        ram_addr=>RAM_ADDR,
        ram_dout=>RAM_DOUT,
        ram_din=>RAM_DIN,
        ram_we=>RAM_WE,

        -- LEDG
        LED=>LED
);

	    
  tv : entity work.tv_controller port map (
    CLK_14M    => CLK_14M,
    VIDEO      => VIDEO,
    COLOR_LINE => COLOR_LINE_CONTROL,
    SCREEN_MODE => SCREEN_MODE,
    HBL        => HBL,
    VBL        => VBL,
    VGA_CLK    => open,
    VGA_HS     => hsync,
    VGA_VS     => vsync,
    VGA_BLANK  => open,
    VGA_R      => r,
    VGA_G      => g,
    VGA_B      => b
    );

color<= VGA_R & VGA_G & VGA_B;
--CINT<=to_integer(color);


--process(vsync,hsync)
--begin
  --if (vsync='1') then
   --  vsi <= 1;
  --else 
   --  vsi <=0;
  --end if;
  --if (hsync='1') then
   --  hsi <= 1;
  --else 
    -- hsi <=0;
  --end if;
--end process;
process
begin
    wait until rising_edge(clk6);

  if (vsync='1') then
     vsi <= 1;
  else 
     vsi <=0;
  end if;
  if (hsync='1') then
     hsi <= 1;
  else 
     hsi <=0;
  end if;
  --dpi_vga_display(vsync,hsync,color);
  dpi_vga_display(vsi,hsi,CINT);
  --dpi_vga_display(vsync,hsync,integer(unsigned(color)));
  --dpi_vga_display(vsync,hsync, "00000000000000000000000010101010" );--"11111111"&vid_mono&vid_mono&vid_mono);
end process;

--process(gearup)
--variable l: line;
--begin
 --write(l,String'("gearup:"));
 --write(l,gearup);
 --writeline(output,l);
--end process;


process(clk_in)
variable l: line;
begin
 write(l,String'("reset:"));
 write(l,reset);
 writeline(output,l);
 write(l,String'("clk"));
-- write(l,clk_in);
 writeline(output,l);
 --write(l,String'("csync"));
 --write(l,csync);
 --writeline(output,l);
 --write(l,String'("VideoW"));
 --write(l,video1);
 --writeline(output,l);
 --write(l,String'("vid_mono"));
 --write(l,vid_mono);
 --writeline(output,l);
end process;



      -- Clock definition.
      entrada_process :process
        begin
        clk_in <= '0';
        wait for clk_in_t / 2;
        clk_in <= '1';
        wait for clk_in_t / 2;
      end process;

      -- Processing.
      stimuli: process
      begin
        reset <= '0'; -- Initial conditions.
        wait for 100 ns;
        reset <= '1'; -- Down to work!
        --dpi_vga_init(320,240);
        dpi_vga_init(640,400);
            wait;
      end process;
    END;

