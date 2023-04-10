select user from dual;


CREATE OR REPLACE PROCEDURE add_movie (
    p_movie_name IN VARCHAR2,
    p_movie_description IN VARCHAR2,
    p_movie_duration IN NUMBER,
    p_movie_language IN VARCHAR2,
    p_genre IN VARCHAR2,
    p_parental_rating IN VARCHAR2
)
AS BEGIN
INSERT INTO movie (
        movie_name, 
        movie_description, 
        movie_duration, 
        movie_language, 
        genre, 
        parental_rating
    )
    VALUES (
        p_movie_name, 
        p_movie_description, 
        p_movie_duration, 
        p_movie_language, 
        p_genre, 
        p_parental_rating
    );
    COMMIT;
END;
/


select * from movie;

BEGIN
    add_movie(
        'The Godfather', 
        'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.', 
        175, 
        'English', 
        'Crime Drama', 
        'R'
    );
END;
/

BEGIN
    add_movie(
        'Gods must be crazy', 
        'Unknown', 
        120, 
        'English', 
        'Drama', 
        'R'
    );
END;
/

CREATE OR REPLACE PROCEDURE update_movie(
    p_movie_id IN movie.movie_id%TYPE,
    p_movie_name IN movie.movie_name%TYPE,
    p_movie_description IN movie.movie_description%TYPE,
    p_movie_duration IN movie.movie_duration%TYPE,
    p_movie_language IN movie.movie_language%TYPE,
    p_genre IN movie.genre%TYPE,
    p_parental_rating IN movie.parental_rating%TYPE
)
IS
BEGIN
    UPDATE movie
    SET movie_name = p_movie_name,
        movie_description = p_movie_description,
        movie_duration = p_movie_duration,
        movie_language = p_movie_language,
        genre = p_genre,
        parental_rating = p_parental_rating
    WHERE movie_id = p_movie_id;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Movie updated successfully.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Movie not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating movie: ' || SQLERRM);
END;
/

BEGIN
  update_movie(19, 'New Movie Title', 'New Movie Description', 120, 'English', 'Action', 'PG-13');
END;
/

CREATE OR REPLACE PROCEDURE delete_movie (
    p_movie_id IN movie.movie_id%TYPE
) AS
BEGIN
    DELETE FROM movie WHERE movie_id = p_movie_id;
    COMMIT;
END;
/

BEGIN
    delete_movie(19);
END;
/



select * from movie;

/*
CREATE TYPE movie_obj AS OBJECT (
    movie_id NUMBER,
    title VARCHAR2(100),
    release_date DATE,
    genre VARCHAR2(100),
    director VARCHAR2(100),
    duration NUMBER,
    language VARCHAR2(50),
    country VARCHAR2(50)
);

CREATE TYPE movie_tab AS TABLE OF movie_obj;
---FUNCTIONS---

CREATE OR REPLACE FUNCTION get_all_movies RETURN SYS_REFCURSOR AS
    movies_cursor SYS_REFCURSOR;
BEGIN
    OPEN movies_cursor FOR
        SELECT * FROM MOVIE;
    RETURN movies_cursor;
END;
/

SELECT * FROM TABLE(CAST(get_all_movies() AS movie_tab));


DECLARE
    movies_cursor SYS_REFCURSOR;
    movie_record MOVIE%ROWTYPE;
BEGIN
    movies_cursor := get_all_movies();
    LOOP
        FETCH movies_cursor INTO movie_record;
        EXIT WHEN movies_cursor%NOTFOUND;
        -- Do something with the movie_record data here
        DBMS_OUTPUT.PUT_LINE(movie_record.movie_name);
    END LOOP;
    CLOSE movies_cursor;
END;
*/
