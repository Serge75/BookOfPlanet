import Felgo 3.0
import QtQuick 2.0
import "../common"
import "slotmachine"


SceneBase {
    id: gameScene
    property string levelName
    property alias scene: gameScene

    // properties for the game
    property int betAmount: 10 // amount to bet per line
    property int creditAmount: 500 // player credit for gambling
    property int winAmount: 0

    // animate credit amount when changed
    Behavior on creditAmount {
        PropertyAnimation { duration: scene.betAmount * 50 }
    }

    BackgroundImage {
        anchors.fill: scene.gameWindowAnchorItem
        source: "../../assets/background-play.jpg"
    }

    TopBar {
        id: topBar
        //      width: scene.gameWindowAnchorItem.width
        width: parent.width
    }

    SlotMachine {
        id: slotMachine

        anchors.horizontalCenter: scene.horizontalCenter
        anchors.top: topBar.bottom

        height: scene.gameWindowAnchorItem.height - topBar.height - bottomBar.height
        width: scene.gameWindowAnchorItem.width

        // from tutorial
//        defaultItemHeight: 80 // image height 70 + 5 margin top + 5 margin bottom (Symbol.qml)
//        defaultReelWidth: 67 // image width

        // we then calculate the default item height based on the actual slotmachine height and row count
//        defaultItemHeight: Math.round(slotMachine.height / slotMachine.rowCount) - 10
        defaultItemHeight: Math.round(slotMachine.height / slotMachine.rowCount) - 5

        // and change the reel width to match the item height (to maintain the width/height ratio of the items)
//        defaultReelWidth: Math.round(defaultItemHeight / 80 * 67)
        defaultReelWidth: Math.round(defaultItemHeight / 80 * 74)

        // velocity of spin should decrease/increase along with item height
        spinVelocity: Math.round(defaultItemHeight / 80 * 750)

        // link signal to handler function
        onSpinEnded: scene.spinEnded()

        // choose random delay to stop each reel for every spin
        onSpinStarted: {
            // delay stop of each reel between 350 and 700 ms
            slotMachine.reelStopDelay = utils.generateRandomValueBetween(350, 700)
        }
    }

    BottomBar {
        id: bottomBar

        anchors.top: slotMachine.bottom
        //      width: scene.gameWindowAnchorItem.width
        width: parent.width

        // link signals to handler functions
        onStartClicked: scene.startSlotMachine()
        //      onAutoClicked: scene.autoPlaySlotMachine()
        onIncreaseBetClicked: {
            console.debug("increase clicked!")
            scene.increaseBetAmount()
        }
        onDecreaseBetClicked: scene.decreaseBetAmount()
        //      onMaxBetClicked: scene.maxBetAmount()
    }

    // validator to check if player has won
    WinValidator {
        id: winValidator
        height: slotMachine.height // height is the same as slotmachine height
        width: Math.round(height /  240 * 408) // width/height ratio should remain constant
        anchors.centerIn: scene.gameWindowAnchorItem
    }


    // increase bet
    function increaseBetAmount() {

        // prevent bet changes while start button is active (machine is running)
        if(bottomBar.startActive)
            return

        // increase bet amount to next bigger step
        if (betAmount < 5 && creditAmount >= 5)
            betAmount = 5
        else if (betAmount < 8 && creditAmount >= 8)
            betAmount = 8
        else if (betAmount < 10 && creditAmount >= 10)
            betAmount = 10
        else if (betAmount < 15 && creditAmount >= 15)
            betAmount = 15
        else if (betAmount < 20 && creditAmount >= 20)
            betAmount = 20
    }

    // decrease bet
    function decreaseBetAmount() {
        // prevent bet changes while start button is active (machine is running)
        if(bottomBar.startActive)
            return

        // decrease bet amount to next smaller step
        if (betAmount > 15 && creditAmount >= 15)
            betAmount = 15
        else if (betAmount > 10 && creditAmount >= 10)
            betAmount = 10
        else if (betAmount > 8 && creditAmount >= 8)
            betAmount = 8
        else if (betAmount > 5 && creditAmount >= 5)
            betAmount = 5
        else if (betAmount > 4)
            betAmount = 4
    }

    // start slot machine
    function startSlotMachine() {

        console.debug("slotMachine.defaultItemHeight: " + slotMachine.defaultItemHeight)
        console.debug("slotMachine.defaultReelWidth: " + slotMachine.defaultReelWidth)


        if(!slotMachine.spinning && scene.creditAmount >= scene.betAmount) {
            bottomBar.startActive = true

            // reduce player credits
            scene.creditAmount -= scene.betAmount

            // start machine
            winValidator.reset()
            var stopInterval = utils.generateRandomValueBetween(500, 1000) // between 500 and 1000 ms
            slotMachine.vplayRocks()

            slotMachine.spin(stopInterval)
        }
    }

    // when spin is finished -> validate result
    function spinEnded() {
        bottomBar.startActive = false
        var won = winValidator.validate(slotMachine)
        if(won)
            winValidator.showWinningLines()
        //        winValidator.startWinAnimation()
        else if(bottomBar.autoActive)
            startSlotMachine()
    }


}


//    // the filename of the current level gets stored here, it is used for loading the
//    property string activeLevelFileName
//    // the currently loaded level gets stored here
//    property variant activeLevel
//    // score
//    property int score: 0
//    // countdown shown at level start
//    property int countdown: 0
//    // flag indicating if game is running
//    property bool gameRunning: countdown == 0

//    // set the name of the current level, this will cause the Loader to load the corresponding level
//    function setLevel(fileName) {
//        activeLevelFileName = fileName
//    }


//    // back button to leave scene
//    MenuButton {
//        text: "Back to menu"
//        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
//        anchors.right: gameScene.gameWindowAnchorItem.right
//        anchors.rightMargin: 10
//        anchors.top: gameScene.gameWindowAnchorItem.top
//        anchors.topMargin: 10
//        onClicked: {
//            backButtonPressed()
//            activeLevel = undefined
//            activeLevelFileName = ""
//        }
//    }

//    }

//    // text displaying either the countdown or "tap!"
//    Text {
//        anchors.centerIn: parent
//        color: "white"
//        font.pixelSize: countdown > 0 ? 160 : 18
//        text: countdown > 0 ? countdown : "tap!"
//    }

//    // if the countdown is greater than 0, this timer is triggered every second, decreasing the countdown (until it hits 0 again)
//    Timer {
//        repeat: true
//        running: countdown > 0
//        onTriggered: {
//            countdown--
//        }
//    }
//}
