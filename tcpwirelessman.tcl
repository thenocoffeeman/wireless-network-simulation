# Name: Hung (Michael) Ngo 

# ======================================================================
# Define options
# ======================================================================

set val(chan)       Channel/WirelessChannel
set val(prop)       Propagation/TwoRayGround
set val(netif)      Phy/WirelessPhy
set val(mac)        Mac/802_11
set val(ifq)        Queue/DropTail/PriQueue
set val(ll)         LL
set val(ant)        Antenna/OmniAntenna
set val(x)              10   ;# X dimension of the topography
set val(y)              10   ;# Y dimension of the topography
set val(ifqlen)         50            ;# max packet in ifq
set val(seed)           0.0
set val(adhocRouting)   DSR
set val(nn)             30             ;# how many nodes are simulated
set val(stop)           10.0           ;# simulation time

# =====================================================================
# Main Program
# ======================================================================

#
# Initialize Global Variables
#

# create simulator instance
set ns_		[new Simulator]

# setup topography object
set topo	[new Topography]

# create trace object for ns and nam
set tracefd	[open tcpwirelessman-out.tr w]

# Enable new trace format
$ns_ use-newtrace

$ns_ trace-all $tracefd

# define topology
$topo load_flatgrid $val(x) $val(y)

#
# Create God
#
set god_ [create-god $val(nn)]

#
# define how node should be created
#

#global node setting

$ns_ node-config -adhocRouting $val(adhocRouting) \
                 -llType $val(ll) \
                 -macType $val(mac) \
                 -ifqType $val(ifq) \
                 -ifqLen $val(ifqlen) \
                 -antType $val(ant) \
                 -propType $val(prop) \
                 -phyType $val(netif) \
                 -channelType $val(chan) \
		 -topoInstance $topo \
		 -agentTrace ON \
                 -routerTrace ON \
                 -macTrace OFF

#
#  Create the specified number of nodes [$val(nn)] and "attach" them
#  to the channel.

for {set i 0} {$i < $val(nn) } {incr i} {
	set node_($i) [$ns_ node]
	$node_($i) random-motion 0		;# disable random motion
}


#
# Initial coordinates for nodes
#
$node_(0) set X_ 5.0
$node_(0) set Y_ 2.0
$node_(0) set Z_ 0.0

$node_(1) set X_ 4.0
$node_(1) set Y_ 3.0
$node_(1) set Z_ 0.0

$node_(2) set X_ 9.0
$node_(2) set Y_ 8.0
$node_(2) set Z_ 0.0

$node_(3) set X_ 6.5
$node_(3) set Y_ 7.0
$node_(3) set Z_ 0.0

$node_(4) set X_ 4.0
$node_(4) set Y_ 2.5
$node_(4) set Z_ 0.0

$node_(5) set X_ 6.0
$node_(5) set Y_ 3.5
$node_(5) set Z_ 0.0

$node_(6) set X_ 8.0
$node_(6) set Y_ 2.0
$node_(6) set Z_ 0.0

$node_(7) set X_ 7.0
$node_(7) set Y_ 5.0
$node_(7) set Z_ 0.0

$node_(8) set X_ 3.0
$node_(8) set Y_ 4.5
$node_(8) set Z_ 0.0

$node_(9) set X_ 1.0
$node_(9) set Y_ 9.5
$node_(9) set Z_ 0.0

$node_(10) set X_ 2.0
$node_(10) set Y_ 6.3
$node_(10) set Z_ 0.0

$node_(11) set X_ 4.8
$node_(11) set Y_ 8.2
$node_(11) set Z_ 0.0

$node_(12) set X_ 3.8
$node_(12) set Y_ 9.5
$node_(12) set Z_ 0.0

$node_(13) set X_ 8.7
$node_(13) set Y_ 2.8
$node_(13) set Z_ 0.0

$node_(14) set X_ 5.4
$node_(14) set Y_ 9.1
$node_(14) set Z_ 0.0

