#! /bin/bash

# Bash installer for clarjon1 and Flare183's Annoying-Song-Announcer
# Copyright 2011 clarjon1 and Flare183

echo "Bash installer script for clarjon1 and Flare183's Annoying-Song-Announcer"
echo "-------------------------------------------------------------------------"
echo "Searching for clementine...."
echo "(To begin with that is"

CLEMENTINE = `ls /usr/bin/ | grep clementine`
AMAROK = `ls /usr/bin/ | grep amarok"`

if
    $CLEMENTINE = "clementine"
then
    echo "I see your using clementine"
    echo "Copying clementine asaconf file..."
    cp -v $CURDIR/asaconf-clementine ~/.asaconf
    echo "Done Copying"
    echo "Copying the actual script to your xchat folder"
    cp -v $CURDIR/curplay.pl ~/.xchat2/curplay.pl
    echo "Done"
    echo "Done installing, have a nice day"
    break
else
    if
	$AMAROK = "amarok"
    then
	echo "Your using amarok"
	echo "Copying AmaroK asaconf file..."
	cp -v $CURDIR/asaconf-amarok ~/.asaconf
	echo "Done copying"
	echo "Copying Actual script to your xchat folder"
	cp -v $CURDIR/curplay.pl ~/.xchat2/curplay.pl
	echo "Done"
	echo "Done Installing, have a nice day"
	break
fi
