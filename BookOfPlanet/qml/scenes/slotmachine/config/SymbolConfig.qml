pragma Singleton
import Felgo 3.0
import QtQuick 2.0

SlotMachineModel {

  // configure symbols and frequency of each symbol per reel
  symbols: {
    "red_can":      {
      frequency: 1,
      data: {
        source: "symbol-1.png",
        winFactor: [1, 5, 20]
      }
    }, // 1 x red_can

//    "eco_wild":      {
//      frequency: 5,
//      data: {
//        source: "symbol-2.png",
//        winFactor: [1, 5, 20]
//      }
//    }, // 5 x eco_wild

    "red_battery":        {
      frequency: 5,
      data: {
        source: "symbol-3.png",
        winFactor: [1, 5, 20]
      }
    }, // 5 x red_battery

    "leaves":        {
      frequency: 5,
      data: {
        source: "symbol-4.png",
                winFactor: [6, 20, 150]
      }
    }, // 5 x leaves

    "blue_bin":        {
      frequency: 4,
      data: {
        source: "symbol-5.png",
        winFactor: [1, 8, 30]
      }
    }, // 4 x blue_bin

    "droplet":        {
      frequency: 4,
      data: {
        source: "symbol-6.png",
                winFactor: [6, 20, 150]
      }
    }, // 4 x droplet

    "red_bag":   {
      frequency: 4,
      data: {
        source: "symbol-7.png",
                winFactor: [1, 5, 20]
      }
    }, // 3 x red_bag

    "green_arrows":    {
      frequency: 3,
      data: {
        source: "symbol-8.png",
                winFactor: [8, 80, 400]
      }
    }, // 3 x green_arrows

    "brown_bag": {
      frequency: 3,
      data: {
        source: "symbol-9.png",
                winFactor: [1, 8, 30]
      }
    }, // 2 x brown_bag

    "eco_wild":  {
      frequency: 1,
      data: {
        source: "symbol-2.png",
        winFactor: [20, 200, 1000]
      }
    }  // 1 x eco_wild
  }

  // return symbol data for specific symbol
  function getSymbolData(symbol) {
    if(symbols[symbol] === undefined)
      return null
    else
      return symbols[symbol].data
  }

  // return win factor for specific type and line length
  function getWinFactor(symbol, length) {
    var symbolData = getSymbolData(symbol)
    if(symbolData === null)
      return 0

    var index = length - 3 // length 3 = index 0, length 4 = index 1, ...
    if(symbolData.winFactor === undefined || symbolData.winFactor[index] === undefined)
      return 0

    return symbolData.winFactor[index]
  }
}
