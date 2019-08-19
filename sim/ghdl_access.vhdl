library ieee; use ieee.std_logic_1164.all;
package ghdl_access is
  -- Définit un pointeur vers un entier :

  procedure dpi_vga_init(h,v : integer);
    attribute foreign of dpi_vga_init:
      procedure is "VHPIDIRECT dpi_vga_init";

  procedure dpi_vga_display(vsync,hsync,pixel: in integer );
    attribute foreign of dpi_vga_display:
      procedure is "VHPIDIRECT dpi_vga_display";

end ghdl_access;

package body ghdl_access is
  procedure dpi_vga_init(h,v : integer ) is
  begin
    assert false report "VHPI" severity failure;
  end dpi_vga_init;
  procedure dpi_vga_display(vsync,hsync,pixel : in integer   ) is
  begin
    assert false report "VHPI" severity failure;
  end dpi_vga_display;
end ghdl_access;
