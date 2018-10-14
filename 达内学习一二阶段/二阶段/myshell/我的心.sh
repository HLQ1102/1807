#!/bin/bash
a(){ echo "
             @@@@@@  @@@@@@
            @@@@@@@@@@@@@@@@
           @@@@@@@@@@@@@@@@@@
            @@@@@@@@@@@@@@@@
             @@@@@@@@@@@@@@
               @@@@@@@@@@
                 @@@@@@
                   @@
"; }
for x in {1..5}
do 
a > 1.txt;for i in {1..60}
do clear;sed -ni  's/^.//p' 1.txt
cat 1.txt
sleep 0.1
done
done

