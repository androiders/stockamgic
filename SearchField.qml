import QtQuick 2.0


Rectangle {
    height: 60
    width: 200
    id: searchRect

    property alias title: searchText.text;

    //emitted eveytime the text is edited
    //signal textEdited(var textString)

    signal accepted(var searchString)

    Text {
        id: searchText
        text: title
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        id: rectangle1
        anchors.top: searchText.bottom

        width: parent.width
        height: 30
        border.width: 1
        radius: 14
        color: "#ffffff"

        Connections {
            target: yahoo
            onNoStockFound: console.log("error: " + errorMsg);
        }

        TextInput {
            id: search
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width -4
            height: parent.height -4
            color: "grey"
            anchors.left: parent.left
            anchors.leftMargin: 12
            cursorVisible: false
            //displayText: "search"
            onAccepted: searchRect.accepted(text);

        }
     }
}

