#!/bin/sh

path=`dirname $0`

#first step: odex2-dex
java -jar $path/lib/oat2dex.jar odex $1

#second step: 
for i in `ls ${1}-odex`;do
$path/lib/jadx/bin/jadx -d out_temp ${1}-odex/$i
done;

#clean temp file and folder