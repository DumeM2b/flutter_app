# Flutter Weather Dashboard
Contributeurs : Nicolas Manzanares, Olivia Blattemann, Thomas Peze, Andrea Macheda

Un tableau de bord météo élégant et interactif, construit avec Flutter et utilisant l'API OpenWeather pour fournir des données météorologiques en temps réel.

## Fonctionnalités

- **Recherche de ville :** Permet à l'utilisateur de rechercher une ville pour afficher les données météorologiques correspondantes.
- **Météo actuelle :** Affichage des conditions actuelles, telles que la température, l'humidité et plus encore.
- **Prévisions horaires :** Visualisez les prévisions météorologiques heure par heure pour la journée.
- **Prévisions hebdomadaires :** Affichage graphique des tendances de la température pour les 7 prochains jours.
- **Villes célèbres :** Accédez rapidement aux données météorologiques des grandes villes.
- **Heures de lever et coucher du soleil :** Information sur les horaires du lever et du coucher du soleil.

## Captures d’écran

![image](https://github.com/user-attachments/assets/96c4ad38-3192-41e2-9a0f-26246ffe7c14)


## Prérequis

- [Flutter](https://flutter.dev/docs/get-started/install) 3.0 ou version ultérieure
- Une clé API valide de [OpenWeather](https://openweathermap.org/)

## Installation

1. Clonez ce dépôt :
   ```bash
   git clone https://github.com/votre-utilisateur/flutter-weather-dashboard.git
   ```

2. Accédez au répertoire du projet :
   ```bash
   cd flutter-weather-dashboard
   ```

3. Installez les dépendances :
   ```bash
   flutter pub get
   ```

4. Ajoutez votre clé API OpenWeather dans le fichier `api_helper.dart` :
   ```dart
   const String apiKey = 'VOTRE_CLE_API';
   ```

5. Lancez l’application :
   ```bash
   flutter run
   ```

## Structure du Projet

- **`views/` :** Contient les widgets principaux pour les différentes sections du tableau de bord.
  - `weather_view.dart` : Vue des informations météo actuelles.
  - `hourly_forecast_view.dart` : Vue des prévisions horaires.
  - `weekly_forecast_view.dart` : Vue des prévisions hebdomadaires.
  - `famous_cities_view.dart` : Vue des grandes villes.
- **`providers/` :** Contient les providers Riverpod pour gérer l'état des données météo.
- **`services/` :** Inclut les services pour les appels API.
  - `api_helper.dart` : Classe utilitaire pour interagir avec l'API OpenWeather.
- **`constants/` :** Stocke les couleurs, styles de texte et autres constantes de l’application.

## Utilisation

1. Lancez l’application.
2. Saisissez le nom d'une ville dans la barre de recherche et cliquez sur "Rechercher".
3. Explorez les différentes sections : météo actuelle, prévisions horaires, tendances hebdomadaires, etc.

## Packages Utilisés

- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) : Gestion d’état réactive.
- [http](https://pub.dev/packages/http) : Requêtes HTTP.
- [charts_flutter](https://pub.dev/packages/charts_flutter) : Graphiques pour les prévisions hebdomadaires.

## Contributions

Les contributions sont les bienvenues ! Veuillez suivre les étapes suivantes :

1. Fork ce dépôt.
2. Créez une branche pour votre fonctionnalité :
   ```bash
   git checkout -b feature/ma-fonctionnalite
   ```
3. Commitez vos modifications :
   ```bash
   git commit -m "Ajout de ma fonctionnalité"
   ```
4. Poussez la branche :
   ```bash
   git push origin feature/ma-fonctionnalite
   ```
5. Créez une Pull Request.


