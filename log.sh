#!/bin/bash
FILENAME="JLOG-$(date '+%Y-%m-%d_%H-%M-%S').csv"

# Delimiter (tab) + disabling new line
DELIM=','

echo -e "date time$(free -m | grep total | sed -E 's/^    (.*)/\1/g' | sed "s/ \+ /$DELIM/g") \c" | tee $FILENAME
echo -e "$DELIM Swap\c" | tee -a $FILENAME
echo -e "$DELIM GPU memory$DELIM CPU freq$DELIM GPU freq$DELIM GPU util$DELIM CPU temp$DELIM GPU temp" | tee -a $FILENAME

#watch -n1 "./log_eachline.sh >> $FILENAME"

for (( ; ; ))
do
	./log_eachline.sh $FILENAME $DELIM
	sleep 1
done
