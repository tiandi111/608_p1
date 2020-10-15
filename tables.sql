CREATE DATABASE TAMU608;

USE TAMU608;

CREATE TABLE `PEOPLE` (
    `id` BIGINT(20) UNSIGNED NOT NULL COMMENT "a unique id for people, not auto-incr becuase we assume people already have one",
    `name` VARCHAR(64) NOT NULL,
    `birth` DATE NOT NULL,
    `gender` ENUM('MALE', 'FEMALE') NOT NULL,
    `addr` VARCHAR(512) NOT NULL DEFAULT '',
    `phone` VARCHAR(16) NOT NULL DEFAULT '',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='personal information';

CREATE TABLE `ST_RISK_LEVEL` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX uniq_desc (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='street risk level information';

INSERT INTO ST_RISK_LEVEL (`description`) VALUES ('LOW'), ('MEDIUM'), ('HIGH');

CREATE TABLE `ANTI_EPI_ACT` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX uniq_desc (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='anti-epidemic activity information';

INSERT INTO ANTI_EPI_ACT (`description`) VALUES ('NO ACT'), ('SOCIAL DISTANCING'), ('NO GATHERING'), ('CLOSE');

CREATE TABLE `CONTACT_DEGREE` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX uniq_desc (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='contact degree information';

INSERT INTO CONTACT_DEGREE (`description`) VALUES ('REMOTE(>5m)'), ('CLOSE(>1.5m, <5m)'), ('VERY CLOSE(<1.5m)');

CREATE TABLE `COVID19_COND` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX uniq_desc (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='covid-19 condition';

INSERT INTO COVID19_COND (`description`)
 VALUES ('NOT TESTED'), ('NEGATIVE'), ('ASYMPTOMATIC INFECTION'), ('MILD'), ('SEVERE'), ('DEAD');

CREATE TABLE `STATUS` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX uniq_desc (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='status information';

INSERT INTO STATUS (`description`)
 VALUES ('UNKNOWN'), ('NORMAL'), ('SELF-QUARANTINING'), ('ISOLATING'), ('RESCUING');

CREATE TABLE `STREET` (
    `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(64) NOT NULL,
    `population` INT UNSIGNED NOT NULL,
    `risk_level` BIGINT(20) UNSIGNED NOT NULL DEFAULT 1,
    `suspected` INT NOT NULL DEFAULT 0 COMMENT 'number of suspected cases',
    `confirmed` INT NOT NULL DEFAULT 0 COMMENT 'number of confirmed cases',
    `recovered` INT NOT NULL DEFAULT 0 COMMENT 'number of recovered cases',
    `deaths` INT NOT NULL DEFAULT 0 COMMENT 'number of deaths',
    `activity` BIGINT(20) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'ongoing anti-epidemic activity',
    FOREIGN KEY (`risk_level`) REFERENCES ST_RISK_LEVEL (`id`),
    FOREIGN KEY (`activity`) REFERENCES ANTI_EPI_ACT (`id`),
    PRIMARY KEY (`id`),
    UNIQUE INDEX st_name(`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='street information';

CREATE TABLE `HEALTH_RECORD` (
    `pid` BIGINT(20) UNSIGNED NOT NULL,
    `date` DATE NOT NULL,
    `temp` FLOAT NOT NULL COMMENT 'body temperature',
    `condition` BIGINT(20) UNSIGNED NOT NULL,
    `status` BIGINT(20) UNSIGNED NOT NULL,
    FOREIGN KEY (`pid`) REFERENCES PEOPLE (`id`),
    FOREIGN KEY (`condition`) REFERENCES COVID19_COND (`id`),
    FOREIGN KEY (`status`) REFERENCES STATUS (`id`),
    PRIMARY KEY (`pid`, `date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='health record';

CREATE TABLE `CONTACT_WITH` (
    `pid1` BIGINT(20) UNSIGNED NOT NULL,
    `pid2` BIGINT(20) UNSIGNED NOT NULL,
    `contact_at` TIMESTAMP NOT NULL,
    `sid` BIGINT(20) UNSIGNED NOT NULL,
    `degree` BIGINT(20) UNSIGNED NOT NULL COMMENT 'degree of contact',
    FOREIGN KEY (`pid1`) REFERENCES PEOPLE (`id`),
    FOREIGN KEY (`pid2`) REFERENCES PEOPLE (`id`),
    FOREIGN KEY (`sid`) REFERENCES STREET (`id`),
    FOREIGN KEY (degree) REFERENCES CONTACT_DEGREE (`id`),
    PRIMARY KEY (`pid1`, `pid2`, `contact_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='contact history';

CREATE TABLE `TRAVEL_RECORD` (
    `pid` BIGINT(20) UNSIGNED NOT NULL,
    `sid` BIGINT(20) UNSIGNED NOT NULL,
    `arrived_at` TIMESTAMP NOT NULL,
    `length` BIGINT(20) UNSIGNED NOT NULL,
    `purpose` VARCHAR(512) NOT NULL DEFAULT 'UNKNOWN',
    FOREIGN KEY (`pid`) REFERENCES PEOPLE (`id`),
    FOREIGN KEY (`sid`) REFERENCES STREET (`id`),
    PRIMARY KEY (`pid`, `arrived_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='travel history';