$node_(15) set X_ 7.3
$node_(15) set Y_ 8.8
$node_(15) set Z_ 0.0

$node_(16) set X_ 3.1
$node_(16) set Y_ 9.1
$node_(16) set Z_ 0.0

$node_(17) set X_ 2.9
$node_(17) set Y_ 9.9
$node_(17) set Z_ 0.0

$node_(18) set X_ 3.7
$node_(18) set Y_ 2.2
$node_(18) set Z_ 0.0

$node_(19) set X_ 7.4
$node_(19) set Y_ 4.6
$node_(19) set Z_ 0.0

$node_(20) set X_ 8.9
$node_(20) set Y_ 1.3
$node_(20) set Z_ 0.0

$node_(21) set X_ 5.1
$node_(21) set Y_ 6.9
$node_(21) set Z_ 0.0

$node_(22) set X_ 4.4
$node_(22) set Y_ 9.9
$node_(22) set Z_ 0.0

$node_(23) set X_ 6.8
$node_(23) set Y_ 1.1
$node_(23) set Z_ 0.0

$node_(24) set X_ 8.3
$node_(24) set Y_ 3.4
$node_(24) set Z_ 0.0

$node_(25) set X_ 2.6
$node_(25) set Y_ 7.5
$node_(25) set Z_ 0.0

$node_(26) set X_ 7.4
$node_(26) set Y_ 9.4
$node_(26) set Z_ 0.0

$node_(27) set X_ 2.8
$node_(27) set Y_ 6.3
$node_(27) set Z_ 0.0

$node_(28) set X_ 5.2
$node_(28) set Y_ 6.4
$node_(28) set Z_ 0.0

$node_(29) set X_ 2.2
$node_(29) set Y_ 7.7
$node_(29) set Z_ 0.0


#
# Establish TCP connection
#
set tcp_(0) [new Agent/TCP/Reno]
set sink_(0) [new Agent/TCPSink]
$tcp_(0) set window 500
$tcp_(0) set packetSize 1024
$ns_ attach-agent $node_(0) $tcp_(0)
$ns_ attach-agent $node_(20) $sink_(0)
$ns_ connect $tcp_(0) $sink_(0)
set ftp_(0) [new Application/FTP]
$ftp_(0) attach-agent $tcp_(0)
$ns_ at 1.05644 "$ftp_(0) start"

set tcp_(1) [new Agent/TCP/Reno]
set sink_(1) [new Agent/TCPSink]
$tcp_(1) set window 500
$tcp_(1) set packetSize 1024
$ns_ attach-agent $node_(1) $tcp_(1)
$ns_ attach-agent $node_(21) $sink_(1)
$ns_ connect $tcp_(1) $sink_(1)
set ftp_(1) [new Application/FTP]
$ftp_(1) attach-agent $tcp_(1)
$ns_ at 167.94106 "$ftp_(1) start"

set tcp_(2) [new Agent/TCP/Reno]
set sink_(2) [new Agent/TCPSink]
$tcp_(2) set window 500
$tcp_(2) set packetSize 1024
$ns_ attach-agent $node_(2) $tcp_(2)
$ns_ attach-agent $node_(22) $sink_(2)
$ns_ connect $tcp_(2) $sink_(2)
set ftp_(2) [new Application/FTP]
$ftp_(2) attach-agent $tcp_(2)
$ns_ at 80.84141 "$ftp_(2) start"

set tcp_(3) [new Agent/TCP/Reno]
set sink_(3) [new Agent/TCPSink]
$tcp_(3) set window 500
$tcp_(3) set packetSize 1024
$ns_ attach-agent $node_(3) $tcp_(3)
$ns_ attach-agent $node_(23) $sink_(3)
$ns_ connect $tcp_(3) $sink_(3)
set ftp_(3) [new Application/FTP]
$ftp_(3) attach-agent $tcp_(3)
$ns_ at 59.22420 "$ftp_(3) start"

