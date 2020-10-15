//
// Created by 田地 on 2020/10/16.
//

#ifndef P1_MODEL_H
#define P1_MODEL_H

namespace model {

    struct People {
        int ID;
        string Name;
        string Birth;
        string Gender;
        string Addr;
        string Phone;
    public:
        inline string TableName() const {
            return "PEOPLE";
        }
    };

    struct Street {
        int ID;
        string Name;
        int Population;
        int RiskLevel;
        int Suspected;
        int Confirmed;
        int Recovered;
        int Deaths;
        int Activity;
    public:
        inline string TableName() const {
            return "STREET";
        }
    };

    struct HealthRecord {
        int PID;
        string Date;
        float Temp;
        int Cond;
        int Status;
    public:
        inline string TableName() const {
            return "HEALTH_RECORD";
        }
    };

    struct ContactWith {
        int PID1;
        int PID2;
        string ContactAt;
        int SID;
        int Degree;
    public:
        inline string TableName() const {
            return "CONTACT_WITH";
        }
    };

    struct TravelRecord {
        int PID;
        int SID;
        int ArrivedAt;
        int Length;
        string Purpose;
    public:
        inline string TableName() const {
            return "TRAVEL_RECORD";
        }
    };
}

#endif //P1_MODEL_H
