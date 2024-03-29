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
            var folder = "./ImageCaptures/" + Qt.formatTime(new Date(), "hh:mm:ss")
            var input = folder + "/input/"
            var output = folder + "/output/"
            
            /* This should be replaced by the interator in a loop when updated for more cameras */
            var number = 0
            var file = input + number + ".png"

            loading = true
            popupBackground.visible = true
            app.createDirectories(folder)
            cameraStream.grabToImage(function(image) 
            {
                console.log(file)
                image.saveToFile(file); // save happens here
                console.log("IMAGE SAVED")
            
                app.runSeedCounter(input, output)
                console.log("DONE SEEDCOUNTER")
                loading = false

                selectedOverlay = output + number + "_overlay.jpg"
                selectedCounted = output + number + "_seeds_counted.jpg"
                outputList.append({"file": file, "overlay": selectedOverlay, "counted": selectedCounted})
            });
        }
    }

    ListView
    {   
        clip: true
        Layout.fillWidth: true
        Layout.preferredHeight: 160
        orientation: ListView.Horizontal
        spacing: 20

        model: ListModel {id: outputList}

        delegate: ColumnLayout
        {
            Image
            {
                source: file
                sourceSize.width: 200
                sourceSize.height: 112

                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        selectedOverlay = overlay
                        selectedCounted = counted
                        popupBackground.visible = true
                    }
                }
            }
        }
    }
}
