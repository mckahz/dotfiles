import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.Controls

Pill {
    RowLayout {
        Repeater {
            model: Math.max(...Hyprland.workspaces.values.map(workspace => workspace.id))

            Text {
                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                text: index + 1
                color: isActive ? "#0db9d7" : Style.fontColor

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                }
            }
        }
    }
}
