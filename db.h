//
// Created by 田地 on 2020/10/15.
//

#ifndef P1_DB_H
#define P1_DB_H

#include <string>
#include <utility>

using namespace std;

namespace db {
    class DB {
    private:
        string host;
        size_t port;
        string user;
        string password;
        string db;
    public:
        DB() = default;
        ~DB() = default;
        DB(string host, size_t port, string user, string password, string db):
            host(std::move(host)),
            port(port),
            user(std::move(user)),
            password(std::move(password)),
            db(std::move(db)) {}
        inline string Host() const {
            return this->host;
        }
        inline size_t Port() const {
            return this->port;
        }
        inline string User() const {
            return this->user;
        }
        inline string Password() const {
            return this->password;
        }
        inline string DBName() const {
            return this->db;
        }
    };
}

#endif //P1_SQL_H
