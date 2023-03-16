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