#### Hey there!

![Android MVVM Boilerplate Creater Logo](https://github.com/thenishchalraj/Android-MVVM-Boilerplate-Creater/blob/main/assets/logo_thumb.png)
# Android MVVM Boilerplate Creater
A script that creates the files and codes in them for android MVVM architecture in kotlin.

<img src="https://img.shields.io/badge/Version-v1.0.1-green" /> <img src="https://img.shields.io/badge/License-MIT-blue" />

### Features
- [x] Type command > Enter > Done. (it's that fast)
- [x] Each layer in different package.
- [x] Generates basic utility package too.
- [x] Packages with all the basic codes in Kotlin.
- [x] Contains imports for all the files created.
- [x] Uses Retrofit2 and Dagger2.
- [x] Dependencies and suggestions after boilerplate created.

### Steps to run
(tested on linux)

METHOD 1:
* Go to the release space [here](https://github.com/thenishchalraj/Android-MVVM-Boilerplate-Creater/releases)
* Download suitable Asset
* Extract it
* Move into the directory
* Modify the file permission (if applicable)
* Run according to the usage

METHOD 2:
* `git clone https://github.com/thenishchalraj/Android-MVVM-Boilerplate-Creater.git`
* `cd Android-MVVM-Boilerplate-Creater`
* `chmod +x ./mvvm_creater.sh`
* (for demo) `./mvvm_creater.sh ~/testing_dir Weather com.example.weatherapp`

Boom! you're done.

#### Packages and files that are created
```
.
└───├── data/
    │   ├── api/
    │   │   ├── MainApi.kt
    │   │   └── MainDataSource.kt
    │   ├── model/
    │   │   └── SomeModel.kt
    │   └── repository/
    │       └── MainRepository.kt
    ├── di/
    │   ├── base/
    │   │   ├── AppComponent.kt
    │   │   ├── AppModule.kt
    │   │   ├── ViewModelFactoryModule.kt
    │   │   ├── ViewModelKey.kt
    │   │   └── ViewModelModule.kt
    │   ├── ActivityBuildersModule.kt
    │   └── MainModule.kt
    ├── ui/
    │   ├── base/
    │   │   └── ViewModelFactory.kt
    │   └── main/
    │       ├── view
    │       └── viewmodel
    ├── utils/
    │   ├── Endpoints.kt
    │   ├── ISTDateDeserializer.kt
    │   ├── Resource.kt
    │   └── Status.kt
    └── WeatherApplication.kt
```

### Usage
* -h (shows help)
* -s (shows suggestions)
* -d (shows used dependencies)
* arguments 1, 2, 3 (path-to-directory, base application name, application package name)

### ToDos
- [ ] Make the script compact/optimized

### References
* [Bash Cheatsheet](https://devhints.io/bash)
* [Shell Scripting](https://tecadmin.net/tutorial/bash-scripting/)
* [Functions in Bash](https://linuxize.com/post/bash-functions/)
* [Exit in Bash](https://askubuntu.com/questions/892604/what-is-the-meaning-of-exit-0-exit-1-and-exit-2-in-a-bash-script)

### Contribution
Fork the repository, either do your own improvements or pick something from the ToDos or Issues and start a PR to the `dev` branch after successful testing.

### License
Read the license [here](https://github.com/thenishchalraj/Android-MVVM-Boilerplate-Creater/blob/main/LICENSE)
