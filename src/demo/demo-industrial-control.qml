import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Controls 1.0 as Controls

import QSyncable 1.0

Item {
	ListView {
		model: JsonListModel {
			source: '{}'
			keyField: 'uuid'
		}
	
		delegate: Text {
			text: ''
		}
	}
	
}
