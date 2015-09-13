#!/bin/sh
echo "\n[Building Jekyll site...]\n"
bundle exec jekyll build

SITE=`pwd`

echo "\n[Updating master...]\n"
cd /tmp/
rm -rf robcgabriell
git clone git@github.com:gabr1e11/robcgabriell.git
cd robcgabriell
git checkout master
git pull
cp -rf $SITE/_site/* .

echo "\n[Committing and pushing...]\n"
git add .
git commit -m "Publishing website `date`"
git push

echo "\nDone!!\n"
