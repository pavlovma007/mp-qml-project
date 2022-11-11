#include "korni3_api.h"

#include <QDebug>

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

QString Korni3Api::source() const
{
    return m_source;
}
