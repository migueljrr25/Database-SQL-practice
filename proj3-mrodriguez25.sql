
-- function 1 declaration
CREATE OR REPLACE FUNCTION fibonacci (lastN INTEGER) 
RETURNS int AS $$
DECLARE
LNUM INTEGER;
BEGIN

LNUM = lastN;
    IF LNUM < 0  THEN
        RETURN -1;
    END IF;
    IF LNUM > 1000 then 
        RETURN -1;
    END IF;
    IF LNUM < 2 THEN
        RETURN LNUM;
    END IF;
    RETURN fibonacci(LNUM - 2) + fibonacci(LNUM - 1);
END;
$$ LANGUAGE plpgsql;

-- function 2 declaration

CREATE OR REPLACE FUNCTION player_height_rank (firstname VARCHAR, lastname VARCHAR) RETURNS int AS $$
DECLARE

   temporaryValue float;
   snotsetoff INTEGER;
   rRecord record;
   PlayerRanking INTEGER;
BEGIN
    PlayerRanking =0;
    snotsetoff =0;
    temporaryValue = 0.0;
    
    FOR rRecord IN SELECT  ( (players.h_inches * (2.54)) + ((players.h_feet *(12))*(2.54)) )
    as height, players.firstname, players.lastname 
    FROM players
    ORDER BY  ((players.h_feet *(12*2.54)) + (players.h_inches *2.54) )
    DESC, players.firstname, players.lastname
    
    LOOP
        IF rRecord.height = temporaryValue 
            then snotsetoff:= snotsetoff +1;
        ELSE
            PlayerRanking:= PlayerRanking + snotsetoff +1;
            snotsetoff:=0;
            temporaryValue:=rRecord.height;
        
        END IF;

        IF rRecord.lastname = $2 AND rRecord.firstname = $1 
            Then RETURN PlayerRanking;
        END IF;

    END LOOP;

RETURN -1;
END;
$$ LANGUAGE plpgsql;


-- executing the above functions
-- select * from fibonacci(20);
-- select * from player_height_rank('Reggie', 'Miller');

