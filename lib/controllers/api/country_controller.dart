import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:countries/models/country_model.dart';
import 'package:countries/services/api_client.dart';

class CountryController extends GetxController {
  var countries = <Country>[].obs;
  var filteredCountries = <Country>[].obs;
  var isLoading = false.obs;
  final ApiClient apiClient;

  int currentPage = 1;
  int itemsPerPage = 10;

  Timer? _timer;
  final Duration timeoutDuration = Duration(seconds: 10);

  // Constructor that requires an ApiClient instance
  CountryController(this.apiClient);

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
  }

  Future<void> fetchCountries({String? filter}) async {
    isLoading.value = true; // Start loading

    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer(timeoutDuration, () {
      if (isLoading.value) {
        isLoading.value = false; // Stop loading after timeout
        Get.snackbar(
          'Timeout',
          'The request is taking too long. Please try again.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.black,
        );
      }
    });

    try {
      final fields = 'name,capital,flags,region,languages,population';
      final response = await apiClient.getCountries(fields).timeout(timeoutDuration);

      if (response.isEmpty) {
        Get.snackbar(
          'No Data',
          'No countries found.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.yellow,
          colorText: Colors.black,
        );
      } else {
        countries.assignAll(response);
        filterAndSort(
          filter: filter ?? 'name',
          sort: 'ascending',
          searchTerm: '',
          page: 1,
        );
      }
    } on TimeoutException catch (_) {
      if (isLoading.value) {
        isLoading.value = false; // Stop loading on timeout
        Get.snackbar(
          'Error',
          'Request timed out. Please try again later.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on Exception catch (e) {
      if (isLoading.value) {
        isLoading.value = false; // Stop loading on error
        Get.snackbar(
          'Error',
          'Failed to fetch data: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      _timer?.cancel(); // Cancel the timer if the request completes
      if (isLoading.value) {
        isLoading.value = false; // Ensure loading is stopped
      }
    }
  }

  void filterAndSort({
    String? filter,
    String? sort = 'ascending',
    String? searchTerm,
    int page = 1,
  }) {
    var filtered = List<Country>.from(countries);

    if (searchTerm != null && searchTerm.isNotEmpty) {
      filtered = filtered.where((country) {
        switch (filter) {
          case 'name':
            return country.name.common.toLowerCase().contains(searchTerm.toLowerCase());
          case 'capital':
            return country.capital.any((capital) => capital.toLowerCase().contains(searchTerm.toLowerCase()));
          case 'region':
            return country.region.toLowerCase().contains(searchTerm.toLowerCase());
          case 'languages':
            return country.languages.values.values.any((language) => language.toLowerCase().contains(searchTerm.toLowerCase()));
          case 'population':
            return country.population.toString().contains(searchTerm);
          default:
            return false;
        }
      }).toList();
    }

    filtered.sort((a, b) {
      int comparison;
      switch (filter) {
        case 'name':
          comparison = a.name.common.compareTo(b.name.common);
          break;
        case 'capital':
          comparison = a.capital.join(', ').compareTo(b.capital.join(', '));
          break;
        case 'region':
          comparison = a.region.compareTo(b.region);
          break;
        case 'languages':
          comparison = a.languages.values.values.join(', ').compareTo(b.languages.values.values.join(', '));
          break;
        case 'population':
          comparison = a.population.compareTo(b.population);
          break;
        default:
          comparison = 0;
      }

      return sort == 'ascending' ? comparison : -comparison;
    });

    final startIndex = (page - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    final paginatedFiltered = filtered.sublist(
      startIndex,
      endIndex > filtered.length ? filtered.length : endIndex,
    );

    filteredCountries.assignAll(paginatedFiltered);
  }

  void setItemsPerPage(int count) {
    itemsPerPage = count;
    filterAndSort(page: 1); // Reset to the first page when changing items per page
  }

  void nextPage() {
    if ((currentPage * itemsPerPage) < countries.length) {
      currentPage++;
      filterAndSort(page: currentPage);
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      filterAndSort(page: currentPage);
    }
  }

  Future<void> refreshData() async {
    await fetchCountries(filter: 'name'); // Fetch data again with the default filter
  }
}
