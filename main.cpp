#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtQml>
#include "restclient.h"
#include "oauthclient.h"
#include "stockdata.h"
#include <QVariant>
#include "stockmodel.h"
#include "yahoointerface.h"
#include "stockdatafactory.h"
#include "stockdatafilestorage.h"



int main(int argc, char *argv[])
{
    qRegisterMetaType<StockData*>();
    qmlRegisterType<StockData>("StockData",1,0,"StockData");
    QGuiApplication app(argc, argv);


    StockModel model;
    StockDataFactory fac;
    YahooInterface yi;
    StockDataFileStorage sdfs;

    fac.setModel(&model);
    QObject::connect(&yi,SIGNAL(stocksReady(QJsonArray)),&fac,SLOT(buildFromJsonArray(QJsonArray)));
    QObject::connect(&yi,SIGNAL(stockHistoricalDataReady(QString,QJsonArray)),&sdfs,SLOT(saveStockData(QString,QJsonArray)));



//    OAuthClient oc;
//    oc.getRequestToken();
//
//    RestClient rc;

//    RequestData rd;


    //rd.url = "https://query.yahooapis.com/v1/public/yql";//?q=select%20*%20from%20pm.finance%20where%20symbol%3D%22SCA-B.ST%22&format=json&diagnostics=true";


    ////    QPair<QString,QString> p("q","hej");
////    rd.requestParams.append(p);

//    rc.requestGet(rd);
//    StockData sd;
//    sd.setName("aktien");
//    sd.setCurrentPrice(123.40f);
//    sd.setChange(StockData::CHANGE_DOWN);


//    StockData sd2;
//    sd2.setName("aktien2");
//    sd2.setCurrentPrice(666.40f);
//    sd2.setChange(StockData::CHANGE_UP);


//    StockData sd3;
//    sd3.setName("aktien3");
//    sd3.setCurrentPrice(200.f);
//    sd3.setChange(StockData::NO_CHANGE);


//    model.addData(&sd);
//    model.addData(&sd2);
//    model.addData(&sd3);

//    QList<StockData*> data;
    //QVariantList dataModel;
//    data.append(&sd);
//    data.append(&sd2);

//    QVariant dataModel(&data);
//    QStringList dataModel;
//    dataModel.append("Aktien");
//    dataModel.append("Aktien2");

    QQmlApplicationEngine engine;
//    engine.rootContext()->setContextProperty("oauth",&oc);
    engine.rootContext()->setContextProperty("stockModel",  QVariant::fromValue(&model));
    engine.rootContext()->setContextProperty("yahoo",&yi);
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));


    QStringList symbols;
    symbols.append("SCA-B.ST");
//    symbols.append("ICA.ST");
    yi.getStocksBySymbol(symbols);

    return app.exec();
}

