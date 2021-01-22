#!/bin/bash
# Created by thenishchalraj

#########################################################
# HELP							#
#########################################################
help(){
	echo "Usage options:"
	echo
	echo "-h			show help options"
	echo "-s			show suggestions"
	echo "-d			show dependencies"
	echo "argument1		directory path where files should be created,"
	echo "argument2		base application name,"
	echo "argument3		package name"
	echo
	echo
	echo "Usage example:"
	echo "./mvvm_creater.sh -h"
	echo "---> displays (this) usage"
	echo
	echo "./mvvm_creater.sh ~/test ToDo com.example.todoapp"
	echo "---> create the files for package 'com.example.todoapp' i.e <argument3> with base application name 'ToDo' i.e. <argument2> in directory '~/test' i.e. <argument1>"
}

#########################################################
# SUGGESTIONS						#
#########################################################
suggestions(){
	echo
	echo "Suggestions:"
	echo "1. May use Volley instead of Retrofit."
	echo "2. Create different packages for different features in the main package. (recommended)"
	echo "OR, Create a package as feature in ui, and then different features in it."
}

#########################################################
# DEPENDENCIES						#
#########################################################
dependencies(){
	echo
	echo "Dependencies:"
	echo "1. Retrofit2"
	echo "2. Lifecycle"
	echo "3. Dagger2"
}

#########################################################
# OPTIONS CONDITIONS					#
#########################################################
if [[ "$1" == "-h" ]]
	then
		help
		exit 0
fi

if [[ "$1" == "-s" ]]
	then
		suggestions
		exit 0
fi

if [[ "$1" == "-d" ]]
	then
		dependencies
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
		exit 1
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

import $3.utils.Endpoints
import com.google.gson.JsonObject
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Path

interface MainApi {
	/**
		@GET(Endpoints.SOME_ENDPOINT)
		fun someTest(@Path("someQuery") mSomeQuery: String): Call<JsonObject>
	*/
}
EOF
cat << EOF >> MainDataSource.kt
package $3.data.api

import android.app.Application
import androidx.lifecycle.MediatorLiveData
import $3.R
import $3.data.model.SomeModel
import $3.utils.ISTDateDeserializer
import $3.utils.Resource
import com.google.gson.JsonObject
import org.json.JSONObject
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.util.*
import kotlin.collections.ArrayList

class MainDataSource(
    private val mainApi: MainApi,
    private val application: Application
) {
	/**
		private var mSomeData: MediatorLiveData<Resource<ArrayList<SomeModel>>>? = null
	    	fun getWeather(): MediatorLiveData<Resource<ArrayList<SomeModel>>> {
		mSomeData = MediatorLiveData()
		mSomeData?.value = Resource.loading(null)

		mainApi.someTest(mSomeQuery).enqueue(object :
		    Callback<JsonObject> {
		    override fun onFailure(call: Call<JsonObject>, t: Throwable) {}

		    override fun onResponse(call: Call<JsonObject>, response: Response<JsonObject>) {
		        if (response.isSuccessful && response.body() != null) {
		            val mJSONObject = JSONObject(response.body().toString())

		            try {} catch (e: Exception) {
		                e.printStackTrace()
		            }
		        } else {}
		    }

		})

		return mSomeData!!
	    	}
	*/
}
EOF
cd -
mkdir model
cd model/
cat << EOF >> SomeModel.kt
package $3.data.model

import com.google.gson.annotations.Expose
import com.google.gson.annotations.SerializedName

data class SomeModel(

	/**
	@SerializedName("key1")
	@Expose
	val mKey1:  Int,

	@SerializedName("key2")
	@Expose
	val mKey2: Int,

	*/
    
) {}
EOF
cd ../
mkdir repository
cd repository/
cat << EOF >> MainRepository.kt
package $3.data.repository

import androidx.lifecycle.MediatorLiveData
import $3.data.api.MainDataSource
import $3.data.model.SomeModel
import $3.utils.Resource


class MainRepository(private val dataSource: MainDataSource) {
	/**
	fun someTest(): MediatorLiveData<Resource<ArrayList<SomeModel>>> {
		return dataSource.someTest()
    	}
	*/
}
EOF
cd -
cd ../
mkdir di
cd di/
cat << EOF >> ActivityBuildersModule.kt
package $3.di

import $3.di.base.ViewModelModule
import $3.ui.main.view.WeatherActivity
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class ActivityBuildersModule {}
EOF
cat << EOF >> MainModule.kt
package $3.di

import android.app.Application
import $3.data.api.MainApi
import $3.data.api.MainDataSource
import $3.data.repository.MainRepository
import dagger.Module
import dagger.Provides
import retrofit2.Retrofit

@Module
class MainModule {

    companion object {
        @Provides
        fun provideMainApi(retrofit: Retrofit): MainApi {
            return retrofit.create(MainApi::class.java)
        }

        @Provides
        fun provideMainDataSource(
            mainApi: MainApi, application: Application
        ): MainDataSource {
            return MainDataSource(mainApi, application)
        }

        @Provides
        fun provideMainRepository(
            mDataSource: MainDataSource
        ): MainRepository {
            return MainRepository(mDataSource)
        }
    }
}
EOF
mkdir base
cd base/
cat << EOF >> AppComponent.kt
package $3.di.base

import android.app.Application
import $3.$2Application
import $3.di.ActivityBuildersModule
import dagger.BindsInstance
import dagger.Component
import dagger.android.AndroidInjector
import dagger.android.support.AndroidSupportInjectionModule
import javax.inject.Singleton

