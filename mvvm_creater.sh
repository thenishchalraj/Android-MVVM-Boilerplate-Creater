#!/bin/bash
# Created by thenishchalraj

#########################################################
# HELP							#
#########################################################
help(){
	echo "Usage options:"
	echo
	echo "-h			shows help options"
	echo "argument1		directory path where files should be created,"
	echo "argument2		base application name,"
	echo "argument3		package name"
	echo
	echo
	echo "Usage example:"
	echo "./mvvm_creater.sh -h"
	echo "---> displays this usage"
	echo
	echo "./mvvm_creater.sh ~/test ToDo com.example.todoapp"
	echo "---> create the files for package 'com.example.todoapp' i.e <argument3> with base application name 'ToDo' i.e. <argument2> in directory '~/test' i.e. <argument1>"
}

#########################################################
# OPTIONS CONDITIONS					#
#########################################################
if [[ "$1" == "-h" ]]
	then
		help
		exit 0
fi

if [[ -z "$1" ]]
	then
		printf "Missing directory path!\nFiles can't be created!\nEXITING..."
		exit 1
fi

if [[ -z "$2" ]]
	then
		printf "Missing base application name!\nRun again with name like:\nWeather,\nToDo,\nGrocery\nEXITING..."
		exit 1
fi

if [[ -z "$3" ]]
	then
		printf "Missing package name!\nRun again!\nEXITING..."

fi


#########################################################
# FILES CREATION					#
#########################################################
echo "Creating MVVM Files in " $1

cd $1

mkdir data
cd data/
mkdir api
cd api/
cat << EOF >> MainApi.kt
package $3.data.api

interface MainApi {}
EOF
cat << EOF >> MainDataSource.kt
package $3.data.api

import android.app.Application

class MainDataSource(
    private val mainApi: MainApi,
    private val application: Application
) {}
EOF
cd -
mkdir model
mkdir repository
cd ../
mkdir di
cd di/
mkdir base
cd -
mkdir utils
cat << EOF >> $2Application.kt
package $3

import $3.di.base.DaggerAppComponent
import dagger.android.AndroidInjector
import dagger.android.support.DaggerApplication

class $2Application: DaggerApplication() {
    override fun applicationInjector(): AndroidInjector<out DaggerApplication> {
        return DaggerAppComponent.factory().create(this)
    }
}
EOF
mkdir ui
cd ui/
mkdir base
mkdir main
cd main/
mkdir view
mkdir viewmodel
cd -
cd -

echo
echo "----------DONE!----------"

printf "\nAdd depedencies for the following in your build.gradle(app) :\n1. Retrofit2\n2. Lifecycle\n3. Dagger2"
