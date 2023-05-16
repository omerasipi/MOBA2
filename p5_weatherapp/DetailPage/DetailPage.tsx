import * as React from 'react';
import {Button, View, StyleSheet, Text, SafeAreaView} from 'react-native';

const styles = StyleSheet.create({
    OuterView: {
        flexDirection: 'column',
        borderWidth: 1,
        borderColor: 'black',
        borderRadius: 10,
        width: 'fit-content',
        flex: 1,
        alignSelf: 'center',
        alignItems: 'center',
        justifyContent: 'center',
        margin: 15,
        padding: 50,
    },
    View: {
        flexDirection: 'row',
    },
    Text: {
        fontSize: 40,
        fontWeight: 'bold',
        color: 'black',
        margin: 15,
        borderWidth: 5,
        borderColor: 'black',
        borderStyle: 'dotted',
        padding: 20,
        borderRadius: 10,
        fontFamily: 'consolas',
    },
});

const getWeather = async (cityName) => {
    const url = `https://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=f17a89919ffa378865b4cb68c1ca05c1`;
    try {
        const response = await fetch(url);
        return await response.json();
    } catch (error) {
        console.error(error);
        return error;
    }
}

const getWeatherIcon = (icon) => {
    var returnIcon = "";
    switch (icon) {
        default:
        case '01d':
        case '01n':
            returnIcon = '☀️';
            break;
        case '02d':
        case '02n':
            returnIcon = '⛅';
            break;
        case '03d':
        case '03n':
            returnIcon = '☁️';
            break;
        case '04d':
        case '04n':
            returnIcon = '🌤️';
            break;
        case '09d':
        case '09n':
            returnIcon = '🌦️';
            break;
        case '10d':
        case '10n':
            returnIcon = '🌧️';
            break;
        case '11d':
        case '11n':
            returnIcon = '⛈️';
            break;
        case '13d':
        case '13n':
            returnIcon = '🌨️';
            break;
        case '50d':
        case '50n':
            returnIcon = '🌫️';
            break;
    }
    return returnIcon;
}

const convertKelvinToCelsius = (kelvin) => Math.round((kelvin - 273.15) * 100) / 100;

export function DetailPage({navigation, route}) {
    const [weatherData, setWeatherData] = React.useState(null);
    React.useEffect(() => {
        (async () => {
            const data = await getWeather(route.params.inputCity);
            setWeatherData(data);
        })();
    }, []);

    if (!weatherData) {
        return (
            <SafeAreaView>
                <View style={styles.OuterView}>
                    <Text style={styles.Text}>Loading...</Text>
                </View>
            </SafeAreaView>
        );
    }
    // return another view as soon as weatherData is not null
    return (
        <SafeAreaView>
            <View style={styles.OuterView}>

                <View style={styles.View}>
                    <Text
                        style={styles.Text}>{weatherData.weather[0].description} in {weatherData.name} {getWeatherIcon(weatherData.weather[0].icon)}</Text>
                </View>

                <View style={styles.View}>
                    <Text style={[styles.Text]}>Currently it's {convertKelvinToCelsius(weatherData.main.temp)}°C</Text>
                    <Text style={[styles.Text]}>Feels
                        like {convertKelvinToCelsius(weatherData.main.feels_like)}°C</Text>
                </View>

                <View style={styles.View}>
                    <Text style={styles.Text}>Low: {convertKelvinToCelsius(weatherData.main.temp_min)}°C</Text>
                    <Text style={styles.Text}>High: {convertKelvinToCelsius(weatherData.main.temp_max)}°C</Text>
                </View>

                <View style={styles.View}>
                    <Text style={styles.Text}>Humidity: {weatherData.main.humidity}%</Text>
                </View>


                <View style={styles.View}>
                    <Text style={styles.Text}>Wind Speed: {weatherData.wind.speed}m/s</Text>
                    <Text style={styles.Text}>Wind direction: {weatherData.wind.deg}°</Text>
                </View>

                <Button title="Back to Search" onPress={() => navigation.navigate('MainPage')}/>
            </View>
        </SafeAreaView>
    );
}
