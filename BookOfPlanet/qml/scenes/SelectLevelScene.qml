import Felgo 3.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: selectLevelScene

    readonly property real level_menu_width: gameScene.width/2.5
//        dp(280)
    readonly property real level_menu_height: level_menu_width/1.5
    readonly property real level_title_height: level_menu_height/5

    readonly property real h1_size: gameWindow.sp(12)
    readonly property real text_size: gameWindow.sp(10)

    // signal indicating that a level has been selected
    signal levelPressed(string selectedLevel)

    BackgroundImage {
        anchors.fill: selectLevelScene.gameWindowAnchorItem
        source: "../../assets/background-level.jpg"
    }

    Row {

        anchors.centerIn: parent
        spacing: dp(10)

        Rectangle {
            color: "transparent"

            width: level_menu_width
            height: level_menu_height

            BackgroundImage {
                anchors.fill: parent
                source: "../../assets/frame_red.png"
            }

            AppText {
                anchors.top: parent.top
                anchors.topMargin: 20
                text: "Normal Game"
                width: parent.width
                height: level_title_height
                font.capitalization: Font.AllUppercase
                maximumLineCount: 1
                font.pixelSize: h1_size
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
            }

            AppText {
                text: "Normal mode (game without additional bonuses)"
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height - level_title_height
                anchors.top: parent.top
                anchors.topMargin: level_title_height
                font.pixelSize: text_size
//                font.wordSpacing: -10
                topPadding: dp(0)
                leftPadding: dp(30)
                rightPadding: dp(30)
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    levelPressed("normal")
                }
            }
        }

        Rectangle {
            color: "transparent"
            width: level_menu_width
            height: level_menu_height

            BackgroundImage {
                anchors.fill: parent
                source: "../../assets/frame_green.png"
            }

            AppText {
                anchors.top: parent.top
                anchors.topMargin: 20
                text: "Eco-friendly Game"
                width: parent.width
                height: level_title_height
                font.capitalization: Font.AllUppercase
                maximumLineCount: 1
                font.pixelSize: h1_size
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
            }

            AppText {
                text: "Eco-friendly mode with increased chances of winning! And each win will donate 0.01% to an eco-fund"
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height - level_title_height
                anchors.top: parent.top
                anchors.topMargin: level_title_height
                leftPadding: dp(30)
                rightPadding: dp(30)
//                font.wordSpacing: -10
                font.pixelSize: text_size
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    levelPressed("eco")
                }
            }

        }
    }

}
