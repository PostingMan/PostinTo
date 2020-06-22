#include <QApplication>
#include <QtQml>
#include <FelgoApplication>
#include <QQmlApplicationEngine>

#include "c++/backend.h"
#include "c++/KeyFilter.h"

int main(int argc, char *argv[]){
    
    QApplication app(argc, argv);
    FelgoApplication felgo;

    felgo.setPreservePlatformFonts(true);

    QQmlApplicationEngine engine;
    felgo.initialize(&engine);

    felgo.setLicenseKey(PRODUCT_LICENSE_KEY);
    felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));


    /* the object will be available in QML with name "backend" */
    Backend backend;
    engine.rootContext()->setContextProperty("backend", &backend);
    engine.rootContext()->setContextProperty("keyFilter", KeyFilter::GetInstance());
    backend.init();
    
    engine.load(QUrl(felgo.mainQmlFileName()));
    /* 添加按键过滤器 */
    QObject *object = engine.rootObjects().first();
    KeyFilter::GetInstance()->SetFilter(object);
    

    return app.exec();
}
