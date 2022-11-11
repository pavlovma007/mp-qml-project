#include "korni3_api.h"

#include <QDebug>

#include "my_command.h"
#include <iostream> // stdin stdout stderr open close

QObject* Korni3Api::m_instance = nullptr;

using namespace std;

Korni3Api::Korni3Api(QQuickItem* parent) : QQuickItem(parent)
{
    // By default, QQuickItem does not draw anything. If you subclass
    // QQuickItem to create a visual item, you will need to uncomment the
    // following line and re-implement updatePaintNode()
    // setFlag(ItemHasContents, true);
}

Korni3Api::~Korni3Api()
{
    //    qDebug() << "Hello World from c++ from qml ";
}

QObject* Korni3Api::qmlInstance(QQmlEngine* engine, QJSEngine* scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);

    if (m_instance == nullptr)
        m_instance = new Korni3Api();

    return m_instance;
}

bool Korni3Api::runCommand(QString commandId, QString command)
{
    cout << command.toStdString() << "  " << commandId.toStdString() << endl;
    int status = -1;
    execCommand(command.toStdString(), status, [this, &commandId](char* buf, int count) {
        cout << count << endl;
        emit this->newCommandResult(commandId, QString::fromUtf8(buf));
    });
    return true;
}

QString Korni3Api::source() const
{
    return m_source;
}
