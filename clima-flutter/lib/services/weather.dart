import 'location.dart';
import 'networking.dart';
import 'package:clima/utilities/constants.dart';

const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather?';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future<Map> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    String url = openWeatherMapUrl;
    url += 'lat=${location.latitude}&lon=${location.longitude}&';
    url += 'appid=$kOpenWeatherAPIKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url);

    Map weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<Map> getWeatherByCityName(String cityName) async {
    String url = openWeatherMapUrl;
    url += 'q=$cityName&appid=$kOpenWeatherAPIKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url);

    Map weatherData = await networkHelper.getData();

    return weatherData;
  }
}
