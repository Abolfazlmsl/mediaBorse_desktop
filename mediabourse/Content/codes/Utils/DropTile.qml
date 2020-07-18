import QtQuick 2.0

DropArea {
    id: dragTarget

    property string colorKey
    property string answer
    property string user
    property bool check
    property bool contain: false
    property var answer_check: q2.answer_check
    property var right_check: q2.right_check
    property bool answer_complete: q2.answer_complete
    property var question_number: q2.qustion_number

    signal objdropped()

    width: 100; height: 64

    onDropped: {
        contain = true
        user = drag.source.objectName
        if (answer === user){
            check = true
            q2.right_check += 1
            if (q2.right_check === q2.question_number){
                q2.answer_complete = true
            }
        }else{
            check = false
            q2.answer_check += 1
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
