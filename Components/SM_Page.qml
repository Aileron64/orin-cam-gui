import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

ColumnLayout
{
    id: page
    visible: false
    property var nextPage
    property var prevPage

    property var nextEnabled: true
    property var prevEnabled: true

    function onNext() 
    {
        visible = false
        currentPage = nextPage
        currentPage.visible = true
    }

    function onPrev() 
    {
        visible = false
        currentPage = prevPage
        currentPage.visible = true
    }

    spacing: 20
//    rowSpacing: 20
//    columnSpacing: 20
    width: parent.width * 0.9
    height: parent.height * 0.75
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    anchors.verticalCenterOffset: parent.height * -0.03
}
