//
// Created by 田地 on 2020/10/15.
//

#ifndef P1_DS_H
#define P1_DS_H

#include "db.h"
#include "model.h"
#include <mysqlx/xdevapi.h>

using namespace mysqlx;
using namespace model;

namespace ds {
    class ds {

    };
    void Exec(db::DB& db, std::string stmt);

    void InsertPeople(db::DB& db, const People& p);

    void InsertStreet(db::DB& db, const Street& st);

    void InsertHealthRecord(db::DB& db, const HealthRecord& hr);

    void InsertContactWith(db::DB &db, const ContactWith &cw);

    void InsertTravelRecord(db::DB &db, const TravelRecord &tr);

    template<typename... Types>
    void Insert(db::DB& db, const std::string& tableName, Types... rest);
}


#endif //P1_DS_H
