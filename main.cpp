#include "db.h"
#include "ds.h"
#include <iostream>

int main() {
    db::DB db("localhost",
            33060,
            "608",
            "Td6193798",
            "TAMU608");
    model::People p = {0, "1", "1995-03-21", "MALE", "1", "1"};
    ds::InsertPeople(db, p);

//    model::Street st = {0,
//                        "Jones Butler",
//                        1,
//                        3,
//                        13,
//                        1,
//                        1,
//                        1,
//                        1};
//    ds::InsertStreet(db, st);

    model::HealthRecord hr = {0, "2020-10-16", 36.5, 1, 1};
    ds::InsertHealthRecord(db, hr);
}