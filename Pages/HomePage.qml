import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12
import QtQuick.QtMultimedia 5.15

import "../Components"

O_Page
{
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
