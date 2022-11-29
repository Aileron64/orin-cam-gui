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

    RowLayout
    {
        Frame
        {
            Layout.fillHeight: true   
            Layout.preferredWidth: parent.width * 0.1

            background : Rectangle 
            {
                color: "#575859"
            }

            ColumnLayout
            {
                Button
                {
                    text: "Profile/Settings"
                    onClicked: drawer.visible = true
                }

                Button
                {
                    text: "Data Collection"
                    onClicked: drawer.visible = true
                }

                Button
                {
                    text: "Validation"
                    onClicked: drawer.visible = true
                }

                Button
                {
                    text: "Calibration"
                    onClicked: drawer.visible = true
                }
            }
        }

        CameraPage 
        { 
            Layout.fillWidth: true
            visible: true 
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
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 20

        onClicked: Qt.quit()
    }
}
