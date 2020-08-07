#include "client.h"
#include <QtCore/QDebug>

QT_USE_NAMESPACE

EchoClient::EchoClient(const QUrl &url, bool debug, QObject *parent) :
    QObject(parent),
    m_url(url),
    m_debug(debug)
{
    if (m_debug)
        qDebug() << "WebSocket server:" << url;
    connect(&m_webSocket, &QWebSocket::connected, this, &EchoClient::onConnected);
    connect(&m_webSocket, &QWebSocket::textMessageReceived, this, &EchoClient::onTextMessageReceived);
    m_webSocket.open(QUrl(url));
}

void EchoClient::onConnected()
{

    qDebug() << "WebSocket connected";
}

void EchoClient::onTextMessageReceived(QString message)
{
    qDebug() << message;
}

