import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12
import QtMultimedia 5.15

ColumnLayout
{
    property var imgCount: 0
    spacing: 20

    MediaPlayer 
    {
        id: camera_1
        source: 'gst-pipeline: '
            + 'nvarguscamerasrc sensor-id={ind} num-buffers=22222221 ! '
            + 'video/x-raw(memory:NVMM), '
            + 'format=(string)NV12 ! '
            + 'nvvidconv ! '
            + 'video/x-raw, width=(int)1920, height=(int)1080, format=(string)BGRx ! '
            + 'videoconvert !'
            + 'video/x-raw, format=(string)BGR ! '
            + 'videoconvert ! qtvideosink'

        autoPlay: true
    }

    // MediaPlayer 
    // {
    //     id: camera_2
    //     source: 'gst-pipeline: '
    //         + 'nvarguscamerasrc sensor-id={ind} num-buffers=22222221 ! '
    //         + 'video/x-raw(memory:NVMM), '
    //         + 'format=(string)NV12 ! '
    //         + 'nvvidconv ! '
    //         + 'video/x-raw, width=(int)1920, height=(int)1080, format=(string)BGRx ! '
    //         + 'videoconvert !'
    //         + 'video/x-raw, format=(string)BGR ! '
    //         + 'videoconvert ! qtvideosink'

    //     autoPlay: true
    // }

    Frame
    {
        Layout.fillHeight: true
        Layout.fillWidth: true

        VideoOutput 
        {
            id: cameraStream
            source: camera_1
            anchors.fill: parent
        }
    }

    // Frame
    // {
    //     Layout.fillHeight: true
    //     Layout.fillWidth: true

    //     VideoOutput 
    //     {
    //         source: camera_2
    //         anchors.fill: parent
    //     }
    // }

    Button 
    {
        Layout.alignment: Qt.AlignCenter
        Layout.preferredHeight: 60
        Layout.preferredWidth: 500
        text: "Capture"
        onClicked: 
        {
            imgCount++
            var filename = "./ImageCaptures/" + Qt.formatTime(new Date(), "hh:mm:ss") + ".png"
            
            cameraStream.grabToImage(function(image) 
            {
                console.log(filename)
                image.saveToFile(filename); // save happens here
                listModel.append({"file": filename})
            });

            app.runSeedCounter("./ImageCaptures/", "./Output/")
        }
    }

    ListView
    {   
        clip: true
        Layout.fillWidth: true
        Layout.preferredHeight: 120
        orientation: ListView.Horizontal
        spacing: 20

        model: ListModel {id: listModel}

        delegate: ColumnLayout
        {
            Image
            {
                source: "file:" + file
                sourceSize.width: 200
                sourceSize.height: 112
            }
        }
    }
}
