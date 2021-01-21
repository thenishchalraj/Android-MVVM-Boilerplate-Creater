#!/bin/bash
# Created by thenishchalraj

if [ -z "$1" ]
	then
		echo "Missing directory path!\nFiles can't be created!\nEXITING..."
		exit 1
fi

if [ -z "$2" ]
	then
		printf "Missing base application name!\nRun again with name like:\nWeather,\nToDo,\nGrocery\nEXITING..."
		exit 1
fi

if [ -z "$3" ]
	then
		printf "Missing package name!\nRun again!\nEXITING..."

fi

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

echo "----------DONE!----------"

printf "\nAdd depedencies for the following in your build.gradle(app) :\n1. Retrofit2\n2. Lifecycle\n3. Dagger2"
