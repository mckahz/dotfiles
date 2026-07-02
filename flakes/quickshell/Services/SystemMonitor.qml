pragma Singleton
import QtQuick
import Quickshell.Io


Item {
    id: root

    property string memoryUsedPercent: ""
    property string memoryUsedRatio: ""
    property list<int> cpuSnapshotA: []
    property list<int> cpuSnapshotB: []
    property string cpuUsage: ""
    property string networkName: "";

    function mb2gb(bytes: string): string {
        var precision = 2;
        var digits = bytes.length;
        return bytes.slice(0, digits - 3) + "." + bytes.slice(digits - 3, digits - 4 + precision) + " GB";
    }

    function updateMemory(input: string) {
        var nums = input.split("\n")[1].split(" ").filter(cell => cell != "");
        var used = nums[2];
        var total = nums[1];
        var percentage = Math.floor(used * 100 / total);
        root.memoryUsedRatio = mb2gb(used) + " / " + mb2gb(total);
        root.memoryUsedPercent = percentage + "%";
    }

    function updateCpu(input: string) {
        input = input.split("\n")[0].slice(3).trim().split(" ").map(num => parseInt(num))
        if (cpuSnapshotA === []) {
            cpuSnapshotA = input;
            cpuUsage = "...";
            return;
        }
        if (cpuSnapshotB != []) {
            cpuSnapshotA = cpuSnapshotB;
        }
        cpuSnapshotB = input;

        var sum = nums => nums[0] + nums[2] + nums[3];
        var aTime = sum(cpuSnapshotA);
        var bTime = sum(cpuSnapshotB);
        var dt = bTime - aTime;
        var idle = cpuSnapshotB[3] - cpuSnapshotA[3];
        var usage = Math.floor(100 * (dt - idle) / dt).toString();
        if (usage === "NaN") {
            cpuUsage = "..."
            return;
        }

        cpuUsage = usage + "%";
    }

    function updateNetworkName(text: string) {
        networkName =
            text
            .split("\n")
            .filter(row => row.startsWith("GENERAL.CONNECTION"))[0]
            .split(":")[1]
            .trim()
    }

    Process {
        id: memoryPoll
        command: ["free", "-m"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.updateMemory(text)
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: memoryPoll.running = true
    }


    Process {
        id: cpuPoll
        command: ["cat", "/proc/stat"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.updateCpu(text)
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: cpuPoll.running = true
    }
}
