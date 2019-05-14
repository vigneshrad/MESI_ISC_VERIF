#Tcl script which can be used with JasperGold
clear -all

#Reading the files (.v and .sv) 

#analysing the RTL files the DUT
analyze -v2k ../rtl/mesi_isc_define.v ../rtl/mesi_isc.v ../rtl/mesi_isc_basic_fifo.v ../rtl/mesi_isc_broad.v ../rtl/mesi_isc_breq_fifos.v ../rtl/mesi_isc_breq_fifos_cntl.v ../rtl/mesi_isc_broad_cntl.v 

#analusing the Bind Wrapper for the DUT
analyze -sv bind_wrapper.sv

#Elaborating the design, also specifying the top module
elaborate -top mesi_isc

#Set the clock
clock clk

#Set Reset
reset rst

#Prove all
prove -bg -all
