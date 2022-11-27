import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
    
import "Components"

Drawer 
{
    id: chatboxDrawer
    edge: Qt.RightEdge
    width: 0.3 * parent.width
    height: parent.height

    background: SM_PanelBackground { radius: 0 }

    Connections
    {
        target: app

        function onChatMessage(message)
        {
            chatModel.insert(0, {message: message, isUser: false})
        }
    }

    ColumnLayout
    {
        spacing: 10
        anchors.centerIn: parent
        height: parent.height * 0.7
        width: parent.width * 0.9

        SM_Frame
        {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView
            {
                spacing: 5
                verticalLayoutDirection: ListView.BottomToTop
                anchors.fill: parent

                model: ListModel { id: chatModel }

                delegate: Rectangle
                {
                    width: chatMessage.width + 25
                    height: chatMessage.height + 10
                    radius: 5

                    color: isUser ? "#000d63" : "#364a00"

                    Text
                    {
                        id: chatMessage
                        text: message
                        font.pointSize: 12
                        color: "white"
                        wrapMode: Text.Wrap
                        horizontalAlignment: Text.AlignHCenter
                        anchors.centerIn: parent
                    }
                }
            }
        }

        SM_Frame
        {
            Layout.fillWidth: true
            Layout.fillHeight: false

            SM_TextField
            {
                id: chatInput
                anchors.fill: parent

               Keys.onReturnPressed:
                {
                    chatModel.insert(0, {message: chatInput.text, isUser: true})
                    app.onChatMessage(chatInput.text)
                    chatInput.text = ""
                }
            }
        }
    }
}
