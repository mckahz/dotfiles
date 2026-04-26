import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import qs.Controls
import qs.Services

Text {
    id: root
    text: Icons.volumeMax

    property int volume: Math.floor(Pipewire.defaultAudioSink?.audio.volume * 100).toString()

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
}
