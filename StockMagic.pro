TEMPLATE = app

QT += qml quick network
CONFIG += c++11

SOURCES += main.cpp \
    yahoointerface.cpp \
    restclient.cpp \
    oauthclient.cpp \
    stockdata.cpp \
    stockmodel.cpp \
    stockdatafactory.cpp \
    stockdatafilestorage.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    yahoointerface.h \
    restclient.h \
    oauthclient.h \
    stockdata.h \
    stockmodel.h \
    stockdatafactory.h \
    stockdatafilestorage.h

DISTFILES += \
    searchfield.qml

