import QtQuick 1.1
import "components"

HeatMap{
    id: heatMap
    width: 400
    height: 200
    max: 20
    min: 0
    radius: 20
    calculateIntensity: true
    intensity: 0.0

    ListModel{
        id: data
        ListElement
        {
            x: 10
            y: 20
            count: 18
        }
        ListElement
        {
            x: 25
            y : 50
            count : 14
        }
        ListElement
        {
            x: -50
            y : -10
            count : 10
        }
        ListElement
        {
            x: 12
            y: 22
            count : 16
        }
        ListElement
        {
            x: 1
            y: 2
            count : 4
        }
    }
}
