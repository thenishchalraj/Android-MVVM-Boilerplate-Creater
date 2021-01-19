#!/bin/bash
# Created by thenishchalraj

echo "Creating MVVM Files in" $1

cd $1

mkdir data
cd data/
mkdir api
mkdir model
mkdir repository
cd -

mkdir di
cd di/
mkdir base
cd -

mkdir ui
cd ui/
mkdir base
mkdir main
cd main/
mkdir view
mkdir viewmodel
cd -
cd -

mkdir utils

echo "Done!"
