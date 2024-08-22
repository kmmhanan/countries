import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:countries/models/country_model.dart';
import 'package:countries/services/api_client.dart';

class CountryController extends GetxController {
  // Observable lists for countries and filtered countries
  var countries = <Country>[].obs;
  var filteredCountries = <Country>[].obs;

  // Observable variables for loading state, filters, sorting, pagination
  var isLoading = false.obs;
  var selectedFilter = 'name'.obs;
  var selectedSort = 'ascending'.obs;
  var itemsPerPage = 10.obs;
  var currentPage = 1.obs;

  // Controller for search input
  TextEditingController searchController = TextEditingController();

  final ApiClient apiClient;

  Timer? _timer;
  final Duration timeoutDuration = const Duration(seconds: 10);

  // Constructor that requires an ApiClient instance
  CountryController(this.apiClient);

  @override
  void onInit() {
    super.onInit();
    fetchCountries(); // Fetch countries on initialization
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.onClose();
  }

  // Fetches countries from the API and handles loading state, errors, and timeouts
  Future<void> fetchCountries({String? filter}) async {
    isLoading.value = true; // Set loading state to true

    // Cancel any previous timer
    _timer?.cancel();
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
      const fields = 'name,capital,flags,region,languages,population';
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
          filter: filter ?? selectedFilter.value,
          sort: selectedSort.value,
          searchTerm: searchController.text,
          page: currentPage.value,
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

  // Filters, sorts, and paginates the list of countries
  void filterAndSort({
    required String filter,
    String? sort,
    String? searchTerm,
    int? page,
  }) {
    var filtered = List<Country>.from(countries);

    // Apply search term filtering
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

    // Apply sorting
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

      return (sort == 'ascending') ? comparison : -comparison;
    });

    // Apply pagination
    final startIndex = (page ?? currentPage.value - 1) * itemsPerPage.value;
    final endIndex = startIndex + itemsPerPage.value;
    final paginatedFiltered = filtered.sublist(
      startIndex,
      endIndex > filtered.length ? filtered.length : endIndex,
    );

    filteredCountries.assignAll(paginatedFiltered);
  }

  // Updates the number of items per page and resets pagination
  void setItemsPerPage(int count) {
    itemsPerPage.value = count;
    filterAndSort(
      filter: selectedFilter.value,
      sort: selectedSort.value,
      searchTerm: searchController.text,
      page: 1,
    ); // Reset to the first page when changing items per page
  }

  // Moves to the next page if possible
  void nextPage() {
    if ((currentPage.value * itemsPerPage.value) < countries.length) {
      currentPage.value++;
      filterAndSort(
        filter: selectedFilter.value,
        sort: selectedSort.value,
        searchTerm: searchController.text,
        page: currentPage.value,
      );
    }
  }

  // Moves to the previous page if possible
  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      filterAndSort(
        filter: selectedFilter.value,
        sort: selectedSort.value,
        searchTerm: searchController.text,
        page: currentPage.value,
      );
    }
  }

  // Refreshes the country data by fetching it again
  Future<void> refreshData() async {
    await fetchCountries(filter: selectedFilter.value); // Fetch data again with the current filter
  }

  // Handles changes in the number of items per page
  void onItemsPerPageChanged(String? newValue) {
    if (newValue != null) {
      itemsPerPage.value = int.parse(newValue);

      // Reset to the first page and re-apply filters and sorting
      currentPage.value = 1;
      filterAndSort(
        filter: selectedFilter.value,
        sort: selectedSort.value,
        searchTerm: searchController.text,
        page: currentPage.value,
      );
    }
  }

  // Handles changes in the selected filter
  void onFilterChanged(String? newFilter) {
    if (newFilter != null) {
      selectedFilter.value = newFilter;
      fetchCountries(filter: newFilter);
    }
  }

  // Handles changes in the selected sort order
  void onSortChanged(String? newSort) {
    if (newSort != null) {
      selectedSort.value = newSort;
      filterAndSort(
        filter: selectedFilter.value,
        sort: newSort,
        searchTerm: searchController.text,
        page: currentPage.value,
      );
    }
  }

  // Callback for search text changes
  void _onSearchChanged() {
    filterAndSort(
      filter: selectedFilter.value,
      sort: selectedSort.value,
      searchTerm: searchController.text,
      page: currentPage.value,
    );
  }

  void applyFiltersAndSorting(TextEditingController controller) {
    filterAndSort(
      filter: selectedFilter.value,
      sort: selectedSort.value,
      searchTerm: controller.text,
      page: currentPage.value,
    );
  }
}
