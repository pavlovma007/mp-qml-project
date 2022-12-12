#include "korni3plugin_plugin.h"
#include "korni3_api.h"

// part1
#include <qqml.h>

// part2
#include <QtQml>

void QMLExifPlugin::registerTypes(const char* uri)
{
    // @uri com.mycompany.qmlcomponents
    Q_ASSERT(uri == QLatin1String("Korni3Plugin"));

    //    qmlRegisterType<Korni3Api>(uri, 1, 0, "Korni3Api");
    qmlRegisterSingletonType<Korni3Api>(uri, 1, 0, "Korni3Api", &Korni3Api::qmlInstance);

    // http://www.xargs.com/qml/process.html
    qmlRegisterType<Korni3Process>("Korni3Process", 1, 0, "Korni3Process");
}
