import QtQuick 2.12
import QtQuick.Window 2.2
import QtMultimedia 5.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import Qt.labs.platform 1.0
import "./../font/Icon.js" as MdiFont

Item {

    property alias toolsHeight: toolsGroup.height

    //-- top section visibile --//
    //    property alias isTopToolsVisible: topGroup.visible
    property bool isTopToolsVisible: false

    //-- maximize/ minimize parent win --//
    property var parentWin

    //-- margin offset --//
    property bool isIgnoreOffset: false

    function play_pause() {
        console.log("player.playbackState: " + player.playbackState + MediaPlayer.PlayingState + MediaPlayer.PlayingState)
        if(player.playbackState === MediaPlayer.PlayingState){

            console.log("pause")
            player.pause()
        }
        else if(player.playbackState === MediaPlayer.PausedState
                || player.playbackState === MediaPlayer.StoppedState){
            console.log("play")
            player.play()

        }
    }

    function right_play() {
        if(player.playbackState !== 0){

            player.seek(player.position + 5000)
        }
    }

    function left_play() {
        if(player.playbackState !== 0){

            player.seek(player.position - 5000)
        }
    }

    function max_min() {

        if (maximize.state === false){
            root.showFullScreen()
            maximize.state = true
            maximize.text = MdiFont.window_restore
            toolsGroup.visible = false
            topGroup.visible = false
        }
        else {
            root.showNormal()
            maximize.state = false
            maximize.text = MdiFont.window_maximize
            toolsGroup.visible = true
            topGroup.visible = true
        }
    }


    Pane {
        id: popup

        Rectangle{
            anchors.fill: parent; color:  "#000000"
        }

        anchors.fill: parent
        anchors.margins: isIgnoreOffset ? 0 : -11

        Material.theme: Material.Dark

        Image{
            id: image
            visible: player.playbackState === MediaPlayer.PlayingState ? false : true
            anchors.centerIn: parent
            source: 'qrc:/Content/images/mediabourse.png'
            verticalAlignment: Image.AlignVCenter
            horizontalAlignment: Image.AlignHCenter
        }

        MediaPlayer {
            id: player
            //notifyInterval: 100
            source: "file:///D:/projects/mediabourse/toturials/videos/mediabourse_candle.mp4"
            //            autoPlay: true

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
                if (player.position === player.duration){
                    topGroup.visible = true
                    toolsGroup.visible = true
                }
            }

        }

        VideoOutput {
            id: vidOut

            anchors.fill: parent
            source: player
        }


        MouseArea{
            anchors.fill: parent
            anchors.topMargin: topGroup.height
            anchors.bottomMargin: toolsGroup.height
            hoverEnabled: true
            onEntered: {
                if (maximize.state === true){
                    toolsGroup.visible = false
                    topGroup.visible = false
                }

            }
            onExited: {
                if (maximize.state === true){
                    toolsGroup.visible = true
                    topGroup.visible = true
                }

            }

        }

        //-- tools section --//
        Rectangle{
            id: toolsGroup

            width: parent.width
            height: Math.max(parent.height * 0.1 , 60)
            color: "#7726252a"
            anchors.bottom: parent.bottom

            ColumnLayout{
                anchors.fill: parent
                anchors.margins: 10
                spacing: -10

                Slider {
                    id: sli_timer
                    Layout.fillWidth: true
                    Layout.topMargin: -20
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
                        onPressed: mouse.accepted = false
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
                        spacing: btn_playList.implicitWidth

                        //-- playlist-play --//

                        Label{
                            width:20

                        }
                        //-- speed --//
                        Label{
                            id: btn_speedLevel
                            width: 50

                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: MdiFont.speedometer

                            Popup{
                                id: popupspeed
                                width: list_speed.implicitWidth * 1
                                height: btn_speedLevel.implicitHeight * 5
                                y: -height
                                x: -width*0.5 + btn_speedLevel.implicitWidth*0.5

                                focus: true
                                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

                                property bool state: false

                                Slider{
                                    id: list_speed

                                    height: parent.height
                                    anchors.centerIn: parent

                                    from: 1
                                    value: 1
                                    onValueChanged: {
                                        player.playbackRate = value
                                    }

                                    to: 4
                                    orientation: Qt.Vertical
                                }

                            }
                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true

                                onClicked: {
                                    if (popupspeed.state === false){
                                        popupspeed.open()
                                        popupspeed.state = true
                                    }
                                    else {
                                        popupspeed.close()
                                        popupspeed.state = false
                                    }
                                }
                            }

                        }

                        Label{
                            width:20

                        }
                        Label{
                            id: btn_playList

                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: MdiFont.playlist_play

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
                                    image.visible = false
                                    if (maximize.state === true){
                                        toolsGroup.visible = false
                                        topGroup.visible = false
                                    }

                                }

                            }

                        }

                        //-- skip backward --//
                        Label{
                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: MdiFont.skip_backward

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    left_play()
                                }
                            }
                        }

                        //-- play --//
                        Label{
                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: player.playbackState === 1 ? MdiFont.pause: MdiFont.play

                            MouseArea{
                                id: ma_play
                                anchors.fill: parent
                                onClicked: {
                                    console.log("play")
                                    play_pause()
                                }
                            }
                        }

                        //-- skip forward --//
                        Label{
                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: MdiFont.skip_forward

                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    right_play()
                                }
                            }
                        }
                        //-- stop --//
                        Label{
                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 2
                            text: MdiFont.stop

                            MouseArea{
                                id: ma_stop
                                anchors.fill: parent
                                onClicked: {
                                    player.stop()
                                    image.visible = true
                                    toolsGroup.visible = true
                                    topGroup.visible = true
                                }
                            }
                        }


                        Label{
                            width:20

                        }
                        Row {
                            id: vol_row
                            Layout.fillWidth: true

                            Label{
                                id: btn_soundLevel

                                //anchors.right: parent.right;
                                anchors.rightMargin: implicitWidth * 2
                                font.family: "Material Design Icons"
                                font.pixelSize: Qt.application.font.pixelSize * 2
                                text: MdiFont.volume_medium

                                property bool state: true

                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        if (btn_soundLevel.state === true){
                                            btn_soundLevel.text = MdiFont.volume_off
                                            player.volume = 0
                                            btn_soundLevel.state = false
                                        }
                                        else {
                                            if (slider_vol.value > 75) {
                                                btn_soundLevel.text = MdiFont.volume_high
                                            }
                                            else if (slider_vol.value >= 25 && slider_vol.value <= 75){
                                                btn_soundLevel.text = MdiFont.volume_medium
                                            }
                                            else if (slider_vol.value === 0){
                                                btn_soundLevel.text = MdiFont.volume_mute
                                            }
                                            else {
                                                btn_soundLevel.text = MdiFont.volume_low
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
                                height: btn_soundLevel.height
                                from: 0
                                value: 50
                                to: 100
                                orientation: Qt.Horizontal
                                onValueChanged: {
                                    player.volume = value/100
                                    if (slider_vol.value > 75){
                                        btn_soundLevel.text = MdiFont.volume_high
                                    }
                                    else if (slider_vol.value >= 25 && slider_vol.value <= 75) {
                                        btn_soundLevel.text = MdiFont.volume_medium
                                    }
                                    else if (slider_vol.value === 0){
                                        btn_soundLevel.text = MdiFont.volume_mute
                                    }
                                    else if (slider_vol.value > 0 && slider_vol.value < 25){
                                        btn_soundLevel.text = MdiFont.volume_low
                                    }

                                }

                                MouseArea{
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    propagateComposedEvents: true
                                    onPressed: mouse.accepted = false

                                }

                            }
                        }

                    }

                }
            }

            Item { Layout.fillHeight: true  } //-- spacer --//

        }

        Rectangle{
            id: topGroup
            visible: true

            width: parent.width
            height: Math.max(parent.height * 0.04 , 35)
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
                    Image{
                        id: top_image
                        anchors.left: parent.left
                        source: "qrc:/Content/images/mediabourse_100px.png"
                        sourceSize: Qt.size(15,15)
                    }

                    Label{
                        anchors.left: top_image.right
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

                        //-- maximize --//
                        Label{
                            id: maximize

                            property bool state: false
                            font.family: "Material Design Icons"
                            font.pixelSize: Qt.application.font.pixelSize * 1.4
                            text: MdiFont.window_maximize
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    max_min()
                                }
                            }
                        }
                    }
                }
            }

        }

        Shortcut{
            sequence: "Space"
            onActivated:{
                play_pause()
            }
        }
        Shortcut{
            sequence: "Right"
            onActivated:{
                right_play()
            }
        }
        Shortcut{
            sequence: "Left"
            onActivated:{
                left_play()
            }
        }
        Shortcut{
            sequence: "Up"
            onActivated:{
                slider_vol.value = (slider_vol.value + 5)
                player.volume = slider_vol.value / 100
            }
        }
        Shortcut{
            sequence: "Down"
            onActivated:{
                slider_vol.value = (slider_vol.value - 5)
                player.volume = slider_vol.value / 100
            }
        }

        Shortcut{
            sequence: "Enter"
            onActivated:{
                max_min()
            }
        }

        Shortcut{
            sequence: "Return"
            onActivated:{
                max_min()
            }
        }
    }
}
