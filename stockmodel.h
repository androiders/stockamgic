#ifndef STOCKMODEL_H
#define STOCKMODEL_H

#include <QAbstractTableModel>
#include <QList>
#include <QHash>

class StockData; //declared in stockdata.h

class StockModel : public QAbstractTableModel
{
public:
    StockModel(QObject *parent = 0);

public slots:

    QHash<int, QByteArray> roleNames() const;

    QVariantMap get(int row) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    int columnCount(const QModelIndex &parent) const;
    int	rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant headerData(int section, Qt::Orientation orientation, int role) const;


//    QHash<int, QByteArray> roleNames() const;

    void addData(StockData * data);

signals:


private:

    static QHash<int,QByteArray> sHeaderRoleNames;

    QList<StockData*> mStockList;
};

#endif // STOCKMODEL_H
