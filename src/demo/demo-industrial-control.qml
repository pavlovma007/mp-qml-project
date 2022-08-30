import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0 as Controls
//import QSyncable 1.0
import QMLExif 1.0

Item {

	QMLExif {
		id: exif
		source: "./example.JPG"
		ifd: QMLExif.IFD_EXIF
	}
	Text {
		width: parent.width
		height: parent.height
		anchors.left: parent.left
		anchors.verticalCenter: parent.verticalCenter
		//horizontalAlignment: Text.AlignRight
		//verticalAlignment: Text.AlignVCenter
		
		property string tag: QMLExif.ET_DateTimeOriginal 
		/*
        QMLExif.ET_WhiteBalance,
        QMLExif.ET_ColorSpace,
        QMLExif.ET_DateTimeDigitized,
        QMLExif.ET_DateTimeOriginal,
        QMLExif.ET_EXIFVersion,
        QMLExif.ET_FocalLength,
        QMLExif.ET_ExposureBiasValue,
        QMLExif.ET_ExposureMode,
        QMLExif.ET_ExposureProgram,
        QMLExif.ET_ExposureTime		
		*/
		
		color: "black"
		font.pixelSize: 10
		wrapMode: Text.WordWrap
		text:exif.getTagName(tag) + ": " + exif.getTagValue(tag)
	}
	
}
