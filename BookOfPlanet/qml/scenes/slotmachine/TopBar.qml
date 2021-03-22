import Felgo 3.0
import QtQuick 2.0

Item {
  id: topBar
  height: 20


//  Rectangle { width: parent.width; height: parent.height; border.width: 1; opacity: .2; color: "red"}

  // add logo
  Image {
      source: "../../../assets/logo-small.png"
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top: parent.anchors.TopAnchor
//      scale: .4
      height: parent.height
      width: parent.width/2.5
  }

}
