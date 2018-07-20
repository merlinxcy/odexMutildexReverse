#!/bin/sh
rm -rf smali_*
rm -rf smali

path=`dirname $0`

#first step: odex2-dex
java -jar $path/lib/oat2dex.jar odex $1

#second step: dex2smali
mkdir smali
for i in `ls ${1}-odex`;do
echo "[*]Dex2Smali: $i"
java -jar $path/lib/baksmali.jar d ${1}-odex/$i -o smali_$i
#third step: merge all smali filesystem
cp -rf smali_$i/* smali/
done;

#third step: smali2dex
java -jar $path/lib/smali.jar assemble smali -o ${1}_final.dex

#final step: dex2jar and open the GUI or dex to jadx
$path/lib/dex2jar-2.0/d2j-dex2jar.sh ${1}_final.dex # in order to get jar
#$path/lib/jadx/bin/jadx-gui ${1}_final.dex # you can close it

#clean temp file and folder
rm -rf smali_*
rm -rf smali
