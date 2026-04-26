import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import qs.Controls
import qs.Services

Pill {
    RowLayout {
        // CPU
        Text {
            text: Icons.cpu + SystemMonitor.cpuUsage
        }

        // Memory
        Text {
            text: Icons.memory + SystemMonitor.memoryUsedPercent
        }

        // Battery
        Text {
            property bool onBattery: UPower.onBattery
            property UPowerDevice device: UPower.displayDevice


            text: ((power, onBattery) => (onBattery ? Icons.batteryOnBattery : Icons.batteryCharging)[Math.floor(power / 10)] + " " + power.toString() + "%")(Math.floor(device.percentage * 100), onBattery)

        }
    }
}
