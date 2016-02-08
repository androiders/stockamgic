import QtQuick 2.0

Item {
    id: root
    width: 200
    height: 600

    property int itemHeight: 20
    property string headerText: "Header"

    Component {
        id: highlightBar
        Rectangle {
            width: root.width
            height: itemHeight
            color: "#FFFF88"
            y: searchList.currentItem.y
            Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
        }
    }

    Component {
        id: listDelegate
        Item{
            width: root.width
            height: itemHeight
            Row {
                spacing: 3

                Text {
                    text: modelData.name
                }
                Text {
                    text: modelData.exchDisp
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    searchList.currentIndex = index;
                    console.log("setting current index: " + index);
                }
                onDoubleClicked: {
                    yahoo.getStockBySymbol(searchList.model[index].symbol);
                }
            }
        }
    }
    ListView {
        id: searchList
        anchors.fill: parent
        delegate: listDelegate
        highlight: highlightBar
        highlightFollowsCurrentItem: true

        header : Text { text: headerText }
        focus: true

        Connections {
            target: yahoo
            onStockSearchReady: {
                console.log("setting model " + JSON.stringify(searchResults));
                searchList.model = searchResults;
                console.log("model size: " + height);
                searchList.currentIndex = 0
            }
        }
    }
}

