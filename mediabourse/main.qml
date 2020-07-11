import QtQuick 2.12
import QtQuick.Window 2.2
import QtMultimedia 5.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import Qt.labs.platform 1.0
import "./Content/font/Icon.js" as MdiFont
import "./Content/codes"

ApplicationWindow{
    id: root
    visible: true
    width: 700
    height: 700

    Material.theme: Material.Dark
    flags: Qt.MSWindowsFixedSizeDialogHint

    Player{
        id: player

        anchors.fill: parent
    }

    MouseArea {
        width: parent.width
        height: parent.height - player.toolsHeight

        propagateComposedEvents: true
        property real lastMouseX: 0
        property real lastMouseY: 0
        acceptedButtons: Qt.LeftButton
        onMouseXChanged: root.x += (mouseX - lastMouseX)
        onMouseYChanged: root.y += (mouseY - lastMouseY)
        onPressed: {
            if(mouse.button == Qt.LeftButton){
                parent.forceActiveFocus()
                lastMouseX = mouseX
                lastMouseY = mouseY
            }
        }
    }

}

