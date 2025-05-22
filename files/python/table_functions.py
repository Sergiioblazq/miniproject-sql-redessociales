import pandas as pd

def table_students(df):
    """
    This function creates a table of students with their respective details.
    It includes the following columns:
    - student_id
    - gender
    - country 
    - """

    students_df = df[['student_id','gender','age','country']]
    return students_df

def social_media(df):
    # Obtener plataformas únicas
    unique_platforms = df['platform_use'].dropna().unique()
    
    # Crear la tabla con IDs
    platform_df = pd.DataFrame({
        'platform_id': range(1, len(unique_platforms) + 1),
        'name': unique_platforms
    })

    # Eliminar el índice del DataFrame
    platform_df.reset_index(drop=True, inplace=True)

    return platform_df


def table_platform_use(df):
    """
    Creates a platform usage table with:
    - platform_id
    - student_id
    - avg_use
    - mental_score
    - addicted_score
    """
    # Generar tabla intermedia de plataformas
    platform_df = social_media(df)

    # Renombramos la columna para poder hacer el merge
    df_merged = df.merge(platform_df, left_on='platform_use', right_on='name', how='left')

    # Nos quedamos solo con las columnas necesarias
    platforms_use_df = df_merged[['platform_id', 'student_id', 'avg_use','sleep_time', 'mental_score', 'addicted_score']]

    return platforms_use_df

def marital_status_ref(df):
    """
    Creates a unique table of marital statuses with:
    - marital_id
    - status_name
    """
    # Obtener estados únicos, ordenados opcionalmente
    unique_status = df['marital_status'].dropna().unique()

    # Crear tabla sin duplicados con IDs
    marital_ref = pd.DataFrame({
        'marital_id': range(1, len(unique_status) + 1),
        'status_name': unique_status
    })

    return marital_ref.reset_index(drop=True)

def table_marital_students(df):
    """
    This function creates a table of students with their marital status.
    It includes the following columns:
    - student_id
    - marital_id
    """
    # Generar tabla intermedia de estados civiles
    marital_ref_df = marital_status_ref(df)

    # Renombramos la columna para poder hacer el merge
    df_merged = df.merge(marital_ref_df, left_on='marital_status', right_on='status_name', how='left')

    # Nos quedamos solo con las columnas necesarias
    marital_students_df = df_merged[['student_id', 'marital_id','conflicts']]

    return marital_students_df.reset_index(drop=True)

def table_academic_level(df):
    """
    This function creates a table of academic levels with:
    - academic_id
    - academic_level
    """
    # Obtener niveles académicos únicos
    unique_academic_levels = df['academic_level'].dropna().unique()

    # Crear tabla sin duplicados con IDs
    academic_ref_df = pd.DataFrame({
        'academic_id': range(1, len(unique_academic_levels) + 1),
        'academic_level': unique_academic_levels
    })

    return academic_ref_df.reset_index(drop=True)

def table_student_academic(df):
    """
    This function creates a table of students with their academic levels.
    It includes the following columns:
    - student_id
    - academic_id
    """
    # Generar tabla intermedia de niveles académicos
    academic_ref_df = table_academic_level(df)

    # Renombramos la columna para poder hacer el merge
    df_merged = df.merge(academic_ref_df, left_on='academic_level', right_on='academic_level', how='left')

    # Nos quedamos solo con las columnas necesarias
    student_academic_df = df_merged[['student_id', 'academic_id','affects']]

    return student_academic_df.reset_index(drop=True)