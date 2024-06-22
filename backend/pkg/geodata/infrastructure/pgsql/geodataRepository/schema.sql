CREATE TABLE building
(
    id   bigserial primary key,
    name varchar not null,
    attr jsonb,
    geom geometry(polygon, 4326)
);

CREATE TABLE level
(
    id   bigserial primary key,
    building_id bigint references building(id) not null,
    name varchar not null,
    attr jsonb,
    geom geometry(polygon, 4326)
);

CREATE TABLE room
(
    id   bigserial primary key,
    level_id bigint references level(id) not null,
    name varchar not null,
    attr jsonb,
    geom geometry(polygon, 4326)
);

CREATE TABLE door
(
    id bigserial primary key,
    room_a bigint references room(id) not null,
    room_b bigint references room(id) not null,
    attr jsonb,
    geom geometry(point, 4326)
);