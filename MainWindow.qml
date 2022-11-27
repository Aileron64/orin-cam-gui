import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12

import "Components"
import "Pages"

ApplicationWindow
{
    id: mainWindow
    width: 1920
    height: 1080
    visibility: "FullScreen"

    Frame
    {
        id: mainPanel
        visible: isLoggedIn
        width: parent.width * 0.9
        height: parent.height * 0.7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter

        background: SM_PanelBackground { }
    }

    Rectangle
    {
        id: popupBackdrop
        visible: false
        anchors.fill: parent
        color: "#4f4f4f"
        opacity: 1
    }

    Item
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.margins: 10

        ToolTip
        {
            id: errorDisplay
            timeout: 3000
            font.pointSize: 18

            background: Rectangle 
            {
                color: "#9c0000"
                radius: 10
            }
        }
    }

    Button
    {
        text: "Exit"
        visible: true
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 20

        onClicked: Qt.quit()
    }
}
