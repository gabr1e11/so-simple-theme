#!/bin/sh
echo "\n[Building Jekyll site...]\n"
bundle exec jekyll build

SITE=`pwd`

echo "\n[Updating master...]\n"
cd /tmp/
if [ ! -e robercano.github.io ]; then
    git clone git@github.com:robercano/robercano.github.io.git
fi

cd robercano.github.io
git checkout master
git pull
cp -rf $SITE/_site/* .

echo "\n[Committing and pushing...]\n"
git add .
git commit -m "Publishing website `date`"
git push

echo "\nDone!!\n"
