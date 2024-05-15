import 'package:countries_info_app/service/country_search_delegate.dart';
import 'package:countries_info_app/models/country_model.dart';
import 'package:countries_info_app/controller/countries_provider.dart';
import 'package:countries_info_app/view/connectivity/global_connectivity_scaffold.dart';
import 'package:countries_info_app/view/custom_widgets/custom_image.dart';
import 'package:countries_info_app/view/custom_widgets/custom_page_transition.dart';
import 'package:countries_info_app/view/custom_widgets/drawer_screen.dart';
import 'package:countries_info_app/view/home/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlobalConnectivityScaffold(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(27, 38, 44, 1),
        appBar: AppBar(
          title: const Text(
            'Countries',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(27, 38, 44, 1),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                final countriesProvider =
                    Provider.of<CountriesProvider>(context, listen: false);
                showSearch(
                  context: context,
                  delegate: CountrySearchDelegate(countriesProvider.countries!),
                );
              },
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white, // Change background color to white
          elevation: 50,
          shadowColor: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "settings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Expanded(child: DrawerHeaderWidget()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final countriesProvider =
                Provider.of<CountriesProvider>(context, listen: false);
            countriesProvider.fetchCountries();
          },
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          child: const Icon(Icons.refresh),
        ),
        body: Consumer<CountriesProvider>(
          builder: (context, countriesProvider, child) {
            Widget content;
            if (countriesProvider.isLoading) {
              content = Center(
                child: Lottie.asset(
                  "assets/loading lottie.json",
                  width: 100,
                  height: 100,
                ),
              );
            } else if (countriesProvider.errorMessage != null) {
              content = Center(
                child: Text(
                  "error while fetching data\nplease check the connection and refresh",
                  style:
                      theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
                ),
              );
            } else {
              final countries = countriesProvider.countries!;
              final continentsMap = _groupByContinent(countries);

              content = ListView.builder(
                padding: const EdgeInsets.all(10),
                physics: const BouncingScrollPhysics(),
                itemCount: continentsMap.length,
                itemBuilder: (context, index) {
                  final continentName = continentsMap.keys.elementAt(index);
                  final countriesInContinent = continentsMap[continentName]!;
                  return Card(
                    elevation: 4,
                    shadowColor: const Color.fromARGB(255, 255, 255, 255),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ExpansionTile(
                      leading: const Icon(
                        Icons.public,
                        color: Color.fromARGB(255, 0, 0, 0),
                        size: 27,
                      ),
                      title: Text(
                        continentName,
                        style: theme.textTheme.titleLarge!.copyWith(
                            color: const Color.fromARGB(255, 105, 83, 165),
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.expand_more),
                      children: List.generate(
                        countriesInContinent.length,
                        (countryIndex) {
                          final country = countriesInContinent[countryIndex];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(createCustomRoute(
                                targetPage:
                                    CountryDetailsScreen(country: country),
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: CustomImage(
                                          imageUrl: country.flags!.png!),
                                    ),
                                  ),
                                  title: Text(
                                    country.name!.common!,
                                    style:
                                        theme.textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Capital: ${country.capital != null && country.capital!.isNotEmpty ? country.capital!.join(", ") : "NA"} ',
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0),
                                        ),
                                        const SizedBox(height: 2.0),
                                        Text(
                                          'Population: ${country.population}',
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
            return content;
          },
        ),
      ),
    );
  }

  Map<String, List<CountryModel>> _groupByContinent(
      List<CountryModel> countries) {
    final map = <String, List<CountryModel>>{};

    for (var country in countries) {
      final region = country.region;
      if (!map.containsKey(region)) {
        map[region!] = [];
      }
      map[region]!.add(country);
    }

    return map;
  }
}
