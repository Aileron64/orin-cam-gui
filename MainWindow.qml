import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12
import "Pages"

ApplicationWindow
{
    id: mainWindow
    width: 1920
    height: 1080
    //visibility: "FullScreen"

    Rectangle
    {
        anchors.fill: parent
        gradient: Gradient
        {
            GradientStop { position: 1.0; color: "#25224d" }
            GradientStop { position: 0.0; color: "#403a85" }
        }
    }



    CameraPage { visible: true }

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

    Drawer 
    {
        id: drawer
        width: 0.66 * mainWindow.width
        height: mainWindow.height

        background: Rectangle 
        {
            color: "#575859"
        }

        Label 
        {
            text: "Example"
            anchors.centerIn: parent
        }
    }

    Button
    {
        text: "Profile/Settings"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20

        onClicked: drawer.visible = true
    }

    Button
    {
        text: "Exit"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 20

        onClicked: Qt.quit()
    }
}
