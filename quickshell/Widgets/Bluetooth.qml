import QtQuick
import QtQuick.Controls
import qs.Controls
import qs.Services

Text {
    id: root
    property bool connected: false
    text: !root.connected ? Icons.btOff : Icons.btOn

    ToolTip {
        delay: 1000
        timeout: 5000
        visible: hovered
        text: !root.connected ? "Not Connected" : "Teeth";
    }
}
