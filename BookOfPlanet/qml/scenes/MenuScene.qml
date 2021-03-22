import Felgo 3.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: menuScene

    // signal indicating that the selectLevelScene should be displayed
    signal selectLevelPressed

    BackgroundImage {
      anchors.fill: menuScene.gameWindowAnchorItem
      source: "../../assets/background-splash.jpg"
    }

    MenuButton {
        color: "#e9e9e9"
        y: dp(360)
        text: "Loading…"
//        font.pixelSize: 30
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: selectLevelPressed()
    }

}
