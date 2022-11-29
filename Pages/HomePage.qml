import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12
import QtMultimedia 5.15

// import QtGStreamer 1.0

import "../Components"

O_Page
{
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
            + ' videoconvert !'
            + 'video/x-raw, format=(string)BGR ! '
            + ' videoconvert ! qtvideosink'

        autoPlay: true
    }

    O_Frame 
    {
        width: parent.width * 0.5
        
        VideoOutput 
        {
            id: output
            source: player
            anchors.fill: parent
        }
    }

    O_Frame 
    {
        O_Text 
        {
            text: "Data Collection"
            // Take Images
        }
    }

    O_Frame 
    {
        O_Text 
        {
            text: "Validation"
            // Validation
        }
    }

    O_Frame 
    {
        O_Text 
        {
            text: "Calibration"
            // Calibration

            // Camera
            // Top Light
            // Back Light
            // Self Calibration
        }
    }
}
