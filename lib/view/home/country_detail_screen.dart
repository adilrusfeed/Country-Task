import 'package:countries_info_app/view/connectivity/global_connectivity_scaffold.dart';
import 'package:countries_info_app/view/custom_widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:countries_info_app/models/country_model.dart';

class CountryDetailsScreen extends StatelessWidget {
  final CountryModel country;

  const CountryDetailsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final flagUrl = country.flags?.png ?? '';

    return GlobalConnectivityScaffold(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(27, 38, 44, 1),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Country Details",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(27, 38, 44, 1),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              flagUrl.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color.fromARGB(255, 255, 255, 255),
                          width: 2,
                        ),
                      ),
                      child: CustomImage(
                          imageUrl: country.flags!.png!,
                          imgWidth: double.infinity,
                          imgHeight: 200.0,
                          imgPlaceholderWidth: double.infinity,
                          imgPlaceholderHeight: 200.0,
                          imgFit: BoxFit.fill),
                    )
                  : Container(height: 200),
              const SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //----------country name--------------------//
                          Text(
                            country.name!.common!,
                            style: theme.textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                          const Divider(),
                          //----------country capital--------------------//

                          Text(
                            'Capital: ${country.capital != null && country.capital!.isNotEmpty ? country.capital!.join(", ") : "NA"}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          const Divider(),
                          //----------country population--------------------//
                          Text(
                            'Population: ${country.population?.toString() ?? "NA"}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          const Divider(),
                          //----------country region--------------------//
                          Text(
                            'Region: ${country.region ?? "NA"}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          const Divider(),
                          //----------country sub-region--------------------//
                          Text(
                            'Sub-Region: ${country.subregion ?? "NA"}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          const Divider(),
                          //----------country area--------------------//
                          Text(
                            'Area: ${country.area?.toString() ?? "NA"} sq. km.',
                            style: theme.textTheme.bodyLarge,
                          ),
                          const Divider(),
                          //----------country borders--------------------//
                          Text(
                            'Borders: ${country.borders != null && country.borders!.isNotEmpty ? country.borders!.join(", ") : "NA"}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          const Divider(),
                          //----------country timezones--------------------//
                          Text(
                            'Timezones: ${country.timezones?.join(", ") ?? "NA"}',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),

                  //----------country cost of arms--------------------//
                  const SizedBox(height: 10),
                  if (country.coatOfArms != null &&
                      country.coatOfArms!.png != null) ...[
                    const SizedBox(height: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Coat of Arms',
                                style: theme.textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CustomImage(
                                    imageUrl: country.coatOfArms!.png!,
                                    imgWidth: 200.0,
                                    imgHeight: 200.0,
                                    imgPlaceholderWidth: 200.0,
                                    imgPlaceholderHeight: 200.0,
                                    imgFit: BoxFit.contain),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
