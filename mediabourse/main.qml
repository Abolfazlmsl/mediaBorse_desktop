import QtQuick 2.12
import QtQuick.Window 2.2
import QtMultimedia 5.9
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.0
import "./Content/font/Icon.js" as MdiFont
import "./Content/codes/Utils"
import "./Content/codes"

ApplicationWindow{
    id: root

    visible: true
    width: 900
    height: 700

    Material.theme: Material.Light
//    flags: Qt.MSWindowsFixedSizeDialogHint

    FontLoader{
        id: font_irans
        source: "qrc:/Content/font/IRANSansMobile(FaNum).ttf"
    }

    FontLoader{
        id: font_material
        source: "qrc:/Content/font/materialdesignicons-webfont.ttf"
    }

    font.pixelSize: Qt.application.font.pixelSize
    font.family: font_irans.name

    //-- Enums --//
    property int _TYPE_TOTURIAL : 0
    property int _TYPE_EXAM     : 1


    PlayerWin{
        id: playerwin
        visible: false

    }


    //-- header --//
    header: ToolBar{

        Material.background : Material.Indigo

        RowLayout{
            anchors.fill: parent
            anchors.margins: 5

            //-- logout/logIn item --//
            ItemDelegate {
                Layout.fillHeight: true
                Layout.preferredWidth: lbl_logout_icon.implicitWidth + lbl_logout_txt.implicitWidth + 20

                RowLayout{
                    anchors.fill: parent
                    anchors.margins: 5

                    Label{
                        id: lbl_logout_icon
                        font.family: font_material.name
                        font.pixelSize: Qt.application.font.pixelSize * 1.5
                        text: MdiFont.login// isLogined ? MdiFont.logout : MdiFont.login
                    }

                    Label{
                        id: lbl_logout_txt
                        text: "ورود"// isLogined ? "خروج" : "ورود"
                    }
                }

                onClicked: {

                    //-- LogOut proccess --//
                    if(isLogined){

                        //-- remove signIn saved setting property --//
                        setting.username = ""
                        setting.password = ""
                        setting.token_access  = ""
                        setting.token_refresh = ""

                        _token_access = ""
                        _token_refresh = ""

                        //-- save user and pass --//
                        _userName = ""
                        _password = ""

                        isLogined = false
                        isAdminPermission = false
                    }
                    //-- LogIn proccess --//
                    else{
                        authWin.visible = true
                    }
                }

            }

            //-- filler --//
            Item { Layout.fillWidth: true }

            SearchField{
                id: totalSearch
                width: 200

                //-- string text --//
                onEnteredText:{
                    console.log("text = " + text)
                }
            }

            //-- login user --//
            ItemDelegate {
                Layout.fillHeight: true
                Layout.preferredWidth: lbl_user_icon.implicitWidth + lbl_user_txt.implicitWidth + 20

                RowLayout{
                    anchors.fill: parent
                    anchors.margins: 5

                    Label{
                        id: lbl_user_icon
                        font.family: font_material.name
                        font.pixelSize: Qt.application.font.pixelSize * 1.5
                        text: MdiFont.account
                        Layout.alignment: Qt.AlignCenter
                    }

                    Label{
                        id: lbl_user_txt
                        text: "کاربر" //_userName
                        font.family: font_irans.name
                        Layout.alignment: Qt.AlignCenter
                    }
                }

            }
        }

    }

    //-- size porpose --//
    Label{
        id: lblSize
        font.pixelSize: Qt.application.font.pixelSize
        text: "test"
        visible: false
    }


    //-- body --//
    RowLayout{
        anchors.fill: parent
        spacing: 0

        //-- video and exams --//
        Rectangle{
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "#00FF0000"

            Rectangle{
                anchors.fill: parent
                anchors.margins: 0

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 1//8
                    verticalOffset: 1//8
                    color: "#80000000"
                    spread: 0.0
                    samples: 17
                    radius: 12
                }

                //-- video player --//
                Player{
                    id: player

                    visible: listmodel.get(lv.currentIndex).type === "TOTURIAL" ? true : false

                    anchors.fill: parent
                    isTopToolsVisible: false
                    isIgnoreOffset: true

                }

                Rectangle{
                    id: exam

                    visible: listmodel.get(lv.currentIndex).type === "EXAM" ? true : false

                    anchors.fill: parent

                    //-- q1 --//
                    Rectangle{
                        visible: listmodel.get(lv.currentIndex).qNum === 1 ? true : false

                        width: parent.width * 0.8
                        height: parent.height * 0.8
                        anchors.centerIn: parent
                        color: "#0900FF00"

                        ColumnLayout{
                            anchors.fill: parent

                            //-- question --//
                            Label{
                                text: "کدام یک از گزینه های زیر مربوط به نمودار کندل استیک می باشد؟"
                                font.pixelSize: Qt.application.font.pixelSize * 2
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Item{Layout.preferredHeight: lblSize.implicitHeight * 2}

                            //-- options 1, 2 --//
                            Item{
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                RowLayout{
                                    anchors.fill: parent

                                    QuestionTile {
                                        id: tile_opt1

                                        Layout.fillHeight: true
                                        Layout.fillWidth: true

                                        source: "qrc:/Content/images/Questions/Sec1Lession1Q1/candle_chart.png"
                                        isCorrectOption: true
                                    }

                                    QuestionTile {
                                        id: tile_opt2

                                        Layout.fillHeight: true
                                        Layout.fillWidth: true

                                        source: "qrc:/Content/images/Questions/Sec1Lession1Q1/fill_chart.png"
                                    }

                                }
                            }

                            //-- options 3, 4 --//
                            Item{
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                RowLayout{
                                    anchors.fill: parent

                                    QuestionTile {
                                        id: tile_opt3

                                        Layout.fillHeight: true
                                        Layout.fillWidth: true

                                        source: "qrc:/Content/images/Questions/Sec1Lession1Q1/line_chart.png"
                                    }

                                    QuestionTile {
                                        id: tile_opt4

                                        Layout.fillHeight: true
                                        Layout.fillWidth: true

                                        source: "qrc:/Content/images/Questions/Sec1Lession1Q1/mileh_chart.png"
                                    }
                                }
                            }
                        }
                    }

                    //-- q2 --//
                    Rectangle{
                        visible: listmodel.get(lv.currentIndex).qNum === 2 ? true : false

                        width: parent.width * 0.8
                        height: parent.height * 0.8
                        anchors.centerIn: parent
                        color: "#0900FF00"

                        ColumnLayout{
                            anchors.fill: parent

                            //-- question --//
                            Label{
                                text: "جواب صحیح را در رو به روی توضیح مورد نظر آن قرار دهید. "
                                font.pixelSize: Qt.application.font.pixelSize * 2
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Item{Layout.preferredHeight: lblSize.implicitHeight*2}

                            //-- options 1, 2 --//
                            RowLayout{
                                Layout.alignment: Qt.AlignHCenter
                                layoutDirection: Qt.RightToLeft
                                spacing: 100

                            ColumnLayout{

                                Rectangle {
                                    anchors.margins: 5
                                    width: 100
                                    height: 64
                                    color: "#00ffff"

                                    Text {
                                        text: qsTr("سود تضمینی")
                                        anchors.fill: parent
                                        color: "#000000"
                                        font.pixelSize: 15
                                        horizontalAlignment:Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                }
                                Rectangle {
                                    anchors.margins: 5
                                    width: 100
                                    height: 64
                                    color: "#00ffff"

                                    Text {
                                        text: qsTr("سود تخمینی")
                                        anchors.fill: parent
                                        color: "#000000"
                                        font.pixelSize: 15
                                        horizontalAlignment:Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                }
                                Rectangle {
                                    anchors.margins: 5
                                    width: 100
                                    height: 64
                                    color: "#00ffff"

                                    Text {
                                        text: qsTr("قیمت به درآمد")
                                        anchors.fill: parent
                                        color: "#000000"
                                        font.pixelSize: 15
                                        horizontalAlignment:Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                }

                            }

                            ColumnLayout{

                                Grid {
                                    id: grid_1
                                    anchors.margins: 5
                                    opacity: 0.5
                                    columns: 1

                                    Repeater {
                                        model: 1;
                                        delegate: DropTile {
                                            colorKey: "red"; answer: "DPS"
                                        }
                                    }
                                }
                                Grid {
                                    id: grid_2
                                    anchors.margins: 5
                                    opacity: 0.5
                                    columns: 1

                                    Repeater {
                                        model: 1;
                                        delegate: DropTile { colorKey: "red"; answer: "EPS"  }
                                    }
                                }
                                Grid {
                                    id: grid_3

                                    anchors.margins: 5
                                    opacity: 0.5
                                    columns: 1

                                    Repeater {
                                        model: 1;
                                        delegate: DropTile { colorKey: "red"; answer: "P/E"  }
                                    }
                                }
                            }

                            ColumnLayout{

                                height: 350
                                Layout.alignment: Qt.AlignRight

                                Column {
                                    id: tile_opt4_2
                                    anchors.margins: 5
                                    width: 64
                                    spacing: -16
                                    DragTile {
                                        modelText: "EPS"
                                        colorKey: "red"

                                        onObjReleased:{

                                        }
                                    }

                                }
                                Column {
                                    id: tile_opt5_2
                                    anchors.margins: 5
                                    width: 64
                                    spacing: -16
                                    DragTile {
                                        modelText: "P/E"
                                        colorKey: "red"
                                    }

                                }
                                Column {
                                    id: tile_opt6_2
                                    anchors.margins: 5
                                    width: 64
                                    spacing: -16
                                    DragTile {
                                        modelText: "DPS"
                                        colorKey: "red"
                                    }

                                }

                            }
                            }

                        }
                    }
                }

            }

        }

        //-- listview of tutorials and exams --//
        Rectangle{
            Layout.fillHeight: true
            Layout.preferredWidth: 200
            color: "#00FF0000"

            Rectangle{
                anchors.fill: parent
                anchors.margins: 7

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 1//8
                    verticalOffset: 1//8
                    color: "#80000000"
                    spread: 0.0
                    samples: 17
                    radius: 12
                }

                ColumnLayout{
                    anchors.fill: parent
                    anchors.margins: 2

                    //-- list view header --//
                    ItemDelegate{
                        Layout.fillWidth: true
                        Layout.preferredHeight: lblSize.implicitHeight * 2

                        font.pixelSize: Qt.application.font.pixelSize

                        //- back color --//
                        Rectangle{anchors.fill: parent; color: "#05000000"; border{width: 1; color: "#22000000"}}

                        //-- materialCategory --//
                        Label{
                            text: "آموزش ها و آزمون ها"
                            anchors.centerIn: parent
                        }
                    }

                    //-- ListView --//
                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        clip: true

                        ListModel{
                            id: listmodel

                            ListElement{
                                section: 1
                                lesson: 1
                                title: "کندل شناسی"
                                type: "TOTURIAL"
                                src: "file:///D:/projects/mediabourse/toturials/videos/mediabourse_candle.mp4"
                            }

                            ListElement{
                                section: 1
                                lesson: 1
                                qNum: 1
                                title: "آزمون 1"
                                type: "EXAM"
                            }

                            ListElement{
                                section: 1
                                lesson: 1
                                qNum: 2
                                title: "آزمون 2"
                                type: "EXAM"
                            }

                            ListElement{
                                section: 1
                                lesson: 1
                                qNum: 3
                                title: "آزمون 3"
                                type: "EXAM"
                            }
                        }

                        ListView{
                            id: lv

                            anchors.fill: parent

                            ScrollBar.vertical: ScrollBar {
                                id: control
                                size: 0.1
                                position: 0.2
                                active: true
                                orientation: Qt.Vertical
                                policy: listmodel.count>(lv.height/40) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff

                                contentItem: Rectangle {
                                    implicitWidth: 6
                                    implicitHeight: 100
                                    radius: width / 2
                                    color: control.pressed ? "#aa32aaba" : "#5532aaba"
                                }

                            }

                            model: listmodel

                            delegate: ItemDelegate{
                                width: parent.width
                                height: 40

                                font.pixelSize: Qt.application.font.pixelSize
                                Material.foreground: "#5e5e5e"

                                //-- odd/even grey backgroung --//
                                Rectangle{anchors.fill: parent; color: index%2 ? "transparent" : "#44e0e0e0"; }

                                //-- selected backgroung --//
//                                Rectangle{visible: isSelected ;anchors.fill: parent; color: "#4400ff00"; }

                                RowLayout{
                                    anchors.fill: parent
                                    anchors.margins: 3

                                    //-- filler --//
                                    Item{Layout.fillWidth: true}

                                    //-- Category --//
                                    Label{
                                        text: model.title
                                    }

                                    //-- number --//
                                    Label{
                                        visible: false
                                        text: " " + model.lesson + " - " + model.section
                                    }

                                    //-- TOTURIAL icon --//
                                    Label{
                                        visible: model.type === "TOTURIAL"
                                        font.family: font_material.name
                                        text: MdiFont.book_open_variant
                                        color: Material.color(Material.DeepPurple)
                                        font.pixelSize: Qt.application.font.pixelSize * 2
                                    }

                                    //-- q icon --//
                                    Label{
                                        visible: model.type === "EXAM"
                                        font.family: font_material.name
                                        text: MdiFont.alpha_q_circle_outline
                                        color: Material.color(Material.Teal)
                                        font.pixelSize: Qt.application.font.pixelSize * 2
                                    }


                                    Item{visible: model.type === "EXAM"; Layout.preferredWidth: lblSize.implicitWidth * 0.5}

                                }

                                //-- spliter --//
                                Rectangle{width: parent.width; height: 1; color: "#e5e5e5"; anchors.bottom: parent.bottom}

                                onClicked: {
                                    lv.currentIndex = index
                                }

                                onDoubleClicked: {
                                }

                            }


                            onCurrentIndexChanged:{
                            }

                            highlight: Rectangle { color: "lightsteelblue"; radius: 2 }
                            focus: true

                            // some fun with transitions :-)
                            add: Transition {
                                // applied when entry is added
                                NumberAnimation {
                                    properties: "x"; from: -lv.width;
                                    duration: 250;
                                }
                            }
                            remove: Transition {
                                // applied when entry is removed
                                NumberAnimation {
                                    properties: "x"; to: lv.width;
                                    duration: 250;
                                }
                            }
                            displaced: Transition {
                                // applied when entry is moved
                                // (e.g because another element was removed)
                                SequentialAnimation {
                                    // wait until remove has finished
                                    PauseAnimation { duration: 250 }
                                    NumberAnimation { properties: "y"; duration: 75
                                    }
                                }
                            }
                        }

                    }

                    //-- filler --//
                    Item{Layout.fillHeight: true}

                }
            }


        }
    }


}

