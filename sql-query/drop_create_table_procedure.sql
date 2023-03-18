# drop table reservation;
# drop table charge;
# drop table users;
#
show tables;
show databases;

call `drop tables`();


drop procedure `drop tables`;

delimiter $$
create procedure `drop tables`()
begin
    drop table if exists reservation;
    drop table if exists charge;
    drop table if exists users;
    drop table if exists token;

    create table if not exists Reservation.charge
    (
        charge_id       int auto_increment
            primary key,

        created_date    timestamp                             null,
        modified_date   timestamp                             null,
        charge_place_id varchar(255)                          not null,
        name            varchar(255)                          not null,
        current_count   int                                   not null,
        total_count     int                                   not null,
        membership      varchar(255) default 'NOT_MEMBERSHIP' null,

        constraint unique_charge_id_and_charge_place_id
            unique (charge_id, charge_place_id)
    ) engine = InnoDB;

    create table if not exists Reservation.users
    (
        user_id        int auto_increment
            primary key,
        created_date   timestamp                         null,
        modified_date  timestamp                         null,
        name           varchar(255)                      not null,
        email          varchar(255)                      not null,
        image_url      text                              null,
        email_verified varchar(255) default 'UNVERIFIED' not null,
        password       varchar(255)                      null,
        provider       varchar(255)                      not null,
        provider_id    text                              null,
        user_authority varchar(255) default 'ROLE_USER'  null
    ) engine = InnoDB;

    create table if not exists Reservation.reservation
    (
        reservation_id            int auto_increment
            primary key,
        created_date              timestamp                            null,
        modified_date             timestamp                            null,
        reservation_validation_id varchar(255)                         not null,
        reservation_time          timestamp                            not null,
        status                    varchar(255) default 'BEFORE_CHARGE' not null,
        user_id                   int                                  not null,
        charge_id                 int                                  not null,

        constraint unique_reservation_id_and_reservation_validation_id
            unique (reservation_id, reservation_validation_id),
        constraint unique_reservation_validation_id
            unique (reservation_validation_id)
    ) engine = InnoDB;

    create index user_id_idx on reservation (user_id);
    create index charge_id_idx on reservation (charge_id);

    create table if not exists Reservation.token
    (
        id            int auto_increment
            primary key,
        created_date  timestamp    null,
        modified_date timestamp    null,
        jwt_token     text         null,
        name          varchar(255) null
    ) engine = InnoDB;
end;
delimiter ;