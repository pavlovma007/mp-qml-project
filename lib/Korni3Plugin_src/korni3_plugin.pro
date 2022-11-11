TEMPLATE = lib
TARGET = Korni3Plugin
QT += qml quick

mac {
    PKG_CONFIG = /usr/local/bin/pkg-config
    QT_CONFIG -= no-pkg-config
}

CONFIG += plugin c++11 link_pkgconfig
#PKGCONFIG += libexif

TARGET = $$qtLibraryTarget($$TARGET)
uri = Korni3Plugin

# Input
SOURCES += \
    korni3_api.cpp \
    korni3plugin_plugin.cpp \
    my_command.cpp

HEADERS += \
    korni3_api.h \
    korni3plugin_plugin.h \
    my_command.h

DISTFILES = qmldir

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir
unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}
