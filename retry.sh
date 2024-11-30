#!/bin/bash

## Must create SQL sentences for select ID MqType which want to be retried.

echo "Hi Na-chan!"
echo "Go to purchaseRequest Recovery!"

currentTime="`date +%Y%m%d%H%M%S`";
echo ${currentTime}

echo "What type you want to recovery? (1: ComPurReq, 2: ComPurRst, 3: ComPurSrc, 4: ComPurInf) "
read inputype

mqType=''
case $inputype in
    "1" )
        echo "koubaiirai!"
        mqType="PurchaseReq"
    ;;

    "2")
        echo "kounyuuyoukyuu"
        mqType="purchaseRequition"
    ;; 
    
    "3")
        echo "kyoukyuumoto"
        mqType="PurchaseSource"
    ;;
    
    "4")
        echo "koubaijouhou"
        mqType="PurchaseInfor"
    ;;

    *)
        echo "Error!"
    ;;
esac

outputFileName=${mqType}_${currentTime}.txt

mqIds=()
## Get Id and create content for importing to MqFile
while read id; do
    # echo ${id}
    mqIds+='<purchaseRequestId>'"${id}"'</purchaseRequestId>\n'
done < ./data.txt

## read file format
line=1
while read contentFormat; do
    # echo $line
    if [ $line = 2 ];then 
        echo ${mqIds} >>./mq/${outputFileName}
    fi

    echo ${contentFormat} >>./mq/${outputFileName}
    line=$((line + 1))
done < ./Format/${mqType}.txt


## execute SQl for update Mirroring Status


## execute Batch for MQ