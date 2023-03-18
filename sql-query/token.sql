create table if not exists Reservation.token
(
    id            int auto_increment
        primary key,
    created_date  timestamp  null,
    modified_date timestamp  null,
    jwt_token     text null,
    name          varchar(255) null
);

