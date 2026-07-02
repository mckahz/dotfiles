import QtQuick
import QtQuick.Controls
import Quickshell.Io
import qs.Controls
import qs.Services

Text {
    id: root
    text: Icons.weatherFromWMOCode(wmoCode) + temp.toString() + Icons.degrees

    property int temp: 0
    property int wmoCode: -1

    function updateWeather(input) {
        const weather = JSON.parse(input);
        if (weather === undefined) return;
        wmoCode = weather.current.weather_code;
        temp = Math.round(weather.current.temperature_2m);
    }

    property string openMeteoApiUrl:  "https://api.open-meteo.com/v1/forecast?latitude=-37.8025&longitude=144.9887&hourly=temperature_2m&current=weather_code,temperature_2m&timezone=Australia%2FSydney";
    Process {
        id: weatherPoll
        command: ["curl", "-sS", "--fail", "--connect-timeout", "3", "--max-time", "6", "--limit-rate", "150k", "--compressed", openMeteoApiUrl]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.updateWeather(text)
        }
    }

    Timer {
        interval: 60 * 60 * 1000
        running: true
        repeat: true
        onTriggered: weatherPoll.running = true
    }

}
