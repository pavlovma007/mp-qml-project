import QtQml 2.3
import QtQuick 2.6

Item {
    property string viewName: 'doc' // doc | doclist
    // ===============================================

    property string articleImage: './images/Averyanov_A_N_Sistemnoe_poznanie_mira_1985.th200.png'
    property string articleTitle: "<h1>Title Title</h1>"
    property string articleText: "<b>Hello</b> <i><font color='red'>World!</font></i>"

    property var comments: [
        {id: '10', text: 'Да полное фуфло - ваша статья', likes: 100, dislikes: 200, parent: '', date: '1 дань назад', isILike: true, isIDislike: true},
        {id: '20', text: 'сам ты козел', likes: 200, dislikes: 100, date: '1 дань назад', isILike: true, isIDislike: false},
        {id: '30', text: 'Вау! это то что я искал', likes: 1000, dislikes: 10, date: '1 дань назад',isILike: true, isIDislike: true,
            isHasReplies: true },
    ]
    property var categories: [
        {id: '10', text: 'Книги'},
        {id: '20', text: 'Образование'},
        {id: '30', text: 'Философия'},
    ]

    function loadTextFromFile(path){
        var xhr = new XMLHttpRequest;
        xhr.open("GET", path); // "../../../../../dev.sh"
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                var response = xhr.responseText;
//                print('response', response)
                // use file contents as required
                articleText = response
            }
        };
        xhr.send();
    }
    // =================================================

    Component.onCompleted: loadTextFromFile("_testdata/Korni3.html")
}
