import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.Widgets

Scope {
    id: root
    property real vpadding : 0
    property real hpadding : 5

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: root.vpadding * 2 + 40

            ColumnLayout {
                anchors.fill: parent
                Item {
                    Layout.topMargin: root.vpadding
                    Layout.bottomMargin: root.vpadding
                    Layout.fillWidth: true
                    // Left
                    RowLayout {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left

                        Item { implicitWidth : hpadding }
                        Workspaces {}
                        Media {}
                    }

                    // Center
                    RowLayout {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        Search {}
                        Outside {}
                        Notifications {}
                    }

                    // Right
                    RowLayout {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        SystemInfo {}
                        QuickOptions {}
                        Item { width : hpadding }
                    }
                }
            }
        }
    }
}
