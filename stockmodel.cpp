#include "stockmodel.h"
#include <stockdata.h>

QHash<int,QByteArray> StockModel::sHeaderRoleNames({std::pair<int,QByteArray>(0,"Name"),
                                                    std::pair<int,QByteArray>(1,"Symbol"),
                                                    std::pair<int,QByteArray>(2,"Price"),
                                                    std::pair<int,QByteArray>(3,"High"),
                                                    std::pair<int,QByteArray>(4,"Low"),
                                                    std::pair<int,QByteArray>(5,"Change"),
                                                    std::pair<int,QByteArray>(6,"200 MA"),
                                                    std::pair<int,QByteArray>(7,"50 MA"),
                                                    std::pair<int,QByteArray>(8,"Currency")});

StockModel::StockModel(QObject * parent)
    :QAbstractTableModel(parent)
{

}

QHash<int, QByteArray> StockModel::roleNames() const
{
    return sHeaderRoleNames;
}

QVariantMap StockModel::get(int idx) const
{
  QVariantMap map;
  foreach(int k, roleNames().keys()) {
    map[roleNames().value(k)] = data(index(idx, 0), k);
  }
  return map;
}


QVariant StockModel::data(const QModelIndex &index, int role) const
{
//    Q_UNUSED(role);
//    if(role == 0)
//        return "hej";

    if(index.row() >= rowCount(index) || index.row() < 0)
        return QVariant();

    if(index.column() > columnCount(index) || index.column() < 0)
        return QVariant();

    StockData * tmp = mStockList.at(index.row());
    QVariant qv;
    qv = tmp->getValueByIndex(role);
    return qv;//QVariant::fromValue((*tmp)[index.column()]);
}

int StockModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return sHeaderRoleNames.size();
}

int StockModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return mStockList.length();
}

QVariant StockModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    Q_UNUSED(orientation);
    Q_UNUSED(role);
    return sHeaderRoleNames.value(section);
}

//QHash<int, QByteArray> StockModel::roleNames() const
//{

//}

void StockModel::addData(StockData * data)
{
    beginInsertRows(QModelIndex(),rowCount(), rowCount());
    mStockList.append(data);
    endInsertRows();
}


