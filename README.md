Please refer to MATLAB IMPLOY for details operations of adding/deleting/moving anchor points

1. 	unzip your downloaded folder
2. 	cd whereYouUnZip
3. 		>> addpath(genpath(pwd))
4. 1 	start from the first frame
		>> test_label(0, 0, 1)
4.2  	if you label something wrong in frame N (will be shown as frame title), you could start over from that frame by press "cancel" to break the program first. Then run the following command: 
		>> test_label(1, 0, N)

5 	You may need to label the following three types of objects: 
		1. People
		2. Car
		3. Plant (including grass and trees, label trees only if they are solid)
