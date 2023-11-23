# Weather App

Weather App is a Flutter application that provides current weather information using the OpenWeatherMap API.

## Features

- View current weather conditions including temperature, weather icon, and description.
- Hourly forecast for the next few hours.
- Additional information such as humidity, wind speed, and pressure.
- Change the city to get weather information for different locations.

## Screenshots

![Screenshot 1](screenshots/screenshot1.png)
![Screenshot 2](screenshots/screenshot2.png)

## Getting Started

To run this app locally:

1.Clone the repository:

			git clone https://github.com/your-username/weather-app.git
    
2.Navigate to the project directory:

	cd weather-app

3.Install dependencies:

	flutter pub get

4.Run the app:

	flutter run

API Key
This app uses the OpenWeatherMap API to fetch weather data. To use the API, obtain an API key:
Sign up on OpenWeatherMap.
Generate an API key.

Add the API key in lib/utils/api.dart:

	const String apiKey = 'YOUR_API_KEY';

Contributing
Contributions are welcome! Please follow the Contribution Guidelines.

License
This project is licensed under the MIT License.


