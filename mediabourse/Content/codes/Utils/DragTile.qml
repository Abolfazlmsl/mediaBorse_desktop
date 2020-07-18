import QtQuick 2.0

//! [0]
Item {
    id: root
    property string colorKey
    property string modelText
    property string objname

    width: 64; height: 64
    MouseArea {
        id: mouseArea

        width: 64; height: 64
        anchors.fill: parent

        drag.target: tile
        onReleased: {
            parent = tile.Drag.target !== null ? tile.Drag.target : root
            tile.Drag.drop()
        }

        Rectangle {
            id: tile
            objectName: objname
            width: 100; height: 64
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            color: colorKey

            Drag.active: mouseArea.drag.active
            Drag.hotSpot.x: 50
            Drag.hotSpot.y: 50
            Text {
                anchors.fill: parent
                color: "#000000"
                font.pixelSize: 15
                text: modelText
                horizontalAlignment:Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            states: State {
                when: mouseArea.drag.active
                ParentChange { target: tile; parent: root }
                AnchorChanges { target: tile; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
            }


        }
    }
}

