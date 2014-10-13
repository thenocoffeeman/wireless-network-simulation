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
set val(sc)             "tcp-30-test"
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
set tracefd	[open tcpwireless-out.tr w]

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
# Define traffic model
#
puts "Loading scenario file..."
source $val(sc)


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
