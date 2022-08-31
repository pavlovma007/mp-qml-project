import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0 as Controls

import QMLExif 1.0

import QSyncable 1.0

import QtMultimedia 5.12


Item {

	// Rich text  // subset of html 4 https://doc.qt.io/qt-5/richtext-html-subset.html
	Text {
     id: mytext
     anchors.fill: parent
     textFormat: Text.RichText
     text: "<div><table border='1'><caption><h4>Test stats</h4>"+
     "</caption><tr bgcolor='#9acd32'><th/><th>Number1</th><th>Number2</th></tr> <tr><th>Line1</th>"+
        "<td> 0 </td> <td> 1 </td> </tr> <tr><th>Line2</th> <td> 0 </td> <td> 1 </td> </tr>"+
        "<tr><th>Line3</th> <td> 0 </td> <td> 0 </td> </tr> <tr><th>Line4</th> <td> 1 </td> <td> 0 </td> </tr>"+
        "<tr><th>Line5</th> <td> 1 </td> <td> 1 </td> </tr> <tr><th>Line6</th> <td> 1 </td> <td> 1 </td> </tr> </div>"
	}
	


	// WEB View
	// an object with properties, signals and methods - just like any normal Qt object
	QtObject {
		id: someObject
		// ID, under which this object will be known at WebEngineView side
		WebChannel.id: "backend"

		property string someProperty: "Break on through to the other side"

		signal someSignal(string message);

		function changeText(newText) {
			txt.text = newText;
			return "New text length: " + newText.length;
		}
	}
	Text {
		id: txt
		text: "Some text"
		onTextChanged: {
			// this signal will trigger a function at WebEngineView side (if connected)
			someObject.someSignal(text)
		}
	}
	WebEngineView {
		url: "http://ya.ru/"
		webChannel: channel
	}
	WebChannel {
		id: channel
		registeredObjects: [someObject]
	}





}
