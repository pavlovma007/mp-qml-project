#ifndef LIBKORNI3PLUGIN_H
#define LIBKORNI3PLUGIN_H

#include <QQuickItem>

class Korni3Api : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)

public:
    Korni3Api(QQuickItem* parent = 0);
    ~Korni3Api();

public slots:

signals:
    void sourceChanged(QString source);

private:
    QString source() const;
    void setSource(QString source);

private:
    QString m_source;
};

#endif // LIBKORNI3PLUGIN_H
