#include <QtCore/QCoreApplication>
#include <QtCore/QCommandLineParser>
#include <QtCore/QCommandLineOption>
#include "client.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    QCommandLineParser parser;
    parser.setApplicationDescription("QtWebSockets example: echoclient");
    parser.addHelpOption();

    QCommandLineOption dbgOption(QStringList() << "d" << "debug",
            QCoreApplication::translate("main", "Debug output [default: off]."));
    parser.addOption(dbgOption);
    parser.process(a);
    bool debug = parser.isSet(dbgOption);

    EchoClient client(QUrl(QStringLiteral("ws://192.168.0.104:8000")), debug);
    QObject::connect(&client, &EchoClient::closed, &a, &QCoreApplication::quit);

    return a.exec();
}
