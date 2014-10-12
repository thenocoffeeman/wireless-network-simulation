wireless-network-simulation
===========================

Simulation and Performance Analysis (tcl/awk)

-	Generate traffic pattern:  ns cbrgen.tcl –type tcp –nn 3 –seed 1 –mc 10 > tcp-30-test
-	Ns tcpwirelessman.tcl
-	Awk –f throughput.awk tcpwireless-out.tr > Throughput
-	cat Throughput

New trace format was used: http://www.isi.edu/nsnam/ns/doc/node186.html
