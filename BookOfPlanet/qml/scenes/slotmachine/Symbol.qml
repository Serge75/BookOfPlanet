import Felgo 3.0
import QtQuick 2.0

Item {
  // we want to set the image for each symbol
    property alias imageSource: image.source

  Rectangle {
      anchors.fill: image
//      width: 120
//      height: 120
      color: "black"
  //      border.color: "black"
      border.width: 0
      radius: 5
      antialiasing: true
      opacity: 0.4
      anchors.leftMargin: 5
      anchors.rightMargin: 5
  }

  // add image with some margin add the top/bottom
  Image {
    id: image
    anchors.fill: parent
    anchors.topMargin: 5
    anchors.bottomMargin: 5
//    anchors.leftMargin: 5
//    anchors.rightMargin: 5
  }

//  // configure animation to enlarge the item and shrink it again
//  SequentialAnimation {
//    id: winAnimation

//    NumberAnimation {
//      target: image
//      property: "z"
//      duration: 500
//      to: 100
//    }

//    // make image bigger
//    NumberAnimation {
//      target: image
//      property: "scale"
////      duration: 250
////      to: 1.0
//      duration: 500
//      to: 2.5
//    }
//    // shrink it again
//    NumberAnimation {
//      target: image
//      property: "scale"
//      duration: 500
////      to: 0.8
//      to: 1
//    }
//  }

//  // add a function that starts the animation
//  function startWinAnimation() {
//    winAnimation.start()
//  }


}
