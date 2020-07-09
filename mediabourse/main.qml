import QtQuick 2.12
import QtQuick.Window 2.2
import QtMultimedia 5.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import Qt.labs.platform 1.0
import QtQuick.Controls.Styles 1.4
import "./Content/font/Icon.js" as MdiFont


ApplicationWindow{
    id: root
    visible: true
    width: 700
    height: 700

    Material.theme: Material.Dark
    flags: Qt.MSWindowsFixedSizeDialogHint
    /*
    MouseArea {
        width: parent.width
        height: parent.height
        hoverEnabled: true
        onEntered: {
            console.log(1)
            toolsGroup.visible = true
            topGroup.visible = true
        }
        onExited: {
            console.log(2)
            toolsGroup.visible = false
            topGroup.visible = false
        }*/
    Pane {
        id: popup



        Rectangle{
            anchors.fill: parent; color:  "#000000"
        }

        anchors.fill: parent
        anchors.margins: -11

        MediaPlayer {
            id: player

            //source: "file:///C:/Users/Developer 01/Desktop/New folder (2)/player-fix/ttt.mp4" // "file:///C:/Users/DA/Downloads/Video/Venom.mp4"
            notifyInterval: 100

            onPositionChanged: {
                var min = Math.floor(player.position/60000)
                var sec = ((player.position - (min*60000))/1000).toFixed(0)

                var total_min = Math.floor(player.duration/60000)
                var total_sec = ((player.duration - (total_min*60000))/1000).toFixed(0)

                lblTimeSpend.text = (min<10 ? "0"+min : min) + ":" + (sec<10 ? "0"+sec : sec) + " / " + (total_min) + ":" + (total_sec)

                var lackTime = player.duration - player.position
                min = Math.floor(lackTime/60000)
                sec = ((lackTime - (min*60000))/1000).toFixed(0)

                lblTimeLack.text = (min<10 ? "0"+min : min) + ":" + (sec<10 ? "0"+sec : sec)
            }

        }

        VideoOutput {
            id: vidOut

            anchors.fill: parent
            source: player
        }


        //-- tools section --//
        Rectangle{
            id: toolsGroup

            width: parent.width
            height: Math.max(parent.height * 0.15 , 80)
            color: "#7726252a"
            anchors.bottom: parent.bottom

            ColumnLayout{
                anchors.fill: parent
                anchors.margins: 10
                spacing: 1

                Slider {
                    id: sli_timer
                    Layout.fillWidth: true
                    from: 0
                    to: width
                    value: (player.position/player.duration) * width
                    onMoved: {
                        player.seek((player.duration*sli_timer.value)/width)
                    }
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        propagateComposedEvents: true
                        onClicked: mouse.accepted = false
                        onPressed: mouse.accepted = false
                        onReleased: mouse.accepted = false
                        onDoubleClicked: mouse.accepted = false
                        onPositionChanged: mouse.accepted = false
                        onPressAndHold: mouse.accepted = false
                    }

                }

                //-- time text --//
                Item {
                    id: itm_timeTxt
                    Layout.fillWidth: true
                    Layout.preferredHeight: lblTimeSpend.implicitHeight

                    Label{
                        id: lblTimeSpend

                        text: "00:00"
                        font.pixelSize: Qt.application.font.pixelSize * 1
                    }

                    Label{
                        id: lblTimeLack

                        text: "00:00"
                        font.pixelSize: Qt.application.font.pixelSize * 1
                        anchors.right: parent.right
                    }

                }

                //-- tools button --//
                Item {
                    id: itmBtns
                    Layout.fillWidth: true
                    Layout.preferredHeight: btn_playList.implicitHeight

                    Row{
                        id: tools_row
                        anchors.centerIn: parent
                        //                            width: btn_playList.implicitWidth * 10
                        spacing: btn_playList.implicitWidth

                        //-- playlist-play --//
                        Label{
                            id: btn_playList

                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: MdiFont.Icon.playlist_play

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    fileDialog.open()

                                }
                            }

                            FileDialog{
                                id: fileDialog
                                currentFile: fileDialog.file
                                nameFilters: ["Media files (*.mp4 *.mkv)"]
                                folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                                property var vURL: currentFile.toString().split("/")
                                property var lURL: vURL[vURL.length-1]
                                onAccepted: {
                                    player.source = currentFile
                                    player.play()
                                }

                            }

                        }

                        //-- skip backward --//
                        Label{
                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: MdiFont.Icon.skip_backward

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(player.playbackState !== 0){

                                        player.seek(player.position - 10000)
                                    }
                                }
                            }
                        }

                        //-- play --//
                        Label{
                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: player.playbackState === 1 ? MdiFont.Icon.pause: MdiFont.Icon.play

                            MouseArea{
                                id: ma_play
                                anchors.fill: parent
                                onClicked: {

                                    if(player.playbackState === 1){

                                        player.pause()
                                    }
                                    else if(player.playbackState === 0){

                                        player.play()
                                    }
                                    else if(player.playbackState === 2){
                                        player.play()
                                    }

                                }
                            }
                        }

                        //-- skip forward --//
                        Label{
                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: MdiFont.Icon.skip_forward

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if(player.playbackState !== 0){

                                        player.seek(player.position + 10000)
                                    }
                                }
                            }
                        }
                        //-- stop --//
                        Label{
                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: MdiFont.Icon.stop

                            MouseArea{
                                id: ma_stop
                                anchors.fill: parent
                                onClicked: {
                                    player.stop()
                                }
                            }
                        }
                    }


                    Row {
                        id: vol_row

                        layoutDirection: Qt.LeftToRight
                        anchors.right: parent.right
                        Layout.fillWidth: true

                        Label{
                            id: btn_soundLevel

                            //anchors.right: parent.right;
                            anchors.rightMargin: implicitWidth * 2

                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: MdiFont.Icon.volume_medium

                            property bool state: true

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if (btn_soundLevel.state === true){
                                        btn_soundLevel.text = MdiFont.Icon.volume_off
                                        player.volume = 0
                                        btn_soundLevel.state = false
                                    }
                                    else {
                                        if (slider_vol.value > 75) {
                                            btn_soundLevel.text = MdiFont.Icon.volume_high
                                        }
                                        else if (slider_vol.value >= 25 && slider_vol.value <= 75){
                                            btn_soundLevel.text = MdiFont.Icon.volume_medium
                                        }
                                        else if (slider_vol.value === 0){
                                            btn_soundLevel.text = MdiFont.Icon.volume_mute
                                        }
                                        else {
                                            btn_soundLevel.text = MdiFont.Icon.volume_low
                                        }
                                        player.volume = slider_vol.value / 100
                                        btn_soundLevel.state = true
                                    }
                                }

                            }
                        }

                        //-- volume_high --//

                        Slider{
                            id: slider_vol

                            width: 60

                            from: 0
                            value: 50
                            to: 100
                            orientation: Qt.Horizontal
                            onValueChanged: {
                                player.volume = value/100
                                if (slider_vol.value > 75){
                                    btn_soundLevel.text = MdiFont.Icon.volume_high
                                }
                                else if (slider_vol.value >= 25 && slider_vol.value <= 75) {
                                    btn_soundLevel.text = MdiFont.Icon.volume_medium
                                }
                                else if (slider_vol.value === 0){
                                    btn_soundLevel.text = MdiFont.Icon.volume_mute
                                }
                                else if (slider_vol.value > 0 && slider_vol.value < 25){
                                    btn_soundLevel.text = MdiFont.Icon.volume_low
                                }

                            }
                            MouseArea{
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                propagateComposedEvents: true
                                onClicked: mouse.accepted = false
                                onPressed: mouse.accepted = false
                                onReleased: mouse.accepted = false
                                onDoubleClicked: mouse.accepted = false
                                onPositionChanged: mouse.accepted = false
                                onPressAndHold: mouse.accepted = false
                            }

                        }
                    }
                    //-- speed --//
                    Row{
                        anchors.right: vol_row.left
                        anchors.left: tools_row.right
                        spacing: 15

                        Label{
                            width:30

                        }
                        ComboBox{
                            id: list_speed

                            background: Rectangle {
                                color: "#88FFFFFF"
                                implicitWidth: 70
                                implicitHeight: 30
                                radius: 2

                            }
                            currentIndex: 3
                            model: ListModel{
                                ListElement{name:"x4"}
                                ListElement{name:"x3"}
                                ListElement{name:"x2"}
                                ListElement{name:"x1"}
                            }
                            onActivated: {
                                if (list_speed.currentText === "x1")
                                    player.playbackRate =  1
                                else if (list_speed.currentText === "x2")
                                    player.playbackRate =  2
                                else if (list_speed.currentText === "x3")
                                    player.playbackRate =  3
                                else if (list_speed.currentText === "x4")
                                    player.playbackRate =  4
                            }
                        }

                    }
                }
            }

            Item { Layout.fillHeight: true  } //-- spacer --//
            /*
            MouseArea{
                anchors.fill: parent
                visible: true
            }*/
        }

        Rectangle{
            id: topGroup

            width: parent.width
            height: Math.max(parent.height * 0.05 , 40)
            color: "#7726252a"
            anchors.top: parent.top
            ColumnLayout{
                anchors.fill: parent
                anchors.margins: 10
                spacing: 1
                Item {
                    id: topitmBtns
                    Layout.fillWidth: true
                    Layout.preferredHeight: btn_playList.implicitHeight
                    Label{
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 10

                        text:"MediaBourse Player"
                        color: "#88FFFFFF"
                        font.pixelSize: Qt.application.font.pixelSize
                    }

                    Label{
                        anchors.centerIn: parent

                        text:fileDialog.lURL
                        color: "#88FFFFFF"
                        font.pixelSize: Qt.application.font.pixelSize
                    }
                    //-- top tools button --//
                    Row{
                        anchors.right: parent.right
                        spacing: btn_playList.implicitWidth

                        //-- minimize --//
                        Label{
                            id: minimize

                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: MdiFont.Icon.window_minimize
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    root.showMinimized()
                                }
                            }
                        }
                        //-- maximize --//
                        Label{
                            id: maximize

                            property bool state: false
                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: MdiFont.Icon.window_maximize
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    if (maximize.state === false){
                                        root.showFullScreen()
                                        maximize.state = true
                                        maximize.text = MdiFont.Icon.window_restore
                                    }
                                    else {
                                        root.showNormal()
                                        maximize.state = false
                                        maximize.text = MdiFont.Icon.window_maximize
                                    }
                                }
                            }
                        }
                        //-- close --//
                        Label{
                            id: close

                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: MdiFont.Icon.close
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    root.close()
                                }
                            }
                        }
                    }
                }
            }

        }
    }


    Rectangle{
        visible: false
        width: parent.width
        height: 50
        color: "#00FF00"
    }

    MouseArea {
        //            anchors.fill: parent
        width: parent.width
        height: parent.height - toolsGroup.height

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

                //-- seek clip --//
                //                    player.seek((player.duration*mouseX)/width)
            }
            //                mouse.accepted = false
        }
    }

}

