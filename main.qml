import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtWebKit 3.0
import QtQuick.Controls 1.4

import "canvasjs/canvasjs.min.js" as Canvas
//import StockData 1.0


Window {

//    Connections {
//        target: oauth
//        onSignalAuthUrl: { console.log(url); dialog.setUrl(url); dialog.open(); }
//    }

    id: root
    visible: true

    width: 1200
    height: 960

//    property var colorList:["blue","green","red"];
//    Component {


//        id: tableDelegate
//        Item {

//            Text {
//                property int c: model.Change;
//                //                   width: parent.width
////                   anchors.margins: 4
////                   anchors.left: parent.left
////                   anchors.verticalCenter: parent.verticalCenter
//                elide: Text.ElideRight
//                //                wrapMode: Text.WordWrap
//                width: table.colWidth
//                text: styleData.value !== undefined ? styleData.value : "undef"
//                color: model.Change > 0.0 ? "green" : (model.Change < 0 ? "red" : "blue");
//            }
//        }
//    }


    Rectangle {
        height: parent.height
        width: root.width * 0.2
        id: searchRect

        Connections {
            target: yahoo
            onNoStockFound: console.log("error: " + errorMsg);
        }

        SearchField {

            id: search
            title: "search stock"
            onAccepted: {
                yahoo.searchStocks(searchString);
            }
        }

        SearchResultList {
            anchors.top: search.bottom
            width: parent.width
            height: 700
            headerText: "the header";
        }

    }

    StockTableView {
        id: table
        height: parent.height / 3
        width: root.width - searchRect.width
        anchors.left: searchRect.right

//        onActivated: {
//            var symbol = table.get(row).Symbol
//            var fromDate = new Date();
//            var toDate = new Date();
//            console.log("getting date from row " + row + " symb " + symbol);

//            fromDate.setYear(fromDate.getYear() -1);
//            yahoo.getHistoricalStockData(symbol,fromDate,toDate);
//        }
    }

    Rectangle {
        id: chart
        height: 2 * parent.height / 3
        width: table.width
        anchors.top: table.bottom
        anchors.left: table.left
        border.color: "black"
        border.width: 2

        Component.onCompleted: {
            var chart = new Canvas.Chart("chartContainer", {
                    title:{
                        text: "My First Chart in CanvasJS"
                    },
                    data: [
                    {
                        // Change type to "doughnut", "line", "splineArea", etc.
                        type: "column",
                        dataPoints: [
                            { label: "apple",  y: 10  },
                            { label: "orange", y: 15  },
                            { label: "banana", y: 25  },
                            { label: "mango",  y: 30  },
                            { label: "grape",  y: 28  }
                        ]
                    }
                    ]
                });
                chart.render();
            }
    }

    //    TableView {
    //        height: parent.height
    //        anchors.left: searchRect.right
    //        width: root.width - searchRect.width
    //        property int colWidth: width / stockModel.columnCount();
    //        id: table
    //        model: stockModel
    //        TableViewColumn{ role: stockModel.headerData(0,Qt.Horizontal,0) ; title: stockModel.headerData(0,Qt.Horizontal,0) ; width: table.colWidth; elideMode: Text.ElideRight}
    //        TableViewColumn{ role: stockModel.headerData(1,Qt.Horizontal,0) ; title: stockModel.headerData(1,Qt.Horizontal,0) ; width: table.colWidth}
    //        TableViewColumn{ role: stockModel.headerData(2,Qt.Horizontal,0) ; title: stockModel.headerData(2,Qt.Horizontal,0) ; width: table.colWidth}
    //        TableViewColumn{ role: stockModel.headerData(3,Qt.Horizontal,0) ; title: stockModel.headerData(3,Qt.Horizontal,0) ; width: table.colWidth}
    //        TableViewColumn{ role: stockModel.headerData(4,Qt.Horizontal,0) ; title: stockModel.headerData(4,Qt.Horizontal,0) ; width: table.colWidth}
    //        TableViewColumn{ role: stockModel.headerData(5,Qt.Horizontal,0) ; title: stockModel.headerData(5,Qt.Horizontal,0) ; width: table.colWidth}
    //        TableViewColumn{ role: stockModel.headerData(6,Qt.Horizontal,0) ; title: stockModel.headerData(6,Qt.Horizontal,0) ; width: table.colWidth}
    //        TableViewColumn{ role: stockModel.headerData(7,Qt.Horizontal,0) ; title: stockModel.headerData(7,Qt.Horizontal,0) ; width: table.colWidth}
    //        TableViewColumn{ role: stockModel.headerData(3,Qt.Horizontal,0) ; title: stockModel.headerData(8,Qt.Horizontal,0) ; width: table.colWidth}
    //        itemDelegate: tableDelegate
    //    }
}
