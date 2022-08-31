import QtQuick 2.6
import QtQuick.Layouts 1.3

//import Industrial.Controls 1.0 as Controls
//import QMLExif 1.0
//import QSyncable 1.0
//import QtMultimedia 5.12

import QtWebView 1.1

Item {

	ColumnLayout {
		spacing: 10

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


		// WEB View // https://doc.qt.io/qt-5/qml-qtwebview-webview.html
		WebView {
			width: 1000 
			height: 600 
			//title: 'html test'
			url: 'http://ya.ru/'
		}
//		Component {
//			name: "QQuickWebView"
//			defaultProperty: "data"
//			prototype: "QQuickViewController"
//			exports: ["QtWebView/WebView 1.0", "QtWebView/WebView 1.1"]
//			exportMetaObjectRevisions: [0, 1]
//			Enum {
//				name: "LoadStatus"
//				values: {
//					"LoadStartedStatus": 0,
//					"LoadStoppedStatus": 1,
//					"LoadSucceededStatus": 2,
//					"LoadFailedStatus": 3
//				}
//			}
//			Property { name: "url"; type: "QUrl" }
//			Property { name: "loading"; revision: 1; type: "bool"; isReadonly: true }
//			Property { name: "loadProgress"; type: "int"; isReadonly: true }
//			Property { name: "title"; type: "string"; isReadonly: true }
//			Property { name: "canGoBack"; type: "bool"; isReadonly: true }
//			Property { name: "canGoForward"; type: "bool"; isReadonly: true }
//			Signal {
//				name: "loadingChanged"
//				revision: 1
//				Parameter { name: "loadRequest"; type: "QQuickWebViewLoadRequest"; isPointer: true }
//			}
//			Method { name: "goBack" }
//			Method { name: "goForward" }
//			Method { name: "reload" }
//			Method { name: "stop" }
//			Method {
//				name: "loadHtml"
//				revision: 1
//				Parameter { name: "html"; type: "string" }
//				Parameter { name: "baseUrl"; type: "QUrl" }
//			}
//			Method {
//				name: "loadHtml"
//				revision: 1
//				Parameter { name: "html"; type: "string" }
//			}
//			Method {
//				name: "runJavaScript"
//				revision: 1
//				Parameter { name: "script"; type: "string" }
//				Parameter { name: "callback"; type: "QJSValue" }
//			}
//			Method {
//				name: "runJavaScript"
//				revision: 1
//				Parameter { name: "script"; type: "string" }
//			}
//		}
//		Component {
//			name: "QQuickWebViewLoadRequest"
//			prototype: "QObject"
//			exports: ["QtWebView/WebViewLoadRequest 1.1"]
//			isCreatable: false
//			exportMetaObjectRevisions: [0]
//			Property { name: "url"; type: "QUrl"; isReadonly: true }
//			Property { name: "status"; type: "QQuickWebView::LoadStatus"; isReadonly: true }
//			Property { name: "errorString"; type: "string"; isReadonly: true }
//		}
		
		


	}

}
