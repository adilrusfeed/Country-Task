import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:countries_info_app/service/countries_controller.dart';
import 'package:countries_info_app/models/country_model.dart';
import 'package:flutter/foundation.dart';

class CountriesProvider with ChangeNotifier {
  final CountriesController _controller = CountriesController();
  List<CountryModel>? _countries;
  bool _isLoading = true;
  String? _errorMessage;

  CountriesProvider() {
    fetchCountries();
  }

  List<CountryModel>? get countries => _countries;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCountries() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception("No internet connection");
      }

      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _countries = await _controller.fetchCountries();
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      _errorMessage = 'Error fetching countries: ${error.toString()}';
      log(_errorMessage.toString());
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
