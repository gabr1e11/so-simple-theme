#!/bin/sh
bundle exec jekyll build
cd master
git pull
cp -rf ../_site/* .
git add .
git commit -m "Publishing website `date`"
git push
