import Felgo 3.0
import QtQuick 2.11

Item {
    id: bottomBar

//    readonly property real menu_side_width: parent.width/2.5
        readonly property real menu_side_width: dp(340)

    readonly property real menu_side_height: dp(78)
//    readonly property real menu_play_width: menu_side_height

    readonly property real menu_play_width: dp(90)
//    readonly property real menu_play_height: dp(menu_side_height + 10)
    readonly property real menu_play_height: dp(80)
    readonly property real menu_number_size: gameWindow.sp(10)
    readonly property real menu_text_size: gameWindow.sp(7)
    readonly property real menu_text_top_margin: px(52)
    readonly property real menu_number_top_margin: px(18)

      height: dp(100)
//    height: menu_play_height + dp(30)
    z: 1

//    Rectangle { width: parent.width; height: parent.height; border.width: 1; opacity: .2; color: "pink"}

    // properties to mark buttons as pressed
    property bool autoActive
    property bool startActive

    // define signals
    signal autoClicked()
    signal startClicked()
    signal decreaseBetClicked()
    signal increaseBetClicked()
    signal maxBetClicked()

    Row {
        anchors.bottom: bottomBar.bottom
        anchors.horizontalCenter: bottomBar.horizontalCenter
        anchors.bottomMargin: 8
        //    height: 23
        anchors.centerIn: parent
        //    bottomPadding: dp(20)
        // This is the space between each item in the row
        spacing: dp(10)

        Item{
            height: menu_side_height
            width: menu_side_width

            BackgroundImage {
                source: "../../../assets/menu-side.png"
                anchors.fill: parent
            }

            AppText {
                text: scene.levelName
                width: px(30)
                height: px(30)
                anchors.topMargin: menu_number_top_margin
                anchors.leftMargin: px(85)
                anchors.top: parent.top
                anchors.left: parent.left
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.DemiBold
                font.pixelSize: menu_number_size
            }
            AppText {
                text: "Mode"
                width: px(30)
                anchors.topMargin: menu_text_top_margin
                anchors.leftMargin: px(85)
                anchors.top: parent.top
                anchors.left: parent.left
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.DemiBold
                font.pixelSize: menu_text_size
                font.capitalization: Font.AllUppercase
                //              width: 35
                //        font.bold: true
                //        lineHeight: 2
                //        anchors.left: parent.width / 2
                //        anchors.verticalCenter: parent.verticalCenter + 50
                //      text: scene.betAmount
                //      color: "white"
                //      font.pixelSize: 16
            }


            AppText {
                text: "-"
                width: px(30)
                height: px(30)
                anchors.topMargin: menu_number_top_margin
                anchors.rightMargin: px(120)
                anchors.top: parent.top
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.DemiBold
                font.pixelSize: menu_number_size
                MouseArea {
                    anchors.fill: parent
                    onClicked: decreaseBetClicked()
                }
            }
            AppText {
                text: scene.betAmount
                width: px(30)
                height: px(30)
                anchors.topMargin: menu_number_top_margin
                anchors.rightMargin: px(85)
                anchors.top: parent.top
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.DemiBold
                font.pixelSize: menu_number_size
            }
            AppText {
                text: "+"
                width: px(30)
                height: px(30)
                anchors.topMargin: menu_number_top_margin
                anchors.rightMargin: px(50)
                anchors.top: parent.top
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.DemiBold
                font.pixelSize: menu_number_size
                MouseArea {
                    anchors.fill: parent
                    onClicked: increaseBetClicked()
                }
            }

            AppText {
                text: "Bet"
                width: px(30)
                anchors.topMargin: menu_text_top_margin
                anchors.rightMargin: px(85)
                anchors.top: parent.top
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.DemiBold
                font.pixelSize: menu_text_size
                font.capitalization: Font.AllUppercase
            }
        }

        Image {
            id: menu_play
            height: menu_play_height
            width: menu_play_width
            enabled: !bottomBar.startActive
            source: bottomBar.startActive ? "../../../assets/menu-play-disabled.png" : "../../../assets/menu-play.png"
//            anchors.fill: parent
            MouseArea {
                anchors.fill: parent
                onClicked: startClicked()
            }
        }

        //  // add start button
        //  Image {
        //    width: 61
        //    height: 31
        //    anchors.bottom: bottomBar.bottom
        //    anchors.right: bottomBar.right
        //    anchors.bottomMargin: 4
        //    anchors.rightMargin: 8
        //    source: bottomBar.startActive ? "../../assets/ButtonStartActive.png" : "../../assets/ButtonStart.png"
        //    enabled: !bottomBar.startActive

        //    MouseArea {
        //      anchors.fill: parent
        //      onClicked: startClicked()
        //    }
        //  }

        //            // button at the bottom allows to toggle the text
        //            AppButton {
        //             anchors.horizontalCenter: parent.horizontalCenter
        //             anchors.bottom: parent.bottom
        //             text: "Toggle Text Item"
        //             onClicked: textItem.opacity = textItem.visible ? 0 : 1 // toggle textItem visibility
        //            }

        //            // centered text which fades when opacity changes
        //            AppText {
        //              id: textItem
        //              anchors.centerIn: parent
        //              text: "Hello World!"
        //              visible: opacity != 0 // also set invisible when fully transparent

        //              // when opacity changes ...
        //              Behavior on opacity {
        //                NumberAnimation { duration: 500 } // ... animate to reach new value within 500ms
        //              }
        //            }



    Item{
        height: menu_side_height
        width: menu_side_width

        BackgroundImage {
            source: "../../../assets/menu-side.png"
            anchors.fill: parent
        }

        AppText {
            text: scene.winAmount
            width: px(30)
            height: px(30)
            anchors.topMargin: menu_number_top_margin
            anchors.leftMargin: px(85)
            anchors.top: parent.top
            anchors.left: parent.left
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.DemiBold
            font.pixelSize: menu_number_size
        }
        AppText {
            text: "Last Win"
            width: px(30)
            anchors.topMargin: menu_text_top_margin
            anchors.leftMargin: px(85)
            anchors.top: parent.top
            anchors.left: parent.left
            horizontalAlignment: Text.AlignHCenter
            //                maximumLineCount: 1
            wrapMode: "NoWrap"
            font.weight: Font.DemiBold
            font.pixelSize: menu_text_size
            font.capitalization: Font.AllUppercase
        }

        AppText {
            text: scene.creditAmount
            width: px(30)
            height: px(30)
            anchors.topMargin: menu_number_top_margin
            anchors.rightMargin: px(85)
            anchors.top: parent.top
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.DemiBold
            font.pixelSize: menu_number_size
        }

        AppText {
            text: "Balance"
            width: px(30)
            anchors.topMargin: menu_text_top_margin
            anchors.rightMargin: px(85)
            anchors.top: parent.top
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.DemiBold
            font.pixelSize: menu_text_size
            font.capitalization: Font.AllUppercase
        }

    }
}

}


