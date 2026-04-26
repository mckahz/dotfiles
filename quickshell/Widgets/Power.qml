import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.Controls
import qs.Services

Text {
    text: Icons.power

    PopupWindow {
        id: powerMenu
        anchor {
            item: parent
            edges: Edges.Top | Edges.Right
        }

        RowLayout {
            Button {
                text: "logout"
            }
            Button {
                text: "restart"
            }
            Button {
                text: "shutdown"
            }
        }
    }
}
