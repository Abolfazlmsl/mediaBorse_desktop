#include "mytcpsocket.h"

MyTcpSocket::MyTcpSocket(QObject *parent) :
    QObject(parent)
{
}

void MyTcpSocket::doConnect()
{
    socket = new QTcpSocket(this);

    connect(socket, SIGNAL(connected()),this, SLOT(connected()));
    connect(socket, SIGNAL(disconnected()),this, SLOT(disconnected()));
    connect(socket, SIGNAL(bytesWritten(qint64)),this, SLOT(bytesWritten(qint64)));
    connect(socket, SIGNAL(readyRead()),this, SLOT(readyRead()));

    qDebug() << "connecting...";

    // this is not blocking call
    socket->connectToHost("192.168.0.104", 8000);

    // we need to wait...
    if(!socket->waitForConnected(1000000000))
    {
        qDebug() << "Error: " << socket->errorString();
    }
}

void MyTcpSocket::connected()
{
    qDebug() << "connected...";

    // Hey server, tell me about you.
    // socket->write("HEAD / HTTP/1.0\r\n\r\n\r\n\r\n");
}

void MyTcpSocket::disconnected()
{
    qDebug() << "disconnected...";
}

void MyTcpSocket::bytesWritten(qint64 bytes)
{
    qDebug() << bytes << " bytes written...";
}

void MyTcpSocket::readyRead()
{

    qDebug() << "reading...";

    if (a == ""){
        a = socket->readAll();
        qDebug() << a;
    }else if (b == ""){
        b = socket->readAll();
        qDebug() << b;
    }else if (c == ""){
        c = socket->readAll();
        qDebug() << c;
    }else if (d == ""){
        d = socket->readAll();
        qDebug() << d;
    }else if (e == ""){
        e = socket->readAll();
        qDebug() << e;
    }else if (f == ""){
        f = socket->readAll();
        qDebug() << f;
    }else if (g == ""){
        g = socket->readAll();
        qDebug() << g;
    }else if (h == ""){
        h = socket->readAll();
        qDebug() << h;
    }else if (i == ""){
        i = socket->readAll();
        qDebug() << i;
    }else if (j == ""){
        j = socket->readAll();
        qDebug() << j;
    }
}
