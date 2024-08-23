SELECT 
    s.codigo_segmento,
    s.status,
    d.segmentName AS nombre_audiencia
FROM (
    SELECT 
        explode(map_keys(segmentMembership['ups'])) AS codigo_segmento,
        segmentMembership['ups'][codigo_segmento].status AS status
    FROM 
        profile_snapshot_export_054dbcd3_1357_4643_a941_ed2f6758956e
    WHERE 
        identityMap['interbankcoddoc'][0].id = 'A484066FC3C2BAB6C31F0622869B67EECE8DDEFF1B16419A30A0FA67DD86F939' -- coddoc del usuario
) AS s
JOIN (
    SELECT
        explode(identityMap['aepsegments'].id) AS codigo_segmento,
        segmentName
    FROM
        segmentdefinition_snapshot_export_4a84e5bc_07f3_4944_bd3b_9633a9
) AS d
ON s.codigo_segmento = d.codigo_segmento
WHERE s.codigo_segmento = '4b6d29e4-5f78-407c-9699-88b4046ae6a0';