BEGIN{
    receiverPktNum=0;
    cur_qsize=0;
    count_20=0;
    qsizeSum=0;
    drop=0;
}
 {
     event=$1;
     time = $2;
     node = $3; #发生事件的节点
     nodeNum=substr(node,11,1); #get node num



     if(nodeNum==0){



     for (i=1;i<=NF;i++)#find packet ID
 
{
 
if ($i ~ /id/) #if $i field matches "id"
 
           myPacketID = $(i+1);#record the id of the packet for future use
 
else if ($i ~ />/) #if $i field matches ">"
 
{
 
             srcIP = $(i-1);
 
             dstIP = $(i+1);
 
             if(match(srcIP, myScrIP) && match(dstIP, myDstIP) )#link matches
 
             {      
 
 
            packet_id = myPacketID;
            break;

                #start to record the information of the packet


 
}#if
 
}#else if
 
}#for


     if(event=="+"){
        cur_qsize++
        printf ("%f\t%d\n",$2,cur_qsize)
     }
     if(event=="-"){

        cur_qsize--

     }




}#if(节点判断)

 }

 END{


 }

 #awk -f awkView.awk mytest.tr  > resultView.result
