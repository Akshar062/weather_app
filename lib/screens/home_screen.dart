import 'package:flutter/material.dart';
import 'package:weather_app/components/additional_information_card.dart';
import 'package:weather_app/components/main_card.dart';
import '../components/forcast_card.dart';
import '../utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>>? weatherData;
  TextEditingController cityController = TextEditingController();
  String city = "Surat";
  @override
  void initState() {
    super.initState();
    _loadLastCity();
    weatherData = getCurrantWeather(city);
  }

  _loadLastCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      city = prefs.getString('lastCity') ?? 'Surat';
    });
  }

  _saveLastCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastCity', city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    weatherData = getCurrantWeather(city);
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
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: getCurrantWeather(city),
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
                padding: const EdgeInsets.only(left: 15, right: 15, top: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: cityController,
                            decoration: InputDecoration(
                              hintText: city,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              city = cityController.text;
                              _saveLastCity(city);
                              weatherData = getCurrantWeather(city);
                            });
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 9,
                    ),
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
                      height: 10,
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
                      height: 135,
                      child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ForecastCard(
                                time: hourlyForecast[index]["dt_txt"]
                                    .toString()
                                    .substring(11, 16),
                                icon: hourlyForecast[index]["weather"][0]
                                            ["main"] ==
                                        "Clouds"
                                    ? Icons.cloud
                                    : hourlyForecast[index]["weather"][0]
                                                ["main"] ==
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
                      height: 15,
                    ),
                    //Weather forecast Cards
                    const Text("Additional Information",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        )),
                    const SizedBox(height: 10),
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
          ),
        ));
  }
}
