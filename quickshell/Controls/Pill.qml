import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    signal clicked

    property real radius: 10
    contentItem: children[0]
    padding: 5
    function calculateImplicitHeight() {
        return contentItem.implicitHeight + padding * 2;
    }
    implicitWidth: {
        Math.max(contentItem.implicitWidth + padding * 2, calculateImplicitHeight());
    }
    implicitHeight: {
        calculateImplicitHeight()
    }

    background: Rectangle {
        antialiasing: true
        anchors.fill: parent
        radius: parent.radius
        color: "#BB333333"
    }
}
