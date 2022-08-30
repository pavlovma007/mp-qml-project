import QtQuick 2.0
import "components"

ScrollingTextBox{
    width: 440
    height: 216
    maxChars: 2048
    textMargins: 4
    textEditBackGroundColor: "#000000"
    borderWidth: 2
    borderColor: "#9a9a9a"
    gradientLightColor: "#9a9a9a"
    gradientDarkColor: "#4e4e4e"
    headerText: "Terminal"
    headerTextFontFamily : "DejaVu Sans"
    headerTextColor: "#ffffff"
    headerTextFontSize: 15
    headerTextFontBold: true
    headerHeight: 30
    textEditFontFamily : "DejaVu Sans"
    textEditColor: "#52D017"
    textEditFontSize: 12
    textEditFontBold: false
    initialText : ""
    scrollBarBackGroundColor: "gray"
    scrollBarBorderColor: "#000000"
    scrollBarBorderWidth: 1
    scrollBarWidth: 12
    scrollBarColor: "#545454"
    scrollBarHighLight: "#5454ac"
    scrollBarUpDownArrowColor: "#000000"
    scrollBarUpDownArrowHighLight: "blue"
    showScrollBarUpDownArrow: true
}
