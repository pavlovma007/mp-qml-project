/****************************************************************************
 **
 ** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
 ** All rights reserved.
 ** Contact: Nokia Corporation (qt-info@nokia.com)
 **
 ** This file is part of the examples of the Qt Toolkit.
 **
 ** $QT_BEGIN_LICENSE:BSD$
 ** You may use this file under the terms of the BSD license as follows:
 **
 ** "Redistribution and use in source and binary forms, with or without
 ** modification, are permitted provided that the following conditions are
 ** met:
 **   * Redistributions of source code must retain the above copyright
 **     notice, this list of conditions and the following disclaimer.
 **   * Redistributions in binary form must reproduce the above copyright
 **     notice, this list of conditions and the following disclaimer in
 **     the documentation and/or other materials provided with the
 **     distribution.
 **   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
 **     the names of its contributors may be used to endorse or promote
 **     products derived from this software without specific prior written
 **     permission.
 **
 ** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 ** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 ** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 ** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 ** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 ** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 ** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 ** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 ** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 ** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 ** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 ** $QT_END_LICENSE$
 **
 ****************************************************************************/


 import QtQuick 1.0

 Item {
     id: root
     property real value : 0.0
     property real min: 0.0
     property real max: 100.0
     property alias backgroundImage: background.source

     // Needle image properties
     property alias needleImage: needle.source
     property alias needleImageWidth: needle.width
     property alias needleImageHeight: needle.height
     // Postion of the needle image
     property alias needleX: needle.x
     property alias needleY: needle.y

     //Overlay image properties
     property alias overlayImage: overlay.source
     property alias overlayImageWidth: overlay.width
     property alias overlayImageHeight: overlay.height
     // Position of the overlay image.  Used to cover the end of the needle
     property alias overlayX: overlay.x
     property alias overlayY: overlay.y

     // Position where the rotation happens on the needle image
     property alias needleRotationX: needleRotation.origin.x
     property alias needleRotationY: needleRotation.origin.y

     // Angle the needle will change
     property alias angle: needleRotation.angle
     property real minAngle: -130
     property real maxAngle: 133

     width: background.width;
     height: background.height

     onValueChanged: {
         // When inheriting this control override this function
     }

     Image {
         id: background
     }

     Image {
         id: needle
         smooth: true
         transform: Rotation {
             id: needleRotation
             Behavior on angle {
                 SpringAnimation {
                     spring: 1.4
                     damping: .15
                 }
             }
         }
     }

     Image {id:overlay
     }
 }
