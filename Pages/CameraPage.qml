import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12
import QtMultimedia 5.15

ColumnLayout
{
    spacing: 20
    width: parent.width * 0.9
    height: parent.height * 0.75
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    anchors.verticalCenterOffset: parent.height * -0.03

    MediaPlayer 
    {
        id: player
        source: 'gst-pipeline: '
            + 'nvarguscamerasrc sensor-id={ind} num-buffers=22222221 ! '
            + 'video/x-raw(memory:NVMM), '
            + 'width=(int)1920, height=(int)1080, '
            + 'format=(string)NV12 ! '
            + 'nvvidconv ! '
            + 'video/x-raw, width=(int)1920, height=(int)1080, format=(string)BGRx ! '
            + 'videoconvert !'
            + 'video/x-raw, format=(string)BGR ! '
            + 'videoconvert ! qtvideosink'

        autoPlay: true
    }

    VideoOutput 
    {
        id: output
        source: player
        anchors.fill: parent
    }
}
