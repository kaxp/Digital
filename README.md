This application is developed on Flutter 3.7.6 in Stable channel.

# Project tree

```bash
|-- lib/
  |-- components
  |   ├── atoms/
  |   ├── molecules/
  |   └── organisms/
  |-- config
  |   ├── themes/
  |   └── flavor_config.dart
  |-- constants/
  |-- generated/
  |-- I10n
  |   └── intl_en.arb
  |-- managers
  |   └── shared_preferences_manager.dart
  |-- modules
  |   ├── app
  |   |   ├── base_app_module.dart
  |   |   └── root_app.dart
  |   ├── detail
  |   |   ├── bloc/
  |   |   ├── pages/
  |   |   ├── widgets/  
  |   |   └── detail_module.dart
  |   ├── home
  |   |   ├── bloc/
  |   |   ├── models/
  |   |   ├── pages/
  |   |   ├── repositories/
  |   |   ├── widgets/
  |   |   └── home_module.dart
  |-- networking
  |   ├── constants/
  |   ├── interceptors/
  |   ├── models/
  |   ├── retrofit/
  |   └── http_client.dart
  |-- utils/
  |-- main_base.dart
  |-- main_mock.dart
  |-- main_staging.dart
  └── main.dart
|-- test/
  |-- mocks/
  |   |-- bloc/
  |   |    |-- mock_blocs.dart
  |   |    └── mock_blocs.mocks.dart
  |   |-- models/
  |   |    └── test_models_builder.dart
  |   |-- repositories/
  |   |    |-- mock_repositories.dart
  |   |    └── mock_repositories.mocks.dart
  |   └── services/
  |   |    |-- mock_services.dart
  |   |    └── mock_services.mocks.dart
  |-- modules
  |   ├── detail
  |   |   ├── bloc/
  |   |   └── pages/
  |   ├── home
  |   |   ├── bloc/
  |   |   └── pages/
  |-- networking
  |   |   └── http_client_test.dart
  |-- test_utils
  |   |   ├── init_test_module_helper.dart
  |   |   └── mock_dio_error.dart
  └── utils
      └── dio_error_extension_test.dart
```

# Project Setup:

- State-management- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- Design pattern - atomic design pattern
- Architecture pattern - MVVM
- Navigation - [flutter_modular](https://pub.dev/packages/flutter_modular)
- Dependency Injection - [flutter_modular](https://pub.dev/packages/flutter_modular)
- Localization - [intl](https://pub.dev/packages/intl)
- Model classes -  [json_serializable](https://pub.dev/packages/json_serializable) and [equatable](https://pub.dev/packages/equatable)
- Unit And Widget testing - flutter_test, [modular_test](https://pub.dev/packages/modular_test)
- Testing Mocks- [mockito](https://pub.dev/packages/mockito)
- Http client - [dio](https://pub.dev/packages/dio) with [retrofit](https://pub.dev/packages/retrofit) as dio client generator
- Build Flavor setup - (staging, prod and mockServer) only for android


### Steps for running the application-

1. Clone the project using command `git clone https://github.com/kaxp/Digital.git`
2. run `flutter pub get`
3. run `flutter pub run build_runner build`
4. run the application on android device
   - `flutter run --release --flavor prod -t lib/main.dart`
5. run the application on iOS device
   - `flutter run` for Simulator
   - `flutter run --release` for physical device

Note: The application is build on Flutter version 3.7.6 in Stable channel. 


### Other Informations
1. The test coverage is not 100%, there are many classes for which tests are not yet written because of time constraint. Will be updating the repo with new tests :)
2. Some Intended behaviours in the app
   - On clearing the search input by pressing clear button, the existing state is preserved with/without results.
   - Searching starts when query length is more than 2.

### Videos

1. <blockquote class="imgur-embed-pub" lang="en" data-id="a/ja43zbT"  ><a href="//imgur.com/a/ja43zbT">Digital iOS </a></blockquote><script async src="//s.imgur.com/min/embed.js" charset="utf-8"></script>
2. <blockquote class="imgur-embed-pub" lang="en" data-id="a/QdiIkCo"  ><a href="//imgur.com/a/QdiIkCo">Digital Android</a></blockquote><script async src="//s.imgur.com/min/embed.js" charset="utf-8"></script>





