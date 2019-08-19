mkdir -p altera_mf
mkdir -p work
GHDL=~/Documents/development/verilog/ghdl-llvm/bin/ghdl
gcc -c ghdl_access.c -o ghdl_access_c.o
${GHDL} -a -g --std=08 --work=altera_mf --workdir=altera_mf --ieee=synopsys altera_*.vhd

#${GHDL} -a -g -v --workdir=work -Paltera_mf --ieee=synopsys \
${GHDL} -i -g -v --std=08 --workdir=work -Paltera_mf --ieee=synopsys \
 ../t65/T65_Pack.vhd ../t65/T65_ALU.vhd    ../t65/T65_MCode.vhd  ../t65/T65.vhd  \
spram.vhd \
clkdiv.vhd \
../PS2_Ctrl.vhd \
../keyboard.vhd \
../R65Cx2.vhd \
../video_generator.vhd \
../tv_controller.vhd \
../timing_generator.vhd \
../disk_ii_rom.vhd \
../disk_ii.vhd \
../apple2.vhd \
napple2_sim.vhd

${GHDL} -a -g -v --workdir=work -Paltera_mf --ieee=synopsys \
../R65Cx2.vhd 
 
${GHDL} -a -g -v --std=08 --workdir=work -Paltera_mf --ieee=synopsys \
 ../t65/T65_Pack.vhd ../t65/T65_ALU.vhd    ../t65/T65_MCode.vhd  ../t65/T65.vhd  \
spram.vhd \
clkdiv.vhd \
../PS2_Ctrl.vhd \
../keyboard.vhd \
../video_generator.vhd \
../tv_controller.vhd \
../timing_generator.vhd \
../disk_ii_rom.vhd \
../disk_ii.vhd  \
../apple2.vhd \
ghdl_access.vhdl \
napple2_sim.vhd
 
#set_global_assignment -name SYSTEMVERILOG_FILE "Apple-II.sv"
#${GHDL} -m -g -v -Pwork -Paltera_mf  --std=08 --ieee=synopsys --workdir=work --ieee=synopsys -Wl,ghdl_access_c.o -Wl,-lSDL2 top 
${GHDL} -m -g -v -Pwork -Paltera_mf  --std=08 --ieee=synopsys --workdir=work --ieee=synopsys -Wl,ghdl_access_c.o -Wl,-lSDL2 top 
#${GHDL} -e -g -v -Pwork -Paltera_mf --std=08 --ieee=synopsys --workdir=work --ieee=synopsys -Wl,ghdl_access_c.o -Wl,-lSDL2 top 
