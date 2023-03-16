# drop table reservation;
# drop table charge;
# drop table users;
#
# show tables;

call `drop tables`();


drop procedure `drop tables`;

delimiter $$
create procedure `drop tables` ()
begin
    drop table reservation;
    drop table charge;
    drop table users;

    create table if not exists Reservation.charge
(
    charge_id       int auto_increment
        primary key,

    created_date    timestamp                             null,
    modified_date   timestamp                             null,
    charge_place_id varchar(255)                          not null,
    name            varchar(255)                          not null,
    current_count   smallint                              not null,
    total_count     smallint                              not null,
    membership      varchar(255) default 'NOT_MEMBERSHIP' null,

    constraint unique_charge_id_and_charge_place_id
        unique (charge_id, charge_place_id)
) engine=InnoDB;

    create table if not exists Reservation.users
(
    user_id        int auto_increment
        primary key,
    created_date   timestamp                         null,
    modified_date  timestamp                         null,
    name           varchar(255)                      not null,
    email          varchar(255)                      not null,
    image_url       text                    null,
    email_verified varchar(255) default 'UNVERIFIED' not null,
    password       varchar(255)                      null,
    provider       varchar(255)                      not null,
    provider_id    text                    null,
    user_authority varchar(255) default 'ROLE_USER'  null,

    constraint unique_user_id_and_email
        unique (user_id, email)
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
        unique (reservation_validation_id),
    constraint foreign_user_id
        foreign key (user_id) references Reservation.users (user_id),
    constraint foreign_charge_id
        foreign key (charge_id) references Reservation.charge (charge_id)
) engine=InnoDB;
end;
delimiter ;