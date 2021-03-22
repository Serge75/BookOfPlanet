import Felgo 3.0
import QtQuick 2.0
import "config"

Item {
    id: winningLine

    // line fills up the area of its parent, the container for all lines has to match the slot machine height
    anchors.fill: parent

    // we want to set a different line image from the outside for each line
    property alias image: lineImage

    // the color of the winning line is used to draw symbols on the line in the correct color
    property string color

    // a line is represented as an array of slot positions
    property var positions: [] // each position has to be an object { reel: <reelNr>, row: <rowNr> }

    // property to hold amount of win
    property int winAmount

    // field that will hold positions that won after validation
    property var __winningPositions: []

    // field to hold symbol type of positions that won
    property var __winningTypes: []

    // field to hold dynamically created line symbols that form a line
    property var __lineSymbols: []

    property string wildcardName: "eco_wild"


    // show the image of the line
    Image {
        id: lineImage
        anchors.fill: parent
    }

    // area that will hold dynamically created line-symbols
    Item {
        id: symbolArea
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        z: 10

        //        // display win amount
        //        Text {
        //            id: winText
        //            x: 15
        //            color: "black"
        //            text: scene.winAmount
        //            font.pixelSize: 10
        //            z: 2
        //        }

        //        // add background area around win text
        //        Rectangle {
        //            width: winText.width + 20
        //            height: winText.height + 4
        //            anchors.centerIn: winText
        //            color: winningLine.color
        //            z: 1
        //        }

        Rectangle {
            id: winBackdrop
            color: "black"
            opacity: .7
            anchors.fill: parent
            //            x: 0; y:-40;
//            width: scene.sceneGameWindow.width
//            height: scene.sceneGameWindow.height
//            width: scene.width
//            height: scene.height
            width: parent.width
            height: parent.height
        }

        Image {
            z: 1
            anchors.centerIn: parent
            width: dp(200)
            height: dp(90)
            source: "../../../assets/frame-win.png"
        }
        AppText {
            z: 1
            anchors.centerIn: parent
            id: winText
            text: scene.winAmount
            font.weight: Font.DemiBold
            font.pixelSize: gameWindow.sp(16)
        }

    }

    // draw symbols on winning line, parameter machine holds a reference to the slot machine
    function drawLineSymbols(machine) {
        // remove old symbols
        removeLineSymbols()

        // set size of symbol container to match slot machine
        // this is needed to be able to position the symbols on the line relatively to
        // the slot machine instead of the winning line area (winning line is wider than the slot machine)
        symbolArea.width = machine.width
        symbolArea.height = machine.height


        console.debug("symbolArea.width: " + symbolArea.width)
        console.debug("symbolArea.height: " + symbolArea.height)
        //      console.debug("winFactor: " + winFactor)
        //      console.debug("winFactor: " + winFactor)

        // define y-offset for each line symbol, this is required because the symbol size of the slot machine items includes a top margin of 5px
        //    var yOffset = 5
        var yOffset = 0

        // create all line symbols for winning positions
        for(var i = 0; i < winningLine.__winningPositions.length; i++) {
            // set properties for line symbol
            var properties = {
                // the symbol background and border should be colored in the line color
                color: winningLine.color,
                // set correct position and height
                x: Math.round((machine.defaultReelWidth * winningLine.__winningPositions[i].reel)),
                y: Math.round((machine.defaultItemHeight * winningLine.__winningPositions[i].row) + yOffset),
                width: machine.defaultReelWidth,
                height: machine.defaultItemHeight - 10,
                // set symbol type
                type: winningLine.__winningTypes[i]
            }

            // dynamically create line symbol and add it symbol area
            var component = Qt.createComponent(Qt.resolvedUrl("LineSymbol.qml"))
            var symbol = component.createObject(symbolArea, properties)

            // memorize all symbol objects that are created
            winningLine.__lineSymbols.push(symbol)
        }

        // set y position of win text (different for each line)
        if(__winningPositions[0].row === 0) {
            // on the first row: write win text below first symbol of the line
            winText.y = winningLine.__lineSymbols[0].y + winningLine.__lineSymbols[0].height
        }
        else {
            // on other rows: write win text above first symbol of the line
            winText.y = winningLine.__lineSymbols[0].y - winText.height
        }
    }

    // remove symbols from winning line
    function removeLineSymbols() {
        // destroy all line symbols
        for(var i = 0; i < winningLine.__lineSymbols.length; i++) {
            winningLine.__lineSymbols[i].destroy()
        }

        // delete memory
        winningLine.__lineSymbols = []
    }

    // validate if the player has won on the line
    function validate(machine) {
        // reset all local variables and private component properties
        var length = 0
        var currentType = null
        __winningPositions = []
        __winningTypes = []

        // check all slot positions of the line
        for(var i = 0; i < positions.length; i++) {
            var pos = positions[i]
            if(pos === null)
                return false

            // get current item for the slot position
            var symbol = machine.getItemData(pos.reel, pos.row)
            if(symbol === null)
                return false

            // first symbol defines start of the line
            //      if(i == 0) {
            if(i === 0) {
                currentType = symbol.type
                length = 1
            }
            // next symbols may add to the winning line if the type matches
            else {
                // if new symbol type and no wildcards are involved -> stop (possible line has ended)
                if(currentType !== symbol.type && symbol.type !== winningLine.wildcardName && currentType !== winningLine.wildcardName) {
                    break;
                }

                // if old symbol was a wildcard, switch current type to new symbol
                if(currentType === winningLine.wildcardName)
                    currentType = symbol.type

                // increase length counter
                length++;
            }

            // current position and type count to the line -> memorize position and type
            __winningPositions.push(pos)
            __winningTypes.push(symbol.type)
        }

        // return false if line length is too short
        if(length < 3)
            return false

        // calculate win amount and return true
        var winFactor = SymbolConfig.getWinFactor(currentType, length)
        winAmount = scene.betAmount * winFactor


        console.debug("YOU WON!")
        console.debug("winFactor: " + winFactor)
        console.debug("winAmount: " + winAmount)
        console.debug("scene.winAmount: " + scene.winAmount)
        console.debug("scene.betAmount: " + scene.betAmount)
        console.debug("__winningTypes: " + __winningTypes)
        console.debug("__winningPositions: " + __winningPositions)


        // draw symbols on winning line (based on memorized positions and types) and return true
        winningLine.drawLineSymbols(machine)
        return true
    }
}
