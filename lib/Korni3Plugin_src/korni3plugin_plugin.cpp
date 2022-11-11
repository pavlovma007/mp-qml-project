#include "korni3plugin_plugin.h"
#include "korni3_api.h"

#include <qqml.h>

void QMLExifPlugin::registerTypes(const char* uri)
{
    // @uri com.mycompany.qmlcomponents
    Q_ASSERT(uri == QLatin1String("Korni3Plugin"));
    qmlRegisterType<Korni3Api>(uri, 1, 0, "Korni3Api");
}
