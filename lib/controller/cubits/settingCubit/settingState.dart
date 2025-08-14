// // setting_state.dart
//
// class SettingsState {
//   final String selectedCountry;
//   final String selectedLanguage;
//   final List<Map<String, String>> countries;
//
//   SettingsState({
//     required this.selectedCountry,
//     required this.selectedLanguage,
//     required this.countries,
//   });
// }



import '../../../model/cities.dart';

abstract class Settingstate {}

class SettingInitial extends Settingstate{}

class SettingLoading extends Settingstate{}

class SettingSuccess extends Settingstate {
  final List<Cities> cities;
  final Cities? selectedCity;
  SettingSuccess({required this.cities, this.selectedCity});
}

class SettingFailure extends Settingstate{
  String error;
  SettingFailure({required this.error});
}

class SelectedCityChanged extends Settingstate{
  final Cities selectedCity;
  SelectedCityChanged({required this.selectedCity});
}



class SettingLogoutLoading extends Settingstate {}

class SettingLogoutSuccess extends Settingstate {}

class SettingLogoutFailure extends Settingstate {
  final String error;
  SettingLogoutFailure({required this.error});
}
