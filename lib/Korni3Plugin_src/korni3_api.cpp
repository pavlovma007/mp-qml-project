#include "korni3_api.h"

//#include <QDebug>
//#include <QTextStream>
#include <QThread>

#include <iostream> // stdin stdout stderr open close
#include <sstream>
#include <thread>

//#include "my_command.h"
// #include <unistd.h> // fork

//QObject* Korni3Api::m_instance = nullptr;

using namespace std;

//Korni3Api::Korni3Api(QQuickItem* parent) : QQuickItem(parent)
//{
//    // By default, QQuickItem does not draw anything. If you subclass
//    // QQuickItem to create a visual item, you will need to uncomment the
//    // following line and re-implement updatePaintNode()
//    // setFlag(ItemHasContents, true);
//}

//Korni3Api::~Korni3Api()
//{
//    //    qDebug() << "Hello World from c++ from qml ";
//}

//QObject* Korni3Api::qmlInstance(QQmlEngine* engine, QJSEngine* scriptEngine)
//{
//    Q_UNUSED(engine);
//    Q_UNUSED(scriptEngine);

//    if (m_instance == nullptr)
//        m_instance = new Korni3Api();

//    return m_instance;
//}

// sync method
//QString Korni3Api::runCommand(const QString& commandId, const QString& command, bool isToSignal)
//{
//    int status = -1;
//    cerr << "command=" << command.toStdString() << endl;
//    stringstream* ss = new stringstream();
//    //QTextStream ss;
//    execCommand(command.toStdString(), status,
//                [this, &commandId, &isToSignal, ss](char* buf, int count) {
//                    if (isToSignal)
//                        emit this->newCommandResult(commandId, QString::fromUtf8(buf, count));
//                    else
//                        ss->write(buf, count);
//                    //                    else
//                    //                        ss << QString::fromStdString(string(buf, count));
//                });
//    //QString* s = nullptr; // ss.string();
//    //return s ? *s : "";   // ss.readAll();
//    auto s = QString::fromStdString(ss->str());
//    delete ss;
//    return s;
//}

//class T1 : public QThread
//{
//    Q_OBJECT
//signals:
//    void t1Ready(QString data);

//public:
//    QString m_c;
//    explicit T1(const QString& c) : m_c(c){};
//    void run() override
//    {
//        int status = -1;
//        stringstream* ss = new stringstream();
//        execCommand(m_c.toStdString(), status, [&ss](char* buf, int count) {
//            ss->write(buf, count);
//        });
//        emit this->t1Ready(QString::fromStdString(ss->str()));
//    };
//};

//void Korni3Api::execInBack(const QString& command, QStringList args, QString signalId)
//{
//    T1* t = new T1(command);
//    QObject::connect(t, &T1::finished, this, [t]() {
//        t->deleteLater();
//    });
//    QObject::connect(t, &T1::t1Ready, this, [this, signalId](QString data) {
//        this->newCommandResult(signalId, data);
//    });

//    t->start();
//    return;
//}

//QString Korni3Api::source() const
//{
//    return m_source;
//}

Korni3ApiProcess::Korni3ApiProcess(QObject* parent) : QProcess(parent)
{
}

void Korni3ApiProcess::start(const QString& program, const QVariantList& arguments)
{
    QStringList args;

    // convert QVariantList from QML to QStringList for QProcess

    for (int i = 0; i < arguments.length(); i++)
        args << arguments[i].toString();

    QProcess::start(program, args);
}

QByteArray Korni3ApiProcess::readAll()
{
    return QProcess::readAll();
}
