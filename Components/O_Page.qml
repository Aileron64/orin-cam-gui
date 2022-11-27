import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

GridLayout
{
    id: page
    visible: false

    rowSpacing: 20
    columnSpacing: 20
    width: parent.width * 0.9
    height: parent.height * 0.75
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    anchors.verticalCenterOffset: parent.height * -0.03
}