//  // add auto button
//  Image {
//    width: 61
//    height: 31
//    anchors.bottom: bottomBar.bottom
//    anchors.left: bottomBar.left
//    anchors.bottomMargin: 4
//    anchors.leftMargin: 8
//    source: bottomBar.autoActive ? "../../assets/ButtonAutoActive.png" : "../../assets/ButtonAuto.png"

//    MouseArea {
//      anchors.fill: parent
//      onClicked: autoClicked()
//    }
//  }

//  // add start button
//  Image {
//    width: 61
//    height: 31
//    anchors.bottom: bottomBar.bottom
//    anchors.right: bottomBar.right
//    anchors.bottomMargin: 4
//    anchors.rightMargin: 8
//    source: bottomBar.startActive ? "../../assets/ButtonStartActive.png" : "../../assets/ButtonStart.png"
//    enabled: !bottomBar.startActive

//    MouseArea {
//      anchors.fill: parent
//      onClicked: startClicked()
//    }
//  }

//  // place bet controls in a row
//  Row {
//    anchors.bottom: bottomBar.bottom
//    anchors.horizontalCenter: bottomBar.horizontalCenter
//    anchors.bottomMargin: 8
//    height: 23

//    // bet text
//    Image {
//      width: 35
//      height: 19
//      anchors.verticalCenter: parent.verticalCenter
//      source: "../../assets/TextBet.png"
//    }

//    // bet amount
//    Text {
//      width: 35
//      horizontalAlignment: Text.AlignHCenter
//      anchors.verticalCenter: parent.verticalCenter
//      text: scene.betAmount
//      color: "white"
//      font.pixelSize: 16
//    }

//    // decrease bet button
//    Image {
//      width: 27
//      height: 23
//      anchors.verticalCenter: parent.verticalCenter
//      source: "../../assets/ButtonMinus.png"

//      MouseArea {
//        anchors.fill: parent
//        onClicked: decreaseBetClicked()
//      }
//    }

//    // increase bet button
//    Image {
//      width: 30
//      height: 23
//      anchors.verticalCenter: parent.verticalCenter
//      source: "../../assets/ButtonPlus.png"

//      MouseArea {
//        anchors.fill: parent
//        onClicked: increaseBetClicked()
//      }
//    }

//    // maximum bet button
//    Image {
//      width: 50
//      height: 23
//      anchors.verticalCenter: parent.verticalCenter
//      source: "../../assets/ButtonMax.png"

//      MouseArea {
//        anchors.fill: parent
//        onClicked: maxBetClicked()
//      }
//    }
//  }




//    Rectangle {
//        id: menu_play
//        //      color: "transparent"
//        color: "red"
//        anchors.centerIn: parent

//        width: menu_play_width
//        height: menu_play_height

//        BackgroundImage {
//            source: "../../../assets/menu-play.png"
//            anchors.fill: parent
//        }
//    }

//    Rectangle {
//        id: menu_left
//        //      color: "transparent"
//        color: "white"
//        width: menu_side_width
//        height: menu_side_height

//        anchors.right: menu_play.left
//        anchors.topMargin: 500

//        BackgroundImage {
//            source: "../../../assets/menu-side.png"
//            anchors.fill: parent
//        }
//    }

//    Rectangle {
//        id: menu_right
//        //      color: "transparent"
//        color: "white"

//        anchors.left: menu_play.right
//        width: menu_side_width
//        height: menu_side_height

//        BackgroundImage {
//            source: "../../../assets/menu-side.png"
//            anchors.fill: parent
//        }
//    }

//}
