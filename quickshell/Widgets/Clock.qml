import Quickshell
import QtQuick
import QtQuick.Controls
import qs.Controls
import qs.Services

Text {
    text: {
        Icons.clock + Qt.formatDateTime(clock.date, "HH:mm");
        // + "\n" + Qt.formatDateTime(clock.date, "ddd d MMM");
    }
}
