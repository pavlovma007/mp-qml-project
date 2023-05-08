#include "korni3plugin_plugin.h"
#include "korni3_api.h"

// part1
#include <qqml.h>

// part2
#include <QtQml>

void QMLExecPlugin::registerTypes(const char* uri)
{
    // @uri com.mycompany.qmlcomponents
    Q_ASSERT(uri == QLatin1String("Korni3Plugin"));

    //    qmlRegisterType<Korni3Api>(uri, 1, 0, "Korni3Api");
    //    qmlRegisterSingletonType<Korni3Api>(uri, 1, 0, "Korni3Api", &Korni3Api::qmlInstance);

    // Korni3ApiProcesshttp://www.xargs.com/qml/process.html
    qmlRegisterType<Korni3ApiProcess>(uri, 1, 0, "Korni3ApiProcess");

    //    Korni3ApiProcess {
    //        id: process
    //        onReadyRead: text.text = readAll();
    //    }

    //    Timer {
    //        interval: 1000
    //        repeat: true
    //        triggeredOnStart: true
    //        running: true
    //        onTriggered: process.start(/bin/cat, [ /proc/uptime ]);
    //    }
}
