#!/bin/sh
echo "\n[Building Jekyll site...]\n"
bundle exec jekyll build

echo "\n[Updating master...]\n"
cd master
git pull
cp -rf ../_site/* .

echo "\n[Committing and pushing...]\n"
git add .
git commit -m "Publishing website `date`"
git push

echo "\nDone!!\n"
