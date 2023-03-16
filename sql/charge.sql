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