set tcp_(4) [new Agent/TCP/Reno]
set sink_(4) [new Agent/TCPSink]
$tcp_(4) set window 500
$tcp_(4) set packetSize 1024
$ns_ attach-agent $node_(4) $tcp_(4)
$ns_ attach-agent $node_(24) $sink_(4)
$ns_ connect $tcp_(4) $sink_(4)
set ftp_(4) [new Application/FTP]
$ftp_(4) attach-agent $tcp_(4)
$ns_ at 147.20770 "$ftp_(4) start"

set tcp_(5) [new Agent/TCP/Reno]
set sink_(5) [new Agent/TCPSink]
$tcp_(5) set window 500
$tcp_(5) set packetSize 1024
$ns_ attach-agent $node_(5) $tcp_(5)
$ns_ attach-agent $node_(25) $sink_(5)
$ns_ connect $tcp_(5) $sink_(5)
set ftp_(5) [new Application/FTP]
$ftp_(5) attach-agent $tcp_(5)
$ns_ at 150.62913 "$ftp_(5) start"

set tcp_(6) [new Agent/TCP/Reno]
set sink_(6) [new Agent/TCPSink]
$tcp_(6) set window 500
$tcp_(6) set packetSize 1024
$ns_ attach-agent $node_(6) $tcp_(6)
$ns_ attach-agent $node_(26) $sink_(6)
$ns_ connect $tcp_(6) $sink_(6)
set ftp_(6) [new Application/FTP]
$ftp_(6) attach-agent $tcp_(6)
$ns_ at 136.71515 "$ftp_(6) start"

set tcp_(7) [new Agent/TCP/Reno]
set sink_(7) [new Agent/TCPSink]
$tcp_(7) set window 500
$tcp_(7) set packetSize 1024
$ns_ attach-agent $node_(7) $tcp_(7)
$ns_ attach-agent $node_(27) $sink_(7)
$ns_ connect $tcp_(7) $sink_(7)
set ftp_(7) [new Application/FTP]
$ftp_(7) attach-agent $tcp_(7)
$ns_ at 100.17584 "$ftp_(7) start"

set tcp_(8) [new Agent/TCP/Reno]
set sink_(8) [new Agent/TCPSink]
$tcp_(8) set window 500
$tcp_(8) set packetSize 1024
$ns_ attach-agent $node_(8) $tcp_(8)
$ns_ attach-agent $node_(28) $sink_(8)
$ns_ connect $tcp_(8) $sink_(8)
set ftp_(8) [new Application/FTP]
$ftp_(8) attach-agent $tcp_(8)
$ns_ at 48.54536 "$ftp_(8) start"

set tcp_(9) [new Agent/TCP/Reno]
set sink_(9) [new Agent/TCPSink]
$tcp_(9) set window 500
$tcp_(9) set packetSize 1024
$ns_ attach-agent $node_(9) $tcp_(9)
$ns_ attach-agent $node_(29) $sink_(9)
$ns_ connect $tcp_(9) $sink_(9)
set ftp_(9) [new Application/FTP]
$ftp_(9) attach-agent $tcp_(9)
$ns_ at 14.44060 "$ftp_(9) start"


#
# Tell nodes when the simulation ends
#
for {set i 0} {$i < $val(nn) } {incr i} {
    $ns_ at $val(stop).0 "$node_($i) reset";
}

$ns_ at  $val(stop).0002 "puts \"NS EXITING...\" ; $ns_ halt"

#
# Header info
#
puts $tracefd "M 0.0 nn $val(nn) x $val(x) y $val(y) rp $val(adhocRouting)"
#puts $tracefd "M 0.0 sc $val(sc) cp $val(cp) seed $val(seed)"
puts $tracefd "M 0.0 prop $val(prop) ant $val(ant)"

puts "Starting Simulation..."
$ns_ run
