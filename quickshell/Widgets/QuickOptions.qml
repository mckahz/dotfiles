import QtQuick.Layouts
import qs.Controls
import qs.Modals

Pill {
    onClicked: optionsPopup.visible = true

    RowLayout {
        Bluetooth {}
        Network {}
        Volume {}
        Power {}
        OptionsPopup {
            id: optionsPopup
        }
    }
}
