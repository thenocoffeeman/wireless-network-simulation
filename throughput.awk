# AWK Script to calculate throughtput (new trace format)
# Source: http://mohittanhiliani.blogspot.com/2010/03/awk-script-for-ns2-supporting-new-trace.html

BEGIN {
	recvdSize = 0
	startTime = 400
	stopTime = 0
}

{
	event = $1
	time = $3
	node_id = $9
	pkt_size = $37
	level = $19

	#Store start time
	if (level == "AGT" && event == "s" && pkt_size > 512) {
		if (time < startTime) {
			startTime = time
		}
	}

	# Update total received packets' size and store packet arrival time
	if (level == "AGT" && event == "r" && pkt_size > 512) {
		if (time > stopTime) {
			stopTime = time
		}

		# Rip off the header
		hdr_size = pkt_size % 512
		pkt_size -= hdr_size
		
		# Store received packet's size
		#printf("%.2f\t%.2f\n", stopTime-startTime, recvdSize)
		recvdSize += pkt_size
	}
}

END {
	printf("Average Throughput[kbps] = %.2f\t\t StartTime=%.2f\tStopTime=%.2f\n", (recvdSize/(stopTime-startTime))*(8/1000), startTime, stopTime)
}
