import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/app_colors.dart';
import 'package:weather_app_tutorial/constants/text_styles.dart';
import 'package:weather_app_tutorial/providers/current_weather_provider.dart';
import 'package:weather_app_tutorial/providers/hourly_weather_provider.dart';
import 'package:weather_app_tutorial/providers/weekly_weather_provider.dart';
import 'package:weather_app_tutorial/views/hourly_forecast_view.dart';
import 'package:weather_app_tutorial/views/humidity_view.dart';
import 'package:weather_app_tutorial/views/weather_view.dart';
import 'package:weather_app_tutorial/views/weekly_forecast_view.dart';
import 'package:weather_app_tutorial/views/weekly_temperature_bar_chart.dart';
import 'package:weather_app_tutorial/views/famous_cities_view.dart';
import 'package:weather_app_tutorial/services/api_helper.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  String _cityName = '';

  void _searchCityWeather() async {
    final cityName = _cityController.text;
    if (cityName.isNotEmpty) {
      try {
        final coordinates = await ApiHelper.getCoordinatesByCityName(cityName);

        final lat = coordinates['lat'];
        final lon = coordinates['lon'];

        if (lat != null && lon != null) {
          await ApiHelper.fetchLocation(lat, lon); // Mettez à jour les coordonnées
          ref.refresh(currentWeatherProvider); // Rafraîchit le provider pour les nouvelles données
          ref.refresh(hourlyWeatherProvider); // Rafraîchit le provider des prévisions horaires
          ref.refresh(weeklyWeatherProvider); // Rafraîchit le provider des prévisions hebdomadaires

          setState(() {
            _cityName = cityName; // Met à jour le nom de la ville
          });
        } else {
          print('Les coordonnées sont nulles pour la ville: $cityName');
        }
      } catch (e) {
        print('Erreur lors de la recherche de la ville: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = ref.watch(currentWeatherProvider);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: weatherData.when(
        data: (weather) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Row pour le titre "Meteo Dashboard", le champ texte et le bouton de recherche
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Meteo Dashboard',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700], // Couleur gris pour le texte
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 600, // Largeur du champ de texte
                            child: TextField(
                              controller: _cityController,
                              decoration: InputDecoration(
                                hintText: 'Enter a City',
                                hintStyle: TextStyle(color: Colors.grey[300]),
                                filled: true, // Remplissage activé pour le fond
                                fillColor: Colors.grey[700], // Couleur de fond (personnalisez selon vos préférences)
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                  // Supprime la bordure
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: _searchCityWeather,
                            child: const Text('Rechercher'),
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.grey[700], // Définir le fond du bouton
                              )
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Contenu principal avec les colonnes des informations météo
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Première colonne avec les infos météo et les villes célèbres (1/3 de la largeur)
                      Expanded(
                        flex: 1, // 1/3 de l'espace total
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            WeatherScreenView(), // Informations principales météo
                            SizedBox(height: 15),
                            FamousCitiesView(), // Villes célèbres
                          ],
                        ),
                      ),
                      SizedBox(width: 20), // Espace entre les deux colonnes

                      // Deuxième colonne avec les prévisions horaires, humidité et autres infos (2/3 de la largeur)
                      Expanded(
                        flex: 2, // 2/3 de l'espace total
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            HourlyForecastView(), // Prévisions horaires
                            SizedBox(height: 20),
                            // Humidity et WeeklyForecast côte à côte avec proportions 1/3 et 2/3
                            Row(
                              children: [
                                Expanded(
                                  flex: 1, // HumidityView prend 1/3 de l'espace
                                  child: HumidityView(),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  flex: 2, // WeeklyForecastView prend 2/3 de l'espace
                                  child: WeeklyForecastView(),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            WeeklyTemperatureBarChart(), // Graphique des températures hebdomadaires
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(error.toString()),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}