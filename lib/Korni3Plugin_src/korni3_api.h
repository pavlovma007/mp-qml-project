#ifndef LIBKORNI3PLUGIN_H
#define LIBKORNI3PLUGIN_H

#include <QQuickItem>

#include <QProcess>
#include <QVariant>

class Korni3Api : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)

public:
    Korni3Api(QQuickItem* parent = 0);
    ~Korni3Api();
    static QObject* qmlInstance(QQmlEngine* engine, QJSEngine* scriptEngine);

    Q_INVOKABLE QString runCommand(const QString& commandId, const QString& command,
                                   bool isToSignal = false);

    // TODO
    //    Q_INVOKABLE void execInBack(const QString& command, QStringList args, QString signalId);

public slots:

signals:
    void sourceChanged(QString source);
    // for runCommand
    void newCommandResult(QString commandId, QString command);

private:
    QString source() const;
    void setSource(QString source);

private:
    static QObject* m_instance;
    QString m_source;
};

class Korni3ApiProcess : public QProcess
{
    Q_OBJECT

public:
    Korni3ApiProcess(QObject* parent = 0);
    Q_INVOKABLE void start(const QString& program, const QVariantList& arguments);
    Q_INVOKABLE QByteArray readAll();
};
#endif // LIBKORNI3PLUGIN_H
