import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12

ApplicationWindow
{
    id: mainWindow
    width: 1920
    height: 1080
    //visibility: "FullScreen"

    property var loading: false
    property var selectedOverlay
    property var selectedCounted

    Rectangle
    {
        anchors.fill: parent
        color: "#B0E3E2"
    }

    RowLayout
    {
        anchors.fill: parent
        
        Frame
        {
            Layout.fillHeight: true   
            Layout.preferredWidth: 300

            background : Rectangle 
            {
                color: "#2D2926"
            }

            ColumnLayout
            {
                Image
                {
                    id: background
                    sourceSize.width: 225
                    source: "./Assets/logo.png"
                }

                Rectangle {height: 40}

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
        edge: Qt.RightEdge

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

    Rectangle
    {
        id: popupBackground
        visible: true
        x: -10000
        y: -10000
        width: 30000
        height: 30000
        color: "#cccccccc"

        Image
        {
            visible: !loading
            source: selectedOverlay
            sourceSize.width: 200
        }

        Image
        {
            visible: !loading
            source: selectedCounted
            sourceSize.width: 200
        }

        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                if (!loading) 
                    popupBackground.visible = false
            }
        }
    }
}
