import 'package:flutter/material.dart';
import 'package:weather_app/components/additional_information_card.dart';
import 'package:weather_app/components/main_card.dart';
import '../components/forcast_card.dart';
import '../utils/api.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>>? weatherData;
  @override
  void initState() {
    super.initState();
    weatherData = getCurrantWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    weatherData = getCurrantWeather();
                  });
                },
                icon: const Icon(
                  Icons.refresh,
                ))
          ],
          title: const Text('Weather App',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              )),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getCurrantWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: Text("No Data"));
            }
            final data = snapshot.data!;
            final currentTemperature = data["list"][0]["main"]["temp"];
            final currentWeather = data["list"][0]["weather"][0]["main"];
            final currentPressure = data["list"][0]["main"]["pressure"];
            final currentHumidity = data["list"][0]["main"]["humidity"];
            final currentWindSpeed = data["list"][0]["wind"]["speed"];
            final hourlyForecast = data["list"].sublist(1, 6);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: MainCard(
                        temperature: "$currentTemperature°K",
                        icon: currentWeather == "Clouds"
                            ? Icons.cloud
                            : currentWeather == "Rain"
                                ? Icons.cloud
                                : currentWeather == "Clear"
                                    ? Icons.wb_sunny
                                    : Icons.cloud,
                        weather: "$currentWeather"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //Weather forecast Cards
                  const Text("Hourly Forecast",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ForecastCard(
                              time: hourlyForecast[index]["dt_txt"]
                                  .toString()
                                  .substring(11, 16),
                              icon: hourlyForecast[index]["weather"][0]["main"] ==
                                      "Clouds"
                                  ? Icons.cloud
                                  : hourlyForecast[index]["weather"][0]["main"] ==
                                          "Rain"
                                      ? Icons.cloud
                                      : hourlyForecast[index]["weather"][0]
                                                  ["main"] ==
                                              "Clear"
                                          ? Icons.wb_sunny
                                          : Icons.cloud,
                              temperature:
                                  "${hourlyForecast[index]["main"]["temp"]}°K");
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //Weather forecast Cards
                  const Text("Additional Information",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInformationCard(
                          icon: Icons.water_drop,
                          condition: "Humidity",
                          value: "$currentHumidity"),
                      AdditionalInformationCard(
                          icon: Icons.air,
                          condition: "Wind Speed",
                          value: "$currentWindSpeed"),
                      AdditionalInformationCard(
                          icon: Icons.beach_access,
                          condition: "Pressure",
                          value: "$currentPressure"),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
