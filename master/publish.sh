#!/bin/sh
echo "\n[Building Jekyll site...]\n"
bundle exec jekyll build

echo "\n[Updating master...]\n"
if [ ! -e master ]; then
    git clone git@github.com:gabr1e11/gabr1e11.github.io.git master
    cd master
    git checkout master
    cd ../
fi
cd master
git pull
cp -rf ../_site/* .

echo "\n[Committing and pushing...]\n"
git add .
git commit -m "Publishing website `date`"
git push

echo "\nDone!!\n"
