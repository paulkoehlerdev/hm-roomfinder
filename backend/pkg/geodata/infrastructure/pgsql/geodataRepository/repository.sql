-- name: GetBuildings :many
select id,
       name,
       attr,
       ST_AsGeoJSON(geom)::jsonb              as geom,
       ST_AsGeoJSON(ST_Envelope(geom))::jsonb as bound
FROM building;

-- name: GetLevels :many
select id,
       name,
       building_id,
       attr,
       ST_AsGeoJSON(geom)::jsonb              as geom,
       ST_AsGeoJSON(ST_Envelope(geom))::jsonb as bound
FROM level
WHERE building_id = $1;

-- name: GetRooms :many
select id,
       name,
       level_id,
       attr,
       ST_AsGeoJSON(geom)::jsonb              as geom,
       ST_AsGeoJSON(ST_Envelope(geom))::jsonb as bound
FROM room
WHERE level_id = $1;

-- name: GetDoors :many
select door.id,
       door.room_a,
       door.room_b,
       door.attr,
       ST_AsGeoJSON(door.geom)::jsonb                             as geom,
       ST_AsGeoJSON(st_buffer(ST_Envelope(door.geom), 20))::jsonb as bound
FROM door
         JOIN room as room_a on door.room_a = room_a.id
         JOIN room as room_b on door.room_b = room_b.id
WHERE room_a.level_id = $1
   OR room_b.level_id = $1;
