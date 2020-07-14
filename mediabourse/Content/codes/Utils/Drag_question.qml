import QtQuick 2.12
import QtQuick.Window 2.2
import QtMultimedia 5.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0
import "./../../font/Icon.js" as MdiFont
import "./../"

Rectangle{
    id: tile_opt1

    property bool isAnswer: false        //-- is user chosed? --//
    property bool isCorrectOption: false //-- correct option --//
    property alias source: img_opt.source

    width: 100
    height: 100
    color: "#00FF0000"
    border.width: 1
    border.color: "#99000000"
    radius: 5

    //-- image --//
    Item{
        anchors.fill: parent
        anchors.margins: 5
        clip: true

        //-- options --//
        Image {
            id: img_opt

            anchors.centerIn: parent
            source: "qrc:/Content/images/Questions/Sec1Lession1Q1/candle_chart.png"
            width: parent.width
            fillMode: Image.PreserveAspectFit
        }

        //-- correct --//
        Image {
            visible: isCorrectOption && isAnswer ? true : false
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            source: "qrc:/Content/images/tools/check.png"
            width: parent.width * 0.15
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        //-- wrong --//
        Image {
            visible: !isCorrectOption && isAnswer ? true : false
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            source: "qrc:/Content/images/tools/wrong.png"
            width: parent.width * 0.15
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

    }

    ItemDelegate{
        anchors.fill: parent
        onClicked: {
            tile_opt1.isAnswer = true
        }
    }
}
