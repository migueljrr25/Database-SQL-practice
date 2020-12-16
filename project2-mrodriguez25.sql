--1
select  ch.firstname, ch.lastname
    from coaches_season as ch
        group by ch.firstname, ch.lastname
         having COUNT(DISTINCT ch.tid) = 2;

--2
select distinct p.firstname
    from teams as t, player_rs as p 
      where p.tid=t.tid
         group by p.firstname ,t.location having t.location='Denver' or t.location='Boston' order by p.firstname;

--3
select t.name,c.lastname,c.firstname,c.year 
    from teams as t, coaches_season as c ,player_rs as p
        where p.tid=t.tid and p.year=c.year and p.tid=c.tid 
            and c.tid=t.tid and  c.cid=p.ilkid;

--4
--miguel
select avg((players.h_feet * 12 + players.h_inches) * 2.54), t.name, c.year
    from players,player_rs , coaches_season c, teams t 
         where upper(c.firstname) = 'PHIL' and upper(c.lastname) = 'JACKSON' 
            and upper(c.tid) = upper(t.tid) and upper(c.tid) = upper(player_rs.tid) and 
                upper(players.ilkid) = upper(player_rs.ilkid) and c.year = player_rs.year group by c.tid, 
                t.location, t.name, c.year order by avg desc;

--5
select cs.lastname, cs.firstname
    from coaches_season as cs, player_rs as prs
    where upper(prs.tid) = upper(cs.tid) and prs.year = 2003 and cs.year = 2003
            group by cs.lastname, cs.firstname, prs.tid having count(prs.ilkid) in (select max(players.count) 
                    from (select count(distinct prs.ilkid)
                     from player_rs as prs, teams, coaches_season as cs where cs.year = 2003 and prs.year = 2003  and (upper(prs.tid) = upper(teams.tid) 
                        and upper(cs.tid) = upper(teams.tid)) group by prs.tid) players);

--6
select coaches_season.lastname, coaches_season.firstname
    from coaches_season, teams 
        where upper(coaches_season.tid) = upper(teams.tid) 
            group by coaches_season.lastname, coaches_season.firstname, coaches_season.cid 
                    having count(distinct teams.league) in (select max(teams.count) 
                    from (select count(distinct teams.league) from teams) teams) order by coaches_season.firstname;

--7
select c.year, c.lastname, c.firstname , teamN1.name, teamsN2.name 
    from  player_rs as prs, coaches_season as c, teams as teamN1, teams as teamsN2 
        where prs.ilkid=c.cid and prs.year =c.year
            and prs.tid=teamsN2.tid and c.tid != prs.tid and c.tid=teamN1.tid;

--8
select playerNum2.pts, playerNum2.lastname,  playerNum2.firstname
    from player_rs_career as playerNum1, player_rs_career as playerNum2
        where (upper(playerNum2.firstname) != 'MICHAEL' and upper(playerNum2.lastname) != 'JORDAN')
            and (upper(playerNum1.firstname) = 'MICHAEL' and upper(playerNum1.lastname) = 'JORDAN')
                and playerNum1.pts <playerNum2.pts;

--9

--10
select draft.draft_from, count(distinct draft.ilkid) 
from draft 
    group by draft.draft_from 
    order by count(distinct draft.ilkid) desc limit 1 offset 1;