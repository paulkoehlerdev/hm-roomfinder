INSERT INTO level (building_id, name, attr, geom) SELECT building_id, '1.OG' as name, attr, geom  FROM level WHERE id=1;
INSERT INTO level (building_id, name, attr, geom) SELECT building_id, '2.OG' as name, attr, geom  FROM level WHERE id=1;

INSERT INTO room (level_id, name, attr, geom)
SELECT 2 as level_id, concat('F1.', substring(name FROM 4)) as name, attr, geom FROM room;

INSERT INTO room (level_id, name, attr, geom)
SELECT 3 as level_id, concat('F2.', substring(name FROM 4)) as name, attr, geom FROM room;