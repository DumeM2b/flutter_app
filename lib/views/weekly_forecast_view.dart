import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/app_colors.dart';
import 'package:weather_app_tutorial/constants/text_styles.dart';
import 'package:weather_app_tutorial/extensions/datetime.dart';
import 'package:weather_app_tutorial/providers/weekly_weather_provider.dart';
import 'package:weather_app_tutorial/utils/get_weather_icons.dart';
import 'package:weather_app_tutorial/widgets/subscript_text.dart';

class WeeklyForecastView extends ConsumerWidget {
  const WeeklyForecastView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final WeeklyForecastData = ref.watch(weeklyWeatherProvider);

    return WeeklyForecastData.when(
      data: (weeklyWeather) {
        return Card( // Utilisation d'un widget Card
          elevation: 10, // Ajout d'une élévation de 10
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Arrondi de la carte
          ),
          child: Container(
            height: 200, // Hauteur fixe pour la carte
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Expanded(
                  child: ListView.builder(
                    itemCount: weeklyWeather.daily.weatherCode.length,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(), // Activer le défilement
                    itemBuilder: (context, index) {
                      final dayOfWeek =
                          DateTime.parse(weeklyWeather.daily.time[index]).dayOfWeek;
                      final date = weeklyWeather.daily.time[index];
                      final temp = weeklyWeather.daily.temperature2mMax[index];
                      final icon = weeklyWeather.daily.weatherCode[index];

                      return WeeklyWeatherTile(
                        date: date,
                        day: dayOfWeek,
                        temp: temp.toInt(),
                        icon: getWeatherIcon2(icon),
                      );
                    },
                  ),
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
    );
  }
}

class WeeklyWeatherTile extends StatelessWidget {
  const WeeklyWeatherTile({
    super.key,
    required this.day,
    required this.date,
    required this.temp,
    required this.icon,
  });

  final String day;
  final String date;
  final int temp;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10, // Réduire un peu pour s'adapter à la carte
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8, // Réduire l'espacement entre les items
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[600],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(day, style: TextStyles.h3),
              const SizedBox(height: 5),
              Text(
                date,
                style: TextStyles.subtitleText,
              )
            ],
          ),
          SuperscriptText(
            text: temp.toString(),
            superScript: "°C",
            color: AppColors.white,
            superscriptColor: AppColors.grey,
          ),
          Image.asset(icon, width: 40), // Réduire la taille de l'icône
        ],
      ),
    );
  }
}
