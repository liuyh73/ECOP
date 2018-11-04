@echo off
rem  Vivado(TM)
rem  compile.bat: a Vivado-generated XSim simulation Script
rem  Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.

set PATH=%XILINX%\lib\%PLATFORM%;%XILINX%\bin\%PLATFORM%;E:/Xilinx/Vivado/2014.2/ids_lite/ISE/bin/nt64;E:/Xilinx/Vivado/2014.2/ids_lite/ISE/lib/nt64;E:/Xilinx/Vivado/2014.2/bin;%PATH%
set XILINX_PLANAHEAD=E:/Xilinx/Vivado/2014.2

xelab -m64 --debug typical --relax -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot Single_CPU_sim_behav --prj D:/Vivado_projects/Single_CPU/Single_CPU.sim/sim_1/behav/Single_CPU_sim.prj   xil_defaultlib.Single_CPU_sim   xil_defaultlib.glbl
if errorlevel 1 (
   cmd /c exit /b %errorlevel%
)
