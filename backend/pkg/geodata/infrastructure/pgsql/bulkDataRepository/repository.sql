-- name: ClearDocumentIndex :exec
DELETE
FROM document_index;

-- name: CreateDocumentIndexBuilding :exec
WITH new_docs AS (
    INSERT INTO document_index SELECT FROM building
        RETURNING id AS doc_id),
     numbered_buildings AS (SELECT id, ROW_NUMBER() OVER () AS row_num
                            FROM building),
     numbered_docs AS (SELECT doc_id, ROW_NUMBER() OVER () AS row_num
                       FROM new_docs)
UPDATE building
SET doc_id = nd.doc_id
FROM numbered_buildings nb
         JOIN numbered_docs nd ON nb.row_num = nd.row_num
WHERE building.id = nb.id;

-- name: CreateDocumentIndexLevel :exec
WITH new_docs AS (
    INSERT INTO document_index SELECT FROM level
        RETURNING id AS doc_id),
     numbered_levels AS (SELECT id, ROW_NUMBER() OVER () AS row_num
                         FROM level),
     numbered_docs AS (SELECT doc_id, ROW_NUMBER() OVER () AS row_num
                       FROM new_docs)
UPDATE level
SET doc_id = nd.doc_id
FROM numbered_levels nb
         JOIN numbered_docs nd ON nb.row_num = nd.row_num
WHERE level.id = nb.id;

-- name: CreateDocumentIndexRoom :exec
WITH new_docs AS (
    INSERT INTO document_index SELECT FROM room
        RETURNING id AS doc_id),
     numbered_rooms AS (SELECT id, ROW_NUMBER() OVER () AS row_num
                        FROM room),
     numbered_docs AS (SELECT doc_id, ROW_NUMBER() OVER () AS row_num
                       FROM new_docs)
UPDATE room
SET doc_id = nd.doc_id
FROM numbered_rooms nb
         JOIN numbered_docs nd ON nb.row_num = nd.row_num
WHERE room.id = nb.id;

-- name: GetGeojsonInformationFor :many
SELECT name,
       COALESCE(attr, '{}'::jsonb)            as attr,
       'building'                             as type,
       ST_AsGeoJSON(geom)::jsonb              as geom,
       ST_AsGeoJSON(ST_Envelope(geom))::jsonb as bound
FROM building
WHERE doc_id = ANY ($1::bigint[])
UNION
SELECT name,
       attr,
       'level'                                as type,
       ST_AsGeoJSON(geom)::jsonb              as geom,
       ST_AsGeoJSON(ST_Envelope(geom))::jsonb as bound
FROM level
WHERE doc_id = ANY ($1::bigint[])
UNION
SELECT name,
       (COALESCE(attr, '{}'::jsonb) || json_build_object('level_id', level_id) :: jsonb) as attr,
       'room'                                                     as type,
       ST_AsGeoJSON(geom)::jsonb                                  as geom,
       ST_AsGeoJSON(ST_Envelope(geom))::jsonb                     as bound
FROM room
WHERE doc_id = ANY ($1::bigint[]);

-- name: GetDocumentInformation :many
SELECT doc_id,
       name,
       COALESCE(attr, '{}'::jsonb)            as attr,
       'building'                             as type,
       ST_AsGeoJSON(st_Centroid(geom))::jsonb as centroid
FROM building
WHERE doc_id IS NOT NULL
UNION
SELECT doc_id,
       name,
       COALESCE(attr, '{}'::jsonb)            as attr,
       'level'                                as type,
       ST_AsGeoJSON(st_Centroid(geom))::jsonb as centroid
FROM level
WHERE doc_id IS NOT NULL
UNION
SELECT doc_id,
       name,
       (COALESCE(attr, '{}'::jsonb) || json_build_object('level_id', level_id) :: jsonb) as attr,
       'room'                                                                            as type,
       ST_AsGeoJSON(st_Centroid(geom))::jsonb                                            as centroid
FROM room
WHERE doc_id IS NOT NULL;