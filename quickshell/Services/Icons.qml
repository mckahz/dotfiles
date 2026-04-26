pragma Singleton

import QtQuick

QtObject {
    property string tick: "\uf00c "
    property string bell: "\udb80\udc9a"

    property string memory: "\uefc5 "
    property string cpu: "\udb80\udf5b "

    property list<string> batteryOnBattery: ["\udb84\udccd", "\udb80\udc7a", "\udb80\udc7b", "\udb80\udc7c", "\udb80\udc7d", "\udb80\udc7e", "\udb80\udc7f", "\udb80\udc80", "\udb80\udc81", "\udb80\udc82", "\udb84\ude0f"]
    property list<string> batteryCharging: ["\udb82\udc9f", "\udb82\udc9c", "\udb80\udc86", "\udb80\udc87", "\udb80\udc88", "\udb82\udc9d", "\udb80\udc89", "\udb82\udc9e", "\udb80\udc8a", "\udb80\udc8b", "\udb80\udc85"]

    property string btOff: "\udb80\udcb2 "
    property string btOn: "\udb80\udcaf "

    property string clock: "\uf017 "

    property string previous: "\udb81\udcab "
    property string pause: "\udb80\udfe4 "
    property string play: "\uf04b "
    property string next: "\udb81\udcac "

    property string power: "\u23fb"

    property string search: "\ue68f "
    property string calculator: "\uf1ec "
    property string apps: "\udb80\udc3b"

    property string volumeMax: "\udb81\udd7e "

    property string degrees: "\ue339"
    function weatherFromWMOCode(code: int): string {
        switch (code) {
        case 0:
            return "\uf522 "; // Clear sky
        case 1: // Mainly clear
        case 2: // Partly Cloudy
        case 3:
            return "\ue30c "; // overcast
        case 45: // Fog
        case 48:
            return "\ue313 "; // Depositing Rime Fog
        case 51: // Drizzle: Light
        case 53: // Drizzle: moderate
        case 55: // Drizzle: dense
        case 56: // Freezing Drizzle: Light
        case 57: // Freezing Drizzle: dense
        case 61: // Rain: Slight
        case 63: // Rain: moderate
        case 65: // Rain: heavy
        case 66: // Freezing Rain: Light
        case 67:
            return "\uf522 "; // Freezing Rain: heavy
        case 71: // Snow fall: Slight
        case 73: // Snow fall: moderate
        case 75: // Snow fall: heavy
        case 77:
            return "\ue31a "; // Snow grains
        case 80: // Rain showers: Slight
        case 81: // Rain showers: moderate
        case 82:
            return "\ue318 "; // Rain showers: violent
        case 85: // Snow showers slight
        case 86:
            return "\ue31a "; // Snow showers heavy
        case 95:
            return ""; // Thunderstorm
        case 96:
            return ""; // Thunderstorm with slight hail
        case 99:
            return ""; // Thunderstorm with heavy hail
        default:
            return "";
        }
    }
}
