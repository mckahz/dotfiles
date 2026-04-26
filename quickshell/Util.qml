pragma Singleton

import QtQuick

QtObject {
    function formatSeconds(seconds: int): string {
        return Math.floor(seconds / 3600).toString() + ":" + (seconds % 60).toString();
    }
}