@Singleton
@Component(
    modules = [AndroidSupportInjectionModule::class,
        ActivityBuildersModule::class,
        AppModule::class,
        ViewModelFactoryModule::class
    ]
)

interface AppComponent : AndroidInjector<$2Application> {

    @Component.Factory
    interface Factory {
        fun create(@BindsInstance application: Application): AppComponent
    }

}
EOF
cat << EOF >> AppModule.kt
package $3.di.base

import $3.utils.Endpoints.BASE_URL
import dagger.Module
import dagger.Provides
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.converter.scalars.ScalarsConverterFactory
import java.util.concurrent.TimeUnit
import javax.inject.Singleton

@Module
class AppModule {

    companion object {

        @Singleton
        @Provides
        fun provideOkHttpClient(): OkHttpClient {
            return OkHttpClient.Builder()
                .connectTimeout(45, TimeUnit.SECONDS)
                .writeTimeout(45, TimeUnit.SECONDS)
                .readTimeout(45, TimeUnit.SECONDS)
                .build()
        }

        @Provides
        fun provideRetrofitInstance(client: OkHttpClient): Retrofit {
            return Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(ScalarsConverterFactory.create())
                .addConverterFactory(GsonConverterFactory.create())
                .client(client)
                .build()
        }

    }
}
EOF
cat << EOF >> ViewModelFactoryModule.kt
package $3.di.base

import androidx.lifecycle.ViewModelProvider
import $3.ui.base.ViewModelFactory
import dagger.Binds
import dagger.Module

@Module
abstract class ViewModelFactoryModule {

    @Binds
    abstract fun bindViewModelFactory(viewModelProvidersFactory: ViewModelFactory): ViewModelProvider.Factory
}
EOF
cat << EOF >> ViewModelKey.kt
package $3.di.base

import androidx.lifecycle.ViewModel
import dagger.MapKey
import kotlin.reflect.KClass

@Target(AnnotationTarget.FUNCTION,
        AnnotationTarget.PROPERTY_GETTER,
        AnnotationTarget.PROPERTY_SETTER)
@kotlin.annotation.Retention(AnnotationRetention.RUNTIME)
@MapKey
internal annotation class ViewModelKey(val value: KClass<out ViewModel>)
EOF
cat << EOF >> ViewModelModule.kt
package $3.di.base

import androidx.lifecycle.ViewModel
import $3.ui.main.viewmodel.MainViewModel
import dagger.Binds
import dagger.Module
import dagger.multibindings.IntoMap

@Module
abstract class ViewModelModule {

    @Binds
    @IntoMap
    @ViewModelKey(MainViewModel::class)
    abstract fun bindViewModel(viewModel: MainViewModel): ViewModel
}
EOF
cd ../../
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
mkdir utils
cd utils/
cat << EOF >> Endpoints.kt
package $3.utils

object Endpoints {
    const val BASE_URL = "https://www.somesample.url/"

    const val SOME_ENDPOINT = "someendpoint/{someQuery}"

}
EOF
cat << EOF >> ISTDateDeserializer.kt
package $3.utils

import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement
import java.lang.reflect.Type
import java.text.ParseException
import java.text.SimpleDateFormat
import java.util.*

class ISTDateDeserializer : JsonDeserializer<Date> {

    override fun deserialize(
        element: JsonElement?,
        typeOfT: Type?,
        context: JsonDeserializationContext?
    ): Date? {
        val date = element!!.asString

        if (date.matches("^[0-9]*\$".toRegex())) {
            return Date(date.toLong())
        } else {
            val format = when {
                date.contains("Z", ignoreCase = true) -> {
                    SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.ENGLISH)
                }
                date.contains(":") -> {
                    SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.ENGLISH)
                }
                else -> {
                    SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH)
                }
            }

            format.timeZone = TimeZone.getTimeZone("IST")

            return try {
                format.parse(date)!!
            } catch (exp: ParseException) {
                exp.printStackTrace()
                null
            }
        }

    }
}
EOF
cat << EOF >> Resource.kt
package $3.utils

data class Resource<out T>(val status: Status, val data: T?, val message: String?) {

    companion object {

        fun <T> success(data: T?): Resource<T> {
            return Resource(Status.SUCCESS, data, null)
        }

        fun <T> error(msg: String, data: T?): Resource<T> {
            return Resource(Status.ERROR, data, msg)
        }

        fun <T> loading(data: T?): Resource<T> {
            return Resource(Status.LOADING, data, null)
        }

    }

}
EOF
cat << EOF >> Status.kt
package $3.utils

enum class Status {
    SUCCESS,
    ERROR,
    LOADING
}
EOF
cd ../
mkdir ui
cd ui/
mkdir base
cd base/
cat << EOF >> ViewModelFactory.kt
package $3.ui.base

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import javax.inject.Inject
import javax.inject.Provider

class ViewModelFactory @Inject constructor(private val viewModels: MutableMap<Class<out ViewModel>, Provider<ViewModel>>) :
    ViewModelProvider.Factory {

    override fun <T : ViewModel> create(modelClass: Class<T>): T =
        viewModels[modelClass]?.get() as T
}
EOF
cd ../
mkdir main
cd main/
mkdir view
mkdir viewmodel
cd -
cd -

echo
echo "----------DONE!----------"

dependencies

suggestions
