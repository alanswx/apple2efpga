  LIBRARY ieee;
    USE ieee.std_logic_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.all;
--use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all ;

    use std.textio.all;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
use work.ghdl_access.all;


    ENTITY top IS
    END top;

    ARCHITECTURE behavior OF top IS 
      --COMPONENT top  
      --PORT(
        --clk_in : IN  std_logic;
        --reset  : IN  std_logic;
        --clk_out: OUT std_logic
      --);
      --END COMPONENT;

      -- Inputs
      signal clk_in  : std_logic := '0';
      signal reset   : std_logic := '0';
      -- Outputs
      signal clk_out : std_logic;
      constant clk_in_t : time := 71 ns; 

      signal color:std_logic_vector(23 downto 0);
      --signal color:unsigned(31 downto 0);
      signal CINT: integer;
      signal vsi: integer;
      signal hsi: integer;



----

  signal CLK_28M, CLK_14M, CLK_2M, CLK_2M_D, PHASE_ZERO : std_logic;
  signal clk_div : unsigned(1 downto 0);
  signal IO_SELECT, DEVICE_SELECT : std_logic_vector(7 downto 0);
  signal ADDR : unsigned(15 downto 0);
  signal D, PD: unsigned(7 downto 0);
  signal DISK_DO, PSG_DO : unsigned(7 downto 0);
  signal DO : std_logic_vector(15 downto 0);
  signal aux : std_logic;
  signal cpu_we : std_logic;
  signal psg_irq_n, psg_nmi_n : std_logic;

  signal we_ram : std_logic;
  signal VIDEO, HBL, VBL : std_logic;
  signal COLOR_LINE : std_logic;
  signal COLOR_LINE_CONTROL : std_logic;
  signal SCREEN_MODE : std_logic_vector(1 downto 0);
  signal GAMEPORT : std_logic_vector(7 downto 0);
  signal scandoubler_disable : std_logic;
  signal ypbpr : std_logic;

  signal K : unsigned(7 downto 0);
  signal read_key : std_logic;
  signal akd : std_logic;

  signal flash_clk : unsigned(22 downto 0) := (others => '0');
  signal power_on_reset : std_logic := '1';
 -- signal reset : std_logic;

  signal D1_ACTIVE, D2_ACTIVE : std_logic;
  signal track_addr : unsigned(13 downto 0);
  signal TRACK_RAM_ADDR : unsigned(12 downto 0);
  signal TRACK_RAM_DI : unsigned(7 downto 0);
  signal TRACK_RAM_WE : std_logic;
  signal track : unsigned(5 downto 0);
  signal disk_change : std_logic;

  signal downl : std_logic := '0';
  signal io_index : std_logic_vector(4 downto 0);
  signal size : std_logic_vector(24 downto 0) := (others=>'0');
  signal a_ram: unsigned(15 downto 0);
  signal r : unsigned(7 downto 0);
  signal g : unsigned(7 downto 0);
  signal b : unsigned(7 downto 0);
  signal hsync : std_logic;
  signal vsync : std_logic;
  signal sd_we : std_logic;
  signal sd_oe : std_logic;
  signal sd_addr : std_logic_vector(18 downto 0);
  signal sd_di : std_logic_vector(7 downto 0);
  signal sd_do : std_logic_vector(7 downto 0);
  signal io_we : std_logic;
  signal io_addr : std_logic_vector(24 downto 0);
  signal io_do : std_logic_vector(7 downto 0);
  signal io_ram_we : std_logic;
  signal io_ram_d : std_logic_vector(7 downto 0);
  signal io_ram_addr : std_logic_vector(18 downto 0);
  signal ram_we : std_logic;
  signal ram_di : std_logic_vector(7 downto 0);
  signal ram_addr : std_logic_vector(24 downto 0);
  
  signal switches   : std_logic_vector(1 downto 0);
  signal buttons    : std_logic_vector(1 downto 0);
  signal joy        : std_logic_vector(5 downto 0);
  signal joy0       : std_logic_vector(31 downto 0);
  signal joy1       : std_logic_vector(31 downto 0);
  signal joy_an0    : std_logic_vector(15 downto 0);
  signal joy_an1    : std_logic_vector(15 downto 0);
  signal joy_an     : std_logic_vector(15 downto 0);
  signal status     : std_logic_vector(31 downto 0);
  signal ps2Clk     : std_logic;
  signal ps2Data    : std_logic;
  
  signal psg_audio_l : unsigned(9 downto 0);
  signal psg_audio_r : unsigned(9 downto 0);
  signal audio       : std_logic;

  -- signals to connect sd card emulation with io controller
  signal sd_lba:  std_logic_vector(31 downto 0);
  signal sd_rd:   std_logic;
  signal sd_wr:   std_logic;
  signal sd_ack:  std_logic;
  
  -- data from io controller to sd card emulation
  signal sd_data_in: std_logic_vector(7 downto 0);
  signal sd_data_out: std_logic_vector(7 downto 0);
  signal sd_data_out_strobe:  std_logic;
  signal sd_buff_addr: std_logic_vector(8 downto 0);
  
  -- sd card emulation
  signal sd_cs:	std_logic;
  signal sd_sck:	std_logic;
  signal sd_sdi:	std_logic;
  signal sd_sdo:	std_logic;
  
  signal pll_locked : std_logic;
  signal sdram_dqm: std_logic_vector(1 downto 0);
  signal joyx       : std_logic;
  signal joyy       : std_logic;
  signal pdl_strobe : std_logic;


    BEGIN 



  -- In the Apple ][, this was a 555 timer
  power_on : process(CLK_14M)
  begin
    if rising_edge(CLK_14M) then
      reset <= status(0) or power_on_reset;

      if buttons(1)='1' or status(7) = '1' then
        power_on_reset <= '1';
        flash_clk <= (others=>'0');
      else
		  if flash_clk(22) = '1' then
          power_on_reset <= '0';
			end if;
			 
        flash_clk <= flash_clk + 1;
      end if;
    end if;
  end process;
  
  --SDRAM_CLK <= CLK_28M;
  

 
  -- Paddle buttons
  -- GAMEPORT input bits:
  --  7    6    5    4    3   2   1    0
  -- pdl3 pdl2 pdl1 pdl0 pb3 pb2 pb1 casette
  GAMEPORT <=  "00" & joyy & joyx & "0" & joy(5) & joy(4) & '0';
  
  joy_an <= joy_an0 when status(5)='0' else joy_an1;
  joy <= joy0(5 downto 0) when status(5)='0' else joy1(5 downto 0);
  
  process(CLK_14M, pdl_strobe)
    variable cx, cy : integer range -100 to 5800 := 0;
  begin
    if rising_edge(CLK_14M) then
     CLK_2M_D <= CLK_2M;
     if CLK_2M_D = '0' and CLK_2M = '1' then
      if cx > 0 then
        cx := cx -1;
        joyx <= '1';
      else
        joyx <= '0';
      end if;
      if cy > 0 then
        cy := cy -1;
        joyy <= '1';
      else
        joyy <= '0';
      end if;
      if pdl_strobe = '1' then
        cx := 2800+(22*to_integer(signed(joy_an(15 downto 8))));
        cy := 2800+(22*to_integer(signed(joy_an(7 downto 0)))); -- max 5650
        if cx < 0 then
          cx := 0;
        elsif cx >= 5590 then
          cx := 5650;
        end if;
        if cy < 0 then
          cy := 0;
        elsif cy >= 5590 then
          cy := 5650;
        end if;
      end if;
     end if;
    end if;
  end process;

  COLOR_LINE_CONTROL <= COLOR_LINE and not (status(2) or status(3));  -- Color or B&W mode
  SCREEN_MODE <= status(3 downto 2); -- 00: Color, 01: B&W, 10:Green, 11: Amber
  

  
  -- Simulate power up on cold reset to go to the disk boot routine
  ram_we   <= we_ram when status(7) = '0' else '1';
  ram_addr <= "000000000" & std_logic_vector(a_ram) when status(7) = '0' else std_logic_vector(to_unsigned(1012,ram_addr'length)); -- $3F4
  ram_di   <= std_logic_vector(D) when status(7) = '0' else "00000000";

  PD <= PSG_DO when IO_SELECT(4) = '1' else DISK_DO;

  core : entity work.apple2 port map (
    CLK_14M        => CLK_14M,
    CLK_2M         => CLK_2M,
    PHASE_ZERO     => PHASE_ZERO,
    FLASH_CLK      => flash_clk(22),
    reset          => reset,
    cpu            => '0',
    ADDR           => ADDR,
    ram_addr       => a_ram,
    D              => D,
    ram_do         => unsigned(DO),
    aux            => aux,
    PD             => PD,
    CPU_WE         => cpu_we,
    IRQ_N          => psg_irq_n,
    NMI_N          => psg_nmi_n,
    ram_we         => we_ram,
    VIDEO          => VIDEO,
    COLOR_LINE     => COLOR_LINE,
    HBL            => HBL,
    VBL            => VBL,
    K              => K,
    read_key       => read_key,
    AKD            => akd,
    AN             => open,
    GAMEPORT       => GAMEPORT,
    PDL_strobe     => pdl_strobe,
    IO_SELECT      => IO_SELECT,
    DEVICE_SELECT  => DEVICE_SELECT,
    speaker        => audio
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

  keyboard : entity work.keyboard port map (
    PS2_Clk  => ps2Clk,
    PS2_Data => ps2Data,
    CLK_14M  => CLK_14M,
    reset    => reset,
    reads    => read_key,
    K        => K,
    akd      => akd
    );

  disk : entity work.disk_ii port map (
    CLK_14M        => CLK_14M,
    CLK_2M         => CLK_2M,
    PHASE_ZERO     => PHASE_ZERO,
    IO_SELECT      => IO_SELECT(6),
    DEVICE_SELECT  => DEVICE_SELECT(6),
    RESET          => reset,
    A              => ADDR,
    D_IN           => D,
    D_OUT          => DISK_DO,
    TRACK          => TRACK,
    TRACK_ADDR     => TRACK_ADDR,
    D1_ACTIVE      => D1_ACTIVE,
    D2_ACTIVE      => D2_ACTIVE,
    ram_write_addr => TRACK_RAM_ADDR,
    ram_di         => TRACK_RAM_DI,
    ram_we         => TRACK_RAM_WE
    );



 -- LED <= not (D1_ACTIVE or D2_ACTIVE);



	    

color<= std_logic_vector(r) & std_logic_vector(g) & std_logic_vector(b);
CINT<=to_integer(color);


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
    wait until rising_edge(clk_in);

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
 write(l,clk_in);
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

        clk1: entity work.clkdiv generic map ( DIVRATIO => 7)
         port map ( clk => CLK_14M,
         nreset => reset,
          clkout => CLK_2M);

  CLK_14M<=clk_in;


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
    END ARCHITECTURE;

