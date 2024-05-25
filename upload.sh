#!/bin/bash


d=`pwd`
cd ~/ArthurConfig
git add .
git commit -m "just upload"
git push -u origin main
cd $d
