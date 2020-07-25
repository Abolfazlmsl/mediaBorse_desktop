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
        QStringList stringList = a.split(",");
        std::vector<float> result1;
        bool ok;
        for(QString item : stringList)
        {
            float itemNumber = item.toFloat(&ok);
            if (ok)
            {
                result1.push_back(itemNumber);
            }

        }
        qDebug() << result1;
    }else if (b == ""){
        b = socket->readAll();
        QStringList stringList = b.split(",");
        std::vector<float> result2;
        bool ok;
        for(QString item : stringList)
        {
            float itemNumber = item.toFloat(&ok);
            if (ok)
            {
                result2.push_back(itemNumber);
            }

        }
        qDebug() << result2;
    }else if (c == ""){
        c = socket->readAll();
        QStringList stringList = c.split(",");
        std::vector<float> result3;
        bool ok;
        for(QString item : stringList)
        {
            float itemNumber = item.toFloat(&ok);
            if (ok)
            {
                result3.push_back(itemNumber);
            }

        }
        qDebug() << result3;
    }else if (d == ""){
        d = socket->readAll();
        QStringList stringList = d.split(",");
        qDebug() << stringList;
    }else if (e == ""){
        e = socket->readAll();
        QStringList stringList = e.split(",");
        qDebug() << stringList;
    }else if (f == ""){
        f = socket->readAll();
        QStringList stringList = f.split(",");
        qDebug() << stringList;
    }else if (g == ""){
        g = socket->readAll();
        QStringList stringList = d.split(",");
        qDebug() << stringList;
    }else if (h == ""){
        h = socket->readAll();
        QStringList stringList = h.split(",");
        std::vector<float> result8;
        bool ok;
        for(QString item : stringList)
        {
            float itemNumber = item.toFloat(&ok);
            if (ok)
            {
                result8.push_back(itemNumber);
            }

        }
        qDebug() << result8;
    }else if (i == ""){
        i = socket->readAll();
        QStringList stringList = i.split(",");
        std::vector<float> result9;
        bool ok;
        for(QString item : stringList)
        {
            float itemNumber = item.toFloat(&ok);
            if (ok)
            {
                result9.push_back(itemNumber);
            }

        }
        qDebug() << result9;
    }else if (j == ""){
        j = socket->readAll();
        QStringList stringList = j.split(",");
        std::vector<float> result10;
        bool ok;
        for(QString item : stringList)
        {
            float itemNumber = item.toFloat(&ok);
            if (ok)
            {
                result10.push_back(itemNumber);
            }

        }
        qDebug() << result10;
    }
}
