#ifndef ORIENTATIONFOLLOWER_H
#define ORIENTATIONFOLLOWER_H

#include <QString>
#include <QObject>
#if defined(USE_QT_MOBILITY)
#include "qorientationsensor.h"
#endif

class OrientationFollower : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString state READ state NOTIFY orientationChanged)

public:
    explicit OrientationFollower(QObject *parent = 0);
    ~OrientationFollower();
    inline QString state() const { return m_state; }
    void update();

signals:
    void orientationChanged();

private slots:
    void onReadingChanged();

private:
    QString m_state;
#if defined(USE_QT_MOBILITY)
    QtMobility::QOrientationSensor* m_sensor;
#endif
};

#endif // ORIENTATIONFOLLOWER_H
