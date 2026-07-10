import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Modals

ShellRoot {
    Bar {}

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    ActivateLinux {}
}
