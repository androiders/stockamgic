import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtWebKit 3.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.2

Rectangle {

    id: base

    width: 600
    height: 800


    signal activated(var row)
//    Connections {
//        target: table
//        onDoubleClicked: {
//            console.log("table dbl clicked on row " + row);
//        }

//    }

    DelegateModel {
        id: dModel
        model: stockModel
        delegate: Rectangle {
            height: 25
            width: 100

            Text { text: dModel.modelIndex(index).row + " " + dModel.modelIndex(index).column }
        }
    }

    TableView {
        anchors.fill: parent
        //anchors.left: searchRect.right
        //width: root.width - searchRect.width
        property int colWidth: width / stockModel.columnCount();
        property int colHeight: 20
        id: table
        TableViewColumn{ role: stockModel.headerData(0,Qt.Horizontal,0) ; title: stockModel.headerData(0,Qt.Horizontal,0) ; width: table.colWidth; elideMode: Text.ElideRight}
        TableViewColumn{ role: stockModel.headerData(1,Qt.Horizontal,0) ; title: stockModel.headerData(1,Qt.Horizontal,0) ; width: table.colWidth}
        TableViewColumn{ role: stockModel.headerData(2,Qt.Horizontal,0) ; title: stockModel.headerData(2,Qt.Horizontal,0) ; width: table.colWidth}
        TableViewColumn{ role: stockModel.headerData(3,Qt.Horizontal,0) ; title: stockModel.headerData(3,Qt.Horizontal,0) ; width: table.colWidth}
        TableViewColumn{ role: stockModel.headerData(4,Qt.Horizontal,0) ; title: stockModel.headerData(4,Qt.Horizontal,0) ; width: table.colWidth}
        TableViewColumn{ role: stockModel.headerData(5,Qt.Horizontal,0) ; title: stockModel.headerData(5,Qt.Horizontal,0) ; width: table.colWidth}
        TableViewColumn{ role: stockModel.headerData(6,Qt.Horizontal,0) ; title: stockModel.headerData(6,Qt.Horizontal,0) ; width: table.colWidth}
        TableViewColumn{ role: stockModel.headerData(7,Qt.Horizontal,0) ; title: stockModel.headerData(7,Qt.Horizontal,0) ; width: table.colWidth}
        TableViewColumn{ role: stockModel.headerData(3,Qt.Horizontal,0) ; title: stockModel.headerData(8,Qt.Horizontal,0) ; width: table.colWidth}
        itemDelegate: tableDelegate
//        rowDelegate: rowDelegate
        alternatingRowColors: true

        model: stockModel

        //rowCount: 10

//        style: TableViewStyle {
//            backgroundColor: "black"
//        }

//        onActivated: {
//            //var idx = new QModelIndex(row,0);
//          var symbol = model.get(row).symbol;
//            //var fromDate = new Date();
//            //var toDate = new Date();
//           console.log("getting date from row " + row + " symbol " + symbol);

//            //fromDate.setYear(fromDate.getYear() -1);
//            //yahoo.getHistoricalStockData(symbol,fromDate,toDate);
//        }

    }

    Component {
        id: rowDelegate
        Rectangle {
            width: table.colWidth
            height: table.colHeight
            color: {
                if(styleData.row %2 === 0)
                    return "white";
                else
                    return "lightGray";
            }
        }
    }

    Component {
        id: tableDelegate
        Item {
            id: parent
            property var colorList:["blue","green","red"];
            property string symbol: model.Symbol
            Text {
                property int c: model.Change;
                elide: Text.ElideRight
                //                wrapMode: Text.WordWrap
                width: table.colWidth
                text: {

                    if(styleData.value === undefined)
                        return "undef";
                    if(typeof styleData.value === "number")
                        return styleData.value.toFixed(2);
                    else
                        return styleData.value;
                }
                color: model.Change > 0.0 ? "green" : (model.Change < 0 ? "red" : "blue");
                font.weight: styleData.selected ? Font.Bold : Font.Normal
            }
            MouseArea {
                anchors.fill: parent
                onDoubleClicked: {
                    var symbol = stockModel.data(styleData.row,0,1);//stockModel.data(row,0,1);
                    var fromDate = new Date();
                    var toDate = new Date();
                    console.log("getting date from row " + parent.symbol);

                    fromDate.setYear(2014);
                    yahoo.getHistoricalStockData(parent.symbol,fromDate,toDate);
                }
            }
        }


    }
}
