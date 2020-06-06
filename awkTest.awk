BEGIN{
    receiverPktNum=0;
    cur_qsize=0;
    count_20=0;
    qsizeSum=0;
    drop=0;
    N=100000;

}
 {
     event=$1;
     time = $2;
     node = $3; #发生事件的节点
     nodeNum=substr(node,11,1); #get node num




     if(nodeNum==0){

     if(event == "d"){
        drop++
     }

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
        start_time[packet_id]=time
        cur_qsize++
        #if(cur_qsize>0)print  cur_qsize
        qsizeSum=qsizeSum+cur_qsize
     }
     if(event=="-"){
        end_time[packet_id]=time
        cur_qsize--
        if(cur_qsize>=20){count_20++}
     }
     if(event == "r"&&receiver[packet_id]!=1){
        receiver[packet_id]=1
        if(packet_id==N)print time
     }
     if(event == "d"){
        drop++
     }




}#if(nodeNUm)

 }

 END{
     result = qsizeSum/N


     printf("平均队长：%f\n",result)

     printf("丢包率：%f\n",drop/N) 
     p20=count_20/N
     printf("队长大于20的概率：%f\n",count_20/N) 
 }

 #awk -f awkTest.awk mytest.tr  > resultTest.result
