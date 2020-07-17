import QtQuick 2.0

DropArea {
    id: dragTarget

    property string colorKey
    property string answer
    property string user
    property bool check
    property bool contain: false

    signal objdropped()

    width: 100; height: 64

    onDropped: {
        contain = true
        user = drag.source.objectName
        if (answer === user){
            check = true
        }else{
            check = false
        }
        objdropped()
    }

    onExited: {
        if (drag.source.objectName === user){
            contain = false
        }
    }

    Rectangle {
        id: dropRectangle

        anchors.fill: parent
        color: colorKey
    }

}
