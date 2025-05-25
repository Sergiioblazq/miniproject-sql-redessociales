USE `student_menthal_health`

-- 1.Relacion entre el uso del social media, addicted_score y nivel de estudios

    --  Segun el addicted score, se agrupa el uso promedio que hacen de las plataformas

SELECT 
    addicted_score,
    ROUND(AVG(avg_use),2) AS avg_use
FROM 
    platform_use
GROUP BY 
    addicted_score
ORDER BY 
    addicted_score;


    --  Agrupamos por nivel academico para sacar el promedio de addicted score y avg_use segun el nivel academico.

SELECT 
    al.academic_level, 
    ROUND(AVG(p.addicted_score),2) as addicted_score,
    ROUND(AVG(p.avg_use),2) as avg_use
FROM 
    platform_use p
	join student_academic sa 
   	    on sa.student_id = p.student_id
	join academic_level al 
   	    on al.level_id = sa.level_id
GROUP BY
	al.academic_level;

-- 2. Nivel de adiccion (bajo,medio, alto) con relacion al numero de estudiantes y la media de estado mental. 
    -- Distribución por nivel de adicción y salud mental promedio

SELECT 
    CASE 
        WHEN addicted_score < 4 THEN 'Baja'
        WHEN addicted_score BETWEEN 4 AND 7 THEN 'Media'
        ELSE 'Alta'
    END AS addiction_level,
    COUNT(*) AS num_students,
    ROUND(AVG(mental_score), 2) AS avg_mental_score
FROM 
    latform_use
GROUP BY 
    addiction_level
ORDER BY 
    addiction_level;

-- 3. Relacion niveles de sueño con salud mental y nivel de addicion.

SELECT 
    sleep_group,
    COUNT(*) AS num_students,
    ROUND(AVG(avg_mental_score), 2) AS avg_mental_score,
    ROUND(AVG(avg_addicted_score), 2) AS avg_addicted_score
FROM (
    SELECT 
        sleep_time,
        mental_score AS avg_mental_score,
        addicted_score AS avg_addicted_score,
        CASE 
            WHEN sleep_time < 5 THEN 'Muy poco'
            WHEN sleep_time BETWEEN 5 AND 6 THEN 'Poco'
            WHEN sleep_time BETWEEN 7 AND 8 THEN 'Adecuado'
            ELSE 'Mucho'
        END AS sleep_group
    FROM platform_use
) AS sub
GROUP BY sleep_group
ORDER BY FIELD(sleep_group, 'Muy poco', 'Poco', 'Adecuado', 'Mucho');