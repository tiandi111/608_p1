//
// Created by 田地 on 2020/10/15.
//

#include "ds.h"
#include <iostream>

void ds::Exec(db::DB &db, std::string stmt) {
    try {
        Session sess(db.Host(),
                     db.Port(),
                     db.User(),
                     db.Password(),
                     db.DBName());
        sess.sql(stmt).execute();
    } catch (const mysqlx::Error &err) {
        cout<< "ERROR:" << err <<endl;
    }
}

void ds::InsertPeople(db::DB& db, const People& p) {
    Insert(db,
            p.TableName(),
            p.ID,
            p.Name,
            p.Birth,
            p.Gender,
            p.Addr,
            p.Phone);
}

void ds::InsertStreet(db::DB& db, const Street& st) {
    Insert(db,
           st.TableName(),
           st.ID,
           st.Name,
           st.Population,
           st.RiskLevel,
           st.Suspected,
           st.Confirmed,
           st.Recovered,
           st.Deaths,
           st.Activity);
}

void ds::InsertHealthRecord(db::DB &db, const HealthRecord &hr) {
    Insert(db,
            hr.TableName(),
            hr.PID,
            hr.Date,
            hr.Temp,
            hr.Cond,
            hr.Status);
}

void ds::InsertContactWith(db::DB &db, const ContactWith &cw) {
    Insert(db,
           cw.TableName(),
           cw.PID1,
           cw.PID2,
           cw.ContactAt,
           cw.SID,
           cw.Degree);
}

void ds::InsertTravelRecord(db::DB &db, const TravelRecord &tr) {
    Insert(db,
           tr.TableName(),
           tr.PID,
           tr.SID,
           tr.ArrivedAt,
           tr.Length,
           tr.Purpose);
}

template<typename... Types>
void ds::Insert(db::DB& db, const std::string& tableName, Types... rest) {
    try {
        Session sess(db.Host(),
                     db.Port(),
                     db.User(),
                     db.Password(),
                     db.DBName());
        sess.getSchema(db.DBName()).
                getTable(tableName).
                insert().
                values(rest...).
                execute();
    } catch (const mysqlx::Error &err) {
        cout<< "ERROR:" << err <<endl;
    }
}


