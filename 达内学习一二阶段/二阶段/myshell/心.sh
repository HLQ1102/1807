#!/bin/bash
b(){
echo "
             @@@@@    @@@@@
            @@@@@@@  @@@@@@@
           @@@@@@@@@@@@@@@@@@
            @@@@@@@@@@@@@@@@
             @@@@@@@@@@@@@@
               @@@@@@@@@@
                 @@@@@@
                   @@
             @@@@@@  @@@@@@
            @@@@@@@@@@@@@@@@
           @@@@@@@@@@@@@@@@@@
            @@@@@@@@@@@@@@@@
             @@@@@@@@@@@@@@
               @@@@@@@@@@
                 @@@@@@
                   @@
" > asdfgh.txt
}
while :
do
b
for i in {1..60}
do
        clear
        sed -i  -r 's/^(.)(.*)(.)$/\2\3/' asdfgh.txt
        sed -r 's/^(.{15})(.*)/\1/' asdfgh.txt
        sleep 0.5 
done
done
