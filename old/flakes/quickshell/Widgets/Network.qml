import QtQuick
import QtQuick.Controls
import Quickshell.Networking
import Quickshell.Io
import qs.Controls
import qs.Services

Text {
    id: network

    property NetworkDevice device: {
        var device = Networking.devices.values[0];
        if (device == null) { return null; }
        fetchNetworkName.running = true;
        return device;
    }

    Process {
        id: fetchNetworkName
        command: ["nmcli", "device", "show"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: SystemMonitor.updateNetworkName(text)
        }
    }

    text: !device?.connected ? "\udb81\uddaa "
        : device.type == DeviceType.Wifi ? "\udb81\udda9 "
        : "\udb80\ude00 ";

    ToolTip {
        delay: 1000
        timeout: 5000
        visible: hovered
        text: {
            const nameLength = 20;
            var name =
                device === null || !device?.connected === undefined ?
                    "Not Connected"
                : device.type === DeviceType.Wifi ?
                    device?.networks.values[0]?.toString()
                :
                    "";
            return name?.slice(0, nameLength - "...".length) ?? "";
        }
    }
}
