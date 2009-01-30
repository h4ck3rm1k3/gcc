#!/bin/sh
##
## makebuild.sh
## 
## Made by Michael DuPont
## Login   <mdupont@mdupontdesktop2>
## 
## Started on  Fri Jan 30 11:03:14 2009 Michael DuPont
## Last update Fri Jan 30 11:03:14 2009 Michael DuPont
##

echo create a build dir to run the build in
mkdir build

# go into it
cd build

# run the configure relative to this 
../gcc/configure --with-src=../gcc/

make

