#!/bin/sh
echo "\n[Building Jekyll site...]\n"
bundle exec jekyll build

SITE=`pwd`

echo "\n[Updating master...]\n"
cd /tmp/
rm -rf gabr1e11.github.io
git clone git@github.com:gabr1e11/gabr1e11.github.io.git
cd gabr1e11.github.io
git checkout master
git pull
cp -rf $SITE/_site/* .

echo "\n[Committing and pushing...]\n"
git add .
git commit -m "Publishing website `date`"
git push

echo "\nDone!!\n"
