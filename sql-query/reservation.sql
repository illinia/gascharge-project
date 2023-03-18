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
) engine=InnoDB;