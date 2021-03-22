import Felgo 3.0
import QtQuick 2.0

Item {
    id: winValidator

    //    property alias imageSource: image.source

    // field to memorize lines that won
    property var currentLines

    // property to hold index of currently visible line
    property int visibleIndex

    // define winning lines
    WinningLine {
        id: line1
        visible: false
        image.source: "../../../assets/lines/Line1.png"
        color: "#ff0000"
        positions: [
            {reel: 0, row: 1},
            {reel: 1, row: 1},
            {reel: 2, row: 1},
            {reel: 3, row: 1},
            {reel: 4, row: 1}
        ]
    }

    WinningLine {
        id: line2
        visible: false
        image.source: "../../../assets/lines/Line2.png"
        color: "#00ff00"
        positions: [
            {reel: 0, row: 0},
            {reel: 1, row: 0},
            {reel: 2, row: 0},
            {reel: 3, row: 0},
            {reel: 4, row: 0}
        ]
    }

    WinningLine {
        id: line3
        visible: false
        image.source: "../../../assets/lines/Line3.png"
        color: "#0080ff"
        positions: [
            {reel: 0, row: 2},
            {reel: 1, row: 2},
            {reel: 2, row: 2},
            {reel: 3, row: 2},
            {reel: 4, row: 2}
        ]
    }

    WinningLine {
        id: line4
        visible: false
        image.source: "../../../assets/lines/Line4.png"
        color: "#ffff00"
        positions: [
            {reel: 0, row: 0},
            {reel: 1, row: 1},
            {reel: 2, row: 2},
            {reel: 3, row: 1},
            {reel: 4, row: 0}
        ]
    }

    WinningLine {
        id: line5
        visible: false
        image.source: "../../../assets/lines/Line5.png"
        color: "#ff00ff"
        positions: [
            {reel: 0, row: 2},
            {reel: 1, row: 1},
            {reel: 2, row: 0},
            {reel: 3, row: 1},
            {reel: 4, row: 2}
        ]
    }

    WinningLine {
        id: line6
        image.source: "../../../assets/lines/Line6.png"
        visible: false
        color: "#00ffff"
        positions: [
            {reel: 0, row: 1},
            {reel: 1, row: 2},
            {reel: 2, row: 2},
            {reel: 3, row: 2},
            {reel: 4, row: 1}
        ]
    }

    WinningLine {
        id: line7
        visible: false
        image.source: "../../../assets/lines/Line7.png"
        color: "#ff8000"
        positions: [
            {reel: 0, row: 1},
            {reel: 1, row: 0},
            {reel: 2, row: 0},
            {reel: 3, row: 0},
            {reel: 4, row: 1}
        ]
    }

    WinningLine {
        id: line8
        visible: false
        image.source: "../../../assets/lines/Line8.png"
        color: "#00ff80"
        positions: [
            {reel: 0, row: 2},
            {reel: 1, row: 2},
            {reel: 2, row: 1},
            {reel: 3, row: 0},
            {reel: 4, row: 0}
        ]
    }

    WinningLine {
        id: line9
        visible: false
        image.source: "../../../assets/lines/Line9.png"
        color: "#8000ff"
        positions: [
            {reel: 0, row: 0},
            {reel: 1, row: 0},
            {reel: 2, row: 1},
            {reel: 3, row: 2},
            {reel: 4, row: 2}
        ]
    }

    // reset validator for new game
    function reset() {
        showTimer.stop()
        hideLines()
    }

    // Timer to alternate display of multiple winning lines
    Timer {
        id: showTimer
        interval: 1000
        onTriggered: {
            if(currentLines.length > 0) {
                var index = (visibleIndex + 1) % currentLines.length
                showLine(index)
                showTimer.restart()
            }
        }
    }

    // validate if player won on the slot machine
    function validate(machine) {
        currentLines = []
        var winAmount = 0

        if(line1.validate(machine)) {
            currentLines.push(line1)
            winAmount += line1.winAmount
        }
        if(line2.validate(machine)) {
            currentLines.push(line2)
            winAmount += line2.winAmount
        }
        if(line3.validate(machine)) {
            currentLines.push(line3)
            winAmount += line3.winAmount
        }
        if(line4.validate(machine)) {
            currentLines.push(line4)
            winAmount += line4.winAmount
        }
        if(line5.validate(machine)) {
            currentLines.push(line5)
            winAmount += line5.winAmount
        }
        if(line6.validate(machine)) {
            currentLines.push(line6)
            winAmount += line6.winAmount
        }
        if(line7.validate(machine)) {
            currentLines.push(line7)
            winAmount += line7.winAmount
        }
        if(line8.validate(machine)) {
            currentLines.push(line8)
            winAmount += line8.winAmount
        }
        if(line9.validate(machine)) {
            currentLines.push(line9)
            winAmount += line9.winAmount
        }


        console.debug("Inside winValidator…")
        console.debug("winAmount: " + winAmount)
        console.debug("creditAmount: " + scene.creditAmount)
        console.debug("scene.currentLines: " + currentLines)

        // increase player credit by total win amount
        //        scene.creditAmount += winAmount

        scene.winAmount = winAmount
        scene.creditAmount += scene.winAmount

        console.debug("AFTER: scene.creditAmount: " + scene.creditAmount)

        // return true if player has won on at least 1 line
        return currentLines.length > 0
    }

    // shows lines that won
    function showWinningLines() {
        if(currentLines.length > 0) {
            // show first line and start timer to alternate display of winning lines
            showLine(0)
            showTimer.start()
        }
    }

    // shows a specific line
    function showLine(index) {
        if(index < 0 || index >= currentLines.length)
            return

        hideLines()
        currentLines[index].visible = true
        visibleIndex = index
    }

    // hides all lines
    function hideLines() {
        line1.visible = false
        line2.visible = false
        line3.visible = false
        line4.visible = false
        line5.visible = false
        line6.visible = false
        line7.visible = false
        line8.visible = false
        line9.visible = false
    }

}

//    function validate(machine) {
//        currentLines = []
//        var winAmount = 0

//        // check every row of the slot machine
//        for(var rowIndex = 0; rowIndex < slotMachine.rowCount; rowIndex++) {

//            // for every row -> go over all reels and count length of matching symbols
//            var length = 0
//            var firstSymbol = null
//            for(var reelIndex = 0; reelIndex < slotMachine.reelCount; reelIndex++) {

//                // get model data of currently visible item
//                var modelData = slotMachine.getItemData(reelIndex, rowIndex)

//                // memorize type of first symbol
//                if(firstSymbol == null)
//                    firstSymbol = modelData.type

//                // increase length if current symbol type matches first symbol of the row
//                if(modelData.type === firstSymbol) {
//                    length++
//                }
//                // or stop if a different symbol occurs
//                else {
//                    break
//                }
//            } // end search for matching symbols on the reels

//            // if we found a match -> animate the images of the symbols that won
//            if(length >= 2) {

//                console.log("MATCH FOUND!");

//                for(var winIndex = 0; winIndex < length; winIndex++) {
//                    // get image item of the row
//                    var winImage = slotMachine.getItem(winIndex, rowIndex)
//                    winImage.startWinAnimation()
//                }
//            } // end animate items

//        } // end check every row

//    }
