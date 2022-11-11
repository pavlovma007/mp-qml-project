#include "korni3_api.h"

//#include <QDebug>
#include <QThread>

#include <iostream> // stdin stdout stderr open close
#include <sstream>
#include <thread>

#include "my_command.h"
// #include <unistd.h> // fork

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

QString Korni3Api::runCommand(const QString& commandId, const QString& command, bool isToSignal)
{
    int status = -1;
    stringstream ss;
    execCommand(command.toStdString(), status,
                [this, &commandId, &isToSignal, &ss](char* buf, int count) {
                    if (isToSignal)
                        emit this->newCommandResult(commandId, QString::fromUtf8(buf, count));
                    else
                        ss.str(string(buf, count));
                });
    return QString::fromStdString(ss.str());
}

void Korni3Api::execInBack(const QString& command)
{
    class T1 : public QThread
    {
    public:
        QString m_c;
        explicit T1(const QString& c) : m_c(c){};
        void run() override
        {
            int status = -1;
            execCommand(m_c.toStdString(), status, [](char*, int) {});
        };
    };
    T1* t = new T1(command);
    QObject::connect(t, &T1::finished, this, [t]() {
        t->deleteLater();
    });
    t->start();
    return;
}

QString Korni3Api::source() const
{
    return m_source;
}
