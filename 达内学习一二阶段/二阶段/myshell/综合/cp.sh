#!/bin/bash
jindu(){
while : 
do
	echo -n '#'
	sleep 0.2
done
}
jindu &
cp -r $1 $2
echo "copy over!!!"
kill $!
