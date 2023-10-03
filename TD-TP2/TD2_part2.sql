-- Q2)
-- a)
SELECT nom FROM ville WHERE insee = '1293';
-- Plan d'execution
-- ----------------------------------------------------------
-- Plan hash value: 2371920588

-- ---------------------------------------------------------------------------
-- | Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT  |       |     4 |   224 |    68   (0)| 00:00:01 |
-- |*  1 |  TABLE ACCESS FULL| VILLE |     4 |   224 |    68   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------

-- Predicate Information (identified by operation id):
-- ---------------------------------------------------

--    1 - filter("INSEE"='1293')

-- Note
-- -----
--    - dynamic statistics used: dynamic sampling (level=2)


-- Statistiques
-- ----------------------------------------------------------
--          13  recursive calls
--           0  db block gets
--         277  consistent gets
--          98  physical reads
--        1584  redo size
--         560  bytes sent via SQL*Net to client
--          52  bytes received via SQL*Net from client
--           2  SQL*Net roundtrips to/from client
--           0  sorts (memory)
--           0  sorts (disk)
--           1  rows processed

-- b)
SELECT nom FROM ville WHERE insee = 1293;

-- Plan d'execution
-- ----------------------------------------------------------
-- Plan hash value: 2371920588

-- ---------------------------------------------------------------------------
-- | Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT  |       |     4 |   224 |    69   (2)| 00:00:01 |
-- |*  1 |  TABLE ACCESS FULL| VILLE |     4 |   224 |    69   (2)| 00:00:01 |
-- ---------------------------------------------------------------------------

-- Predicate Information (identified by operation id):
-- ---------------------------------------------------

--    1 - filter(TO_NUMBER("INSEE")=1293)

-- Note
-- -----
--    - dynamic statistics used: dynamic sampling (level=2)


-- Statistiques
-- ----------------------------------------------------------
--          58  recursive calls
--          10  db block gets
--          92  consistent gets
--           0  physical reads
--         960  redo size
--         554  bytes sent via SQL*Net to client
--          52  bytes received via SQL*Net from client
--           2  SQL*Net roundtrips to/from client
--           0  sorts (memory)
--           0  sorts (disk)
--           0  rows processed


-- Le même plan d'exécution est utilisé.

-- Q3)
ALTER TABLE ville ADD PRIMARY KEY(insee);


-- Q4)
-- a)
SELECT nom FROM ville WHERE insee = '1293';

-- Plan d'execution
-- ----------------------------------------------------------
-- Plan hash value: 781934248

-- --------------------------------------------------------------------------------
-- -------------

-- | Id  | Operation                   | Name          | Rows  | Bytes | Cost (%CPU
-- )| Time     |

-- --------------------------------------------------------------------------------
-- -------------

-- |   0 | SELECT STATEMENT            |               |     1 |    56 |     2   (0)| 00:0:01 |

-- |   1 |  TABLE ACCESS BY INDEX ROWID| VILLE         |     1 |    56 |     2   (0)| 00:00:01 |

-- |*  2 |   INDEX UNIQUE SCAN         | SYS_C00443099 |     1 |       |     1   (0)| 00:00:01 |

-- --------------------------------------------------------------------------------
-- -------------


-- Predicate Information (identified by operation id):
-- ---------------------------------------------------

--    2 - access("INSEE"='1293')


-- Statistiques
-- ----------------------------------------------------------
--          43  recursive calls
--           0  db block gets
--          51  consistent gets
--           1  physical reads
--           0  redo size
--         427  bytes sent via SQL*Net to client
--          41  bytes received via SQL*Net from client
--           1  SQL*Net roundtrips to/from client
--           6  sorts (memory)
--           0  sorts (disk)
--           1  rows processed

-- Le plan d'éxécution change on remarque une très grande différence, sans une clef primaire.
-- En effet il utilise un index donc il est plus facile d'accès
-- b)
SELECT nom FROM ville WHERE insee = 1293;

-- Plan d'execution
-- ----------------------------------------------------------
-- Plan hash value: 2371920588

-- ---------------------------------------------------------------------------
-- | Id  | Operation         | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT  |       |     1 |    56 |    69   (2)| 00:00:01 |
-- |*  1 |  TABLE ACCESS FULL| VILLE |     1 |    56 |    69   (2)| 00:00:01 |
-- ---------------------------------------------------------------------------

-- Predicate Information (identified by operation id):
-- ---------------------------------------------------

--    1 - filter(TO_NUMBER("INSEE")=1293)

-- Note
-- -----
--    - dynamic statistics used: dynamic sampling (level=2)


-- Statistiques
-- ----------------------------------------------------------
--          49  recursive calls
--           4  db block gets
--          97  consistent gets
--           0  physical reads
--           0  redo size
--         554  bytes sent via SQL*Net to client
--          52  bytes received via SQL*Net from client
--           2  SQL*Net roundtrips to/from client
--           0  sorts (memory)
--           0  sorts (disk)
--           0  rows processed


-- Le plan d'execution ne change pas dans ce cas, puisque l'index que l'on demande n'existe pas il décide garder le schéma par default



-- Q5)
select d.nom from departement d join ville v ON v.dep = d.id where v.insee = '1293';

-- Plan d'execution
-- ----------------------------------------------------------
-- Plan hash value: 1247517613

-- --------------------------------------------------------------------------------
-- --------------

-- | Id  | Operation                    | Name          | Rows  | Bytes | Cost (%CP
-- U)| Time     |

-- --------------------------------------------------------------------------------
-- --------------

-- |   0 | SELECT STATEMENT             |               |     1 |    39 |     3   (
-- 0)| 00:00:01 |

-- |   1 |  NESTED LOOPS                |               |     1 |    39 |     3   (
-- 0)| 00:00:01 |

-- |   2 |   TABLE ACCESS BY INDEX ROWID| VILLE         |     1 |     8 |     2   (
-- 0)| 00:00:01 |

-- |*  3 |    INDEX UNIQUE SCAN         | SYS_C00443099 |     1 |       |     1   (
-- 0)| 00:00:01 |

-- |   4 |   TABLE ACCESS BY INDEX ROWID| DEPARTEMENT   |     1 |    31 |     1   (
-- 0)| 00:00:01 |

-- |*  5 |    INDEX UNIQUE SCAN         | SYS_C00442871 |     1 |       |     0   (
-- 0)| 00:00:01 |

-- --------------------------------------------------------------------------------
-- --------------


-- Predicate Information (identified by operation id):
-- ---------------------------------------------------

--    3 - access("V"."INSEE"='1293')
--    5 - access("V"."DEP"="D"."ID")


-- Statistiques
-- ----------------------------------------------------------
--          29  recursive calls
--           6  db block gets
--          45  consistent gets
--           3  physical reads
--        1004  redo size
--         556  bytes sent via SQL*Net to client
--          52  bytes received via SQL*Net from client
--           2  SQL*Net roundtrips to/from client
--           4  sorts (memory)
--           0  sorts (disk)
--           1  rows processed


-- Q6)
select d.nom from departement d join ville v ON v.dep = d.id;


-- Plan d'execution
-- ----------------------------------------------------------
-- Plan hash value: 211249738

-- --------------------------------------------------------------------------------
-- --

-- | Id  | Operation          | Name        | Rows  | Bytes | Cost (%CPU)| Time
--  |

-- --------------------------------------------------------------------------------
-- --

-- |   0 | SELECT STATEMENT   |             | 27855 |   952K|    72   (2)| 00:00:01
--  |

-- |*  1 |  HASH JOIN         |             | 27855 |   952K|    72   (2)| 00:00:01
--  |

-- |   2 |   TABLE ACCESS FULL| DEPARTEMENT |   104 |  3224 |     3   (0)| 00:00:01
--  |

-- |   3 |   TABLE ACCESS FULL| VILLE       | 27855 |   108K|    68   (0)| 00:00:01
--  |

-- --------------------------------------------------------------------------------
-- --


-- Predicate Information (identified by operation id):
-- ---------------------------------------------------

--    1 - access("V"."DEP"="D"."ID")

-- Note
-- -----
--    - dynamic statistics used: dynamic sampling (level=2)


-- Statistiques
-- ----------------------------------------------------------
--          36  recursive calls
--           5  db block gets
--        2748  consistent gets
--          92  physical reads
--        1036  redo size
--      654200  bytes sent via SQL*Net to client
--       26892  bytes received via SQL*Net from client
--        2442  SQL*Net roundtrips to/from client
--           4  sorts (memory)
--           0  sorts (disk)
--       36601  rows processed


-- Le schéma utilisé n'est pas le même, car dans la première on filtre sur uniquement certaine ville, donc le coût est plus faible.

-- Q7)
select /*+ use_nl(departement ville) */ d.nom from departement d join ville v ON v.dep = d.id;


-- Plan d'execution
-- ----------------------------------------------------------
-- Plan hash value: 211249738

-- ----------------------------------------------------------------------------------
-- | Id  | Operation          | Name        | Rows  | Bytes | Cost (%CPU)| Time     |
-- ----------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT   |             | 27855 |   952K|    72   (2)| 00:00:01 |
-- |*  1 |  HASH JOIN         |             | 27855 |   952K|    72   (2)| 00:00:01 |
-- |   2 |   TABLE ACCESS FULL| DEPARTEMENT |   104 |  3224 |     3   (0)| 00:00:01 |
-- |   3 |   TABLE ACCESS FULL| VILLE       | 27855 |   108K|    68   (0)| 00:00:01 |
-- ----------------------------------------------------------------------------------

-- Predicate Information (identified by operation id):
-- ---------------------------------------------------

--    1 - access("V"."DEP"="D"."ID")

-- Hint Report (identified by operation id / Query Block Name / Object Alias):
-- Total hints for statement: 2 (N - Unresolved (2))
-- ---------------------------------------------------------------------------

--    1 -  SEL$58A6D7F6
--          N -  use_nl(departement ville)
--          N -  use_nl(departement ville)

-- Note
-- -----
--    - dynamic statistics used: dynamic sampling (level=2)


-- Statistiques
-- ----------------------------------------------------------
--         104  recursive calls
--           0  db block gets
--        2848  consistent gets
--          89  physical reads
--           0  redo size
--      654200  bytes sent via SQL*Net to client
--       26892  bytes received via SQL*Net from client
--        2442  SQL*Net roundtrips to/from client
--          17  sorts (memory)
--           0  sorts (disk)
--       36601  rows processed


-- Le plan d'éxecution utilisé est le même qu'à la question 6, cela veut dire que le plan d'exécution de base choisi par l'optimiseur. Le plan ne contient pas de "nested loops" donc ça veut dire qu'il ne fait pas parti des plans préférable pour cette requêtes

-- Q8)
create index idx_dep_ville on ville (dep);
-- a)
select d.nom from departement d join ville v ON v.dep = d.id where v.insee = '1293';
-- Plan d'execution
-- ----------------------------------------------------------
-- Plan hash value: 1247517613

-- ----------------------------------------------------------------------------------------------
-- | Id  | Operation                    | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
-- ----------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT             |               |     1 |    39 |     3   (0)| 00:00:01 |
-- |   1 |  NESTED LOOPS                |               |     1 |    39 |     3   (0)| 00:00:01 |
-- |   2 |   TABLE ACCESS BY INDEX ROWID| VILLE         |     1 |     8 |     2   (0)| 00:00:01 |
-- |*  3 |    INDEX UNIQUE SCAN         | SYS_C00443099 |     1 |       |     1   (0)| 00:00:01 |
-- |   4 |   TABLE ACCESS BY INDEX ROWID| DEPARTEMENT   |     1 |    31 |     1   (0)| 00:00:01 |
-- |*  5 |    INDEX UNIQUE SCAN         | SYS_C00442871 |     1 |       |     0   (0)| 00:00:01 |
-- ----------------------------------------------------------------------------------------------

-- Predicate Information (identified by operation id):
-- ---------------------------------------------------

--    3 - access("V"."INSEE"='1293')
--    5 - access("V"."DEP"="D"."ID")


-- Statistiques
-- ----------------------------------------------------------
--          69  recursive calls
--           0  db block gets
--         163  consistent gets
--           4  physical reads
--           0  redo size
--         556  bytes sent via SQL*Net to client
--          52  bytes received via SQL*Net from client
--           2  SQL*Net roundtrips to/from client
--          12  sorts (memory)
--           0  sorts (disk)
--           1  rows processed

-- b)
-- Plan d'execution
-- ----------------------------------------------------------
-- Plan hash value: 3151218067

-- ---------------------------------------------------------------------------------------
-- | Id  | Operation             | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
-- ---------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT      |               | 27855 |   952K|    26   (0)| 00:00:01 |
-- |*  1 |  HASH JOIN            |               | 27855 |   952K|    26   (0)| 00:00:01 |
-- |   2 |   TABLE ACCESS FULL   | DEPARTEMENT   |   104 |  3224 |     3   (0)| 00:00:01 |
-- |   3 |   INDEX FAST FULL SCAN| IDX_DEP_VILLE | 27855 |   108K|    23   (0)| 00:00:01 |
-- ---------------------------------------------------------------------------------------

-- Predicate Information (identified by operation id):
-- ---------------------------------------------------

--    1 - access("V"."DEP"="D"."ID")

-- Note
-- -----
--    - dynamic statistics used: dynamic sampling (level=2)
--    - this is an adaptive plan


-- Statistiques
-- ----------------------------------------------------------
--          20  recursive calls
--           0  db block gets
--        2613  consistent gets
--          80  physical reads
--           0  redo size
--      650624  bytes sent via SQL*Net to client
--       26892  bytes received via SQL*Net from client
--        2442  SQL*Net roundtrips to/from client
--           0  sorts (memory)
--           0  sorts (disk)
--       36601  rows processed

-- On remarque ici une grosse amélioration du coût de la requête. On passe de 73% à 26% avec l'ajout de l'index. L'index permet de donnée le bloque dans lequel se trouve la donnée se qui permet un accès plus rapide et une utilisation moins massive du CPU.

-- Q9)
select v.nom,d.nom,r.nom from ville v join departement d on d.id = v.dep join region r on d.reg = r.id;

-- Plan d'execution
-- ----------------------------------------------------------
-- Plan hash value: 424771235

-- -----------------------------------------------------------------------------------
-- | Id  | Operation           | Name        | Rows  | Bytes | Cost (%CPU)| Time     |
-- -----------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT    |             | 27855 |  3808K|    75   (2)| 00:00:01 |
-- |*  1 |  HASH JOIN          |             | 27855 |  3808K|    75   (2)| 00:00:01 |
-- |*  2 |   HASH JOIN         |             |   104 |  8736 |     6   (0)| 00:00:01 |
-- |   3 |    TABLE ACCESS FULL| REGION      |    27 |  1080 |     3   (0)| 00:00:01 |
-- |   4 |    TABLE ACCESS FULL| DEPARTEMENT |   104 |  4576 |     3   (0)| 00:00:01 |
-- |   5 |   TABLE ACCESS FULL | VILLE       | 27855 |  1523K|    68   (0)| 00:00:01 |
-- -----------------------------------------------------------------------------------

-- Predicate Information (identified by operation id):
-- ---------------------------------------------------

--    1 - access("D"."ID"="V"."DEP")
--    2 - access("D"."REG"="R"."ID")

-- Note
-- -----
--    - dynamic statistics used: dynamic sampling (level=2)
--    - this is an adaptive plan


-- Statistiques
-- ----------------------------------------------------------
--         130  recursive calls
--          17  db block gets
--        2746  consistent gets
--         100  physical reads
--        2856  redo size
--     1115643  bytes sent via SQL*Net to client
--       26892  bytes received via SQL*Net from client
--        2442  SQL*Net roundtrips to/from client
--           8  sorts (memory)
--           0  sorts (disk)
--       36601  rows processed

-- Q10)
create index idx_dep_reg on departement (reg);

-- Q11)
select v.nom,d.nom,r.nom from ville v join departement d on d.id = v.dep join region r on d.reg = r.id where r.id = 91;

-- Plan d'execution
-- ----------------------------------------------------------
-- Plan hash value: 4285023071

-- --------------------------------------------------------------------------------------------------------
-- | Id  | Operation                              | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
-- --------------------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT                       |               |  2842 |   388K|    22   (0)| 00:00:01 |
-- |   1 |  NESTED LOOPS                          |               |  2842 |   388K|    22   (0)| 00:00:01 |
-- |   2 |   NESTED LOOPS                         |               |  2842 |   388K|    22   (0)| 00:00:01 |
-- |   3 |    NESTED LOOPS                        |               |     5 |   420 |     3   (0)| 00:00:01 |
-- |   4 |     TABLE ACCESS BY INDEX ROWID        | REGION        |     1 |    40 |     2   (0)| 00:00:01 |
-- |*  5 |      INDEX UNIQUE SCAN                 | SYS_C00442870 |     1 |       |     1   (0)| 00:00:01 |
-- |   6 |     TABLE ACCESS BY INDEX ROWID BATCHED| DEPARTEMENT   |     5 |   220 |     1   (0)| 00:00:01 |
-- |*  7 |      INDEX RANGE SCAN                  | IDX_DEP_REG   |     5 |       |     0   (0)| 00:00:01 |
-- |*  8 |    INDEX RANGE SCAN                    | IDX_DEP_VILLE |   568 |       |     1   (0)| 00:00:01 |
-- |   9 |   TABLE ACCESS BY INDEX ROWID          | VILLE         |   568 | 31808 |     7   (0)| 00:00:01 |
-- --------------------------------------------------------------------------------------------------------

-- Predicate Information (identified by operation id):
-- ---------------------------------------------------

--    5 - access("R"."ID"=91)
--    7 - access("D"."REG"=91)
--    8 - access("D"."ID"="V"."DEP")

-- Note
-- -----
--    - dynamic statistics used: dynamic sampling (level=2)
--    - this is an adaptive plan


-- Statistiques
-- ----------------------------------------------------------
--         110  recursive calls
--           0  db block gets
--         470  consistent gets
--          18  physical reads
--           0  redo size
--       47645  bytes sent via SQL*Net to client
--        1174  bytes received via SQL*Net from client
--         104  SQL*Net roundtrips to/from client
--          18  sorts (memory)
--           0  sorts (disk)
--        1543  rows processed

-- On vois que le plan d'éxecution utilise beaucoup de "nested loops" ce qui permet d'optimiser le coût processeur.



-- Q12)
select v.nom from ville v where v.dep LIKE '7%'; 



-- Plan d'execution
-- ----------------------------------------------------------
-- Plan hash value: 1694568309

-- -----------------------------------------------------------------------------------------------------
-- | Id  | Operation                           | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
-- -----------------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT                    |               |  3149 |   172K|    40   (0)| 00:00:01 |
-- |   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| VILLE         |  3149 |   172K|    40   (0)| 00:00:01 |
-- |*  2 |   INDEX RANGE SCAN                  | IDX_DEP_VILLE |  3149 |       |    11   (0)| 00:00:01 |
-- -----------------------------------------------------------------------------------------------------

-- Predicate Information (identified by operation id):
-- ---------------------------------------------------

--    2 - access("V"."DEP" LIKE '7%')
--        filter("V"."DEP" LIKE '7%')

-- Note
-- -----
--    - dynamic statistics used: dynamic sampling (level=2)


-- Statistiques
-- ----------------------------------------------------------
--          49  recursive calls
--           0  db block gets
--         768  consistent gets
--          22  physical reads
--           0  redo size
--      171967  bytes sent via SQL*Net to client
--        3408  bytes received via SQL*Net from client
--         287  SQL*Net roundtrips to/from client
--           6  sorts (memory)
--           0  sorts (disk)
--        4278  rows processed

-- On voit que l'optimiseur se sert des indexes que nous avons précédemment créer, cela permet de réduire le coût, mais il effectue ensuite depuis le block de l'index un scan qui est assez couteux.

-- Q13)
-- ----------------------------------------------------------
-- Plan hash value: 3136338881

-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- | Id  | Operation                                           | Name                          | Rows  | Bytes | Cost (%CPU)| Time     | Pstart| Pstop |
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- |   0 | SELECT STATEMENT                                    |                               |   389 |   871K|  2179   (1)| 00:00:01 |       |       |
-- |   1 |  VIEW                                               | USER_TAB_COL_STATISTICS       |   389 |   871K|  2179   (1)| 00:00:01 |       |       |
-- |   2 |   UNION-ALL                                         |                               |       |       |            |          |       |       |
-- |*  3 |    COUNT STOPKEY                                    |                               |       |       |            |          |       |       |
-- |*  4 |     TABLE ACCESS CLUSTER                            | HISTGRM$                      |     1 |    12 |     2   (0)| 00:00:01 |       |       |
-- |*  5 |      INDEX UNIQUE SCAN                              | I_OBJ#_INTCOL#                |     1 |       |     1   (0)| 00:00:01 |       |       |
-- |*  6 |    COUNT STOPKEY                                    |                               |       |       |            |          |       |       |
-- |*  7 |     TABLE ACCESS CLUSTER                            | HISTGRM$                      |     1 |    12 |     2   (0)| 00:00:01 |       |       |
-- |*  8 |      INDEX UNIQUE SCAN                              | I_OBJ#_INTCOL#                |     1 |       |     1   (0)| 00:00:01 |       |       |
-- |   9 |    NESTED LOOPS                                     |                               |    81 |   182K|   430   (0)| 00:00:01 |       |       |
-- |* 10 |     TABLE ACCESS BY INDEX ROWID                     | TS$                           |     1 |    11 |     1   (0)| 00:00:01 |       |       |
-- |* 11 |      INDEX UNIQUE SCAN                              | I_TS1                         |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |  12 |     VIEW                                            |                               |    81 |   181K|   429   (0)| 00:00:01 |       |       |
-- |  13 |      VIEW                                           | VW_ORE_B7A180FF               |    81 |   105K|   267   (0)| 00:00:01 |       |       |
-- |  14 |       UNION-ALL                                     |                               |       |       |            |          |       |       |
-- |* 15 |        FILTER                                       |                               |       |       |            |          |       |       |
-- |* 16 |         HASH JOIN OUTER                             |                               |    17 |  3706 |   215   (0)| 00:00:01 |       |       |
-- |  17 |          NESTED LOOPS OUTER                         |                               |    17 |  3638 |   212   (0)| 00:00:01 |       |       |
-- |  18 |           NESTED LOOPS OUTER                        |                               |    17 |  3468 |    93   (0)| 00:00:01 |       |       |
-- |  19 |            NESTED LOOPS OUTER                       |                               |    17 |  3026 |    92   (0)| 00:00:01 |       |       |
-- |  20 |             NESTED LOOPS                            |                               |    17 |  2635 |    91   (0)| 00:00:01 |       |       |
-- |  21 |              NESTED LOOPS                           |                               |    57 |  5757 |    18   (0)| 00:00:01 |       |       |
-- |  22 |               NESTED LOOPS OUTER                    |                               |     8 |   648 |    15   (0)| 00:00:01 |       |       |
-- |* 23 |                HASH JOIN                            |                               |     8 |   608 |    13   (0)| 00:00:01 |       |       |
-- |* 24 |                 TABLE ACCESS BY INDEX ROWID BATCHED | OBJ$                          |     8 |   424 |    10   (0)| 00:00:01 |       |       |
-- |* 25 |                  INDEX RANGE SCAN                   | I_OBJ5                        |    13 |       |     5   (0)| 00:00:01 |       |       |
-- |  26 |                 INDEX FAST FULL SCAN                | I_USER2                       |   830 | 19090 |     3   (0)| 00:00:01 |       |       |
-- |  27 |                TABLE ACCESS CLUSTER                 | TAB$                          |     1 |     5 |     1   (0)| 00:00:01 |       |       |
-- |* 28 |                 INDEX UNIQUE SCAN                   | I_OBJ#                        |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |  29 |               TABLE ACCESS CLUSTER                  | COL$                          |     7 |   140 |     1   (0)| 00:00:01 |       |       |
-- |* 30 |                INDEX UNIQUE SCAN                    | I_OBJ#                        |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |* 31 |              TABLE ACCESS BY INDEX ROWID BATCHED    | HIST_HEAD$                    |     1 |    54 |     2   (0)| 00:00:01 |       |       |
-- |* 32 |               INDEX RANGE SCAN                      | I_HH_OBJ#_INTCOL#             |     1 |       |     1   (0)| 00:00:01 |       |       |
-- |  33 |             TABLE ACCESS BY INDEX ROWID             | WRI$_OPTSTAT_SYNOPSIS_HEAD$   |     1 |    23 |     1   (0)| 00:00:01 |       |       |
-- |* 34 |              INDEX UNIQUE SCAN                      | I_WRI$_OPTSTAT_SYNOPHEAD      |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |  35 |            TABLE ACCESS BY INDEX ROWID              | COLTYPE$                      |     1 |    26 |     1   (0)| 00:00:01 |       |       |
-- |* 36 |             INDEX UNIQUE SCAN                       | I_COLTYPE2                    |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |* 37 |           TABLE ACCESS BY INDEX ROWID BATCHED       | OBJ$                          |     1 |    10 |     7   (0)| 00:00:01 |       |       |
-- |* 38 |            INDEX RANGE SCAN                         | I_OBJ3                        |    48 |       |     1   (0)| 00:00:01 |       |       |
-- |  39 |          INDEX FAST FULL SCAN                       | I_USER2                       |   830 |  3320 |     3   (0)| 00:00:01 |       |       |
-- |* 40 |         TABLE ACCESS BY INDEX ROWID BATCHED         | USER_EDITIONING$              |     1 |     6 |     2   (0)| 00:00:01 |       |       |
-- |* 41 |          INDEX RANGE SCAN                           | I_USER_EDITIONING             |     2 |       |     1   (0)| 00:00:01 |       |       |
-- |* 42 |         TABLE ACCESS BY INDEX ROWID BATCHED         | USER_EDITIONING$              |     1 |     6 |     2   (0)| 00:00:01 |       |       |
-- |* 43 |          INDEX RANGE SCAN                           | I_USER_EDITIONING             |     2 |       |     1   (0)| 00:00:01 |       |       |
-- |  44 |         NESTED LOOPS                                |                               |     1 |    31 |     4   (0)| 00:00:01 |       |       |
-- |* 45 |          INDEX RANGE SCAN                           | I_OBJ4                        |     1 |    11 |     3   (0)| 00:00:01 |       |       |
-- |* 46 |          INDEX RANGE SCAN                           | I_USER2                       |     1 |    20 |     1   (0)| 00:00:01 |       |       |
-- |* 47 |        FILTER                                       |                               |       |       |            |          |       |       |
-- |  48 |         NESTED LOOPS OUTER                          |                               |     3 |   654 |    50   (0)| 00:00:01 |       |       |
-- |  49 |          NESTED LOOPS OUTER                         |                               |     3 |   642 |    47   (0)| 00:00:01 |       |       |
-- |  50 |           NESTED LOOPS OUTER                        |                               |     3 |   612 |    26   (0)| 00:00:01 |       |       |
-- |  51 |            NESTED LOOPS OUTER                       |                               |     3 |   543 |    25   (0)| 00:00:01 |       |       |
-- |  52 |             NESTED LOOPS                            |                               |     3 |   465 |    24   (0)| 00:00:01 |       |       |
-- |  53 |              NESTED LOOPS                           |                               |    11 |  1111 |    10   (0)| 00:00:01 |       |       |
-- |  54 |               NESTED LOOPS OUTER                    |                               |     2 |   162 |     9   (0)| 00:00:01 |       |       |
-- |  55 |                NESTED LOOPS                         |                               |     2 |   152 |     8   (0)| 00:00:01 |       |       |
-- |* 56 |                 TABLE ACCESS BY INDEX ROWID BATCHED | OBJ$                          |     2 |   106 |     6   (0)| 00:00:01 |       |       |
-- |* 57 |                  INDEX RANGE SCAN                   | I_OBJ5                        |     3 |       |     5   (0)| 00:00:01 |       |       |
-- |* 58 |                   TABLE ACCESS CLUSTER              | TAB$                          |     1 |    13 |     2   (0)| 00:00:01 |       |       |
-- |* 59 |                    INDEX UNIQUE SCAN                | I_OBJ#                        |     1 |       |     1   (0)| 00:00:01 |       |       |
-- |* 60 |                 INDEX RANGE SCAN                    | I_USER2                       |     1 |    23 |     1   (0)| 00:00:01 |       |       |
-- |  61 |                TABLE ACCESS CLUSTER                 | TAB$                          |     1 |     5 |     1   (0)| 00:00:01 |       |       |
-- |* 62 |                 INDEX UNIQUE SCAN                   | I_OBJ#                        |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |  63 |               TABLE ACCESS CLUSTER                  | COL$                          |     7 |   140 |     1   (0)| 00:00:01 |       |       |
-- |* 64 |                INDEX UNIQUE SCAN                    | I_OBJ#                        |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |* 65 |              TABLE ACCESS BY INDEX ROWID BATCHED    | HIST_HEAD$                    |     1 |    54 |     2   (0)| 00:00:01 |       |       |
-- |* 66 |               INDEX RANGE SCAN                      | I_HH_OBJ#_INTCOL#             |     1 |       |     1   (0)| 00:00:01 |       |       |
-- |  67 |             TABLE ACCESS BY INDEX ROWID             | COLTYPE$                      |     1 |    26 |     1   (0)| 00:00:01 |       |       |
-- |* 68 |              INDEX UNIQUE SCAN                      | I_COLTYPE2                    |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |  69 |            TABLE ACCESS BY INDEX ROWID              | WRI$_OPTSTAT_SYNOPSIS_HEAD$   |     1 |    23 |     1   (0)| 00:00:01 |       |       |
-- |* 70 |             INDEX UNIQUE SCAN                       | I_WRI$_OPTSTAT_SYNOPHEAD      |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |* 71 |           TABLE ACCESS BY INDEX ROWID BATCHED       | OBJ$                          |     1 |    10 |     7   (0)| 00:00:01 |       |       |
-- |* 72 |            INDEX RANGE SCAN                         | I_OBJ3                        |    48 |       |     1   (0)| 00:00:01 |       |       |
-- |* 73 |          INDEX RANGE SCAN                           | I_USER2                       |     1 |     4 |     1   (0)| 00:00:01 |       |       |
-- |* 74 |         TABLE ACCESS BY INDEX ROWID BATCHED         | USER_EDITIONING$              |     1 |     6 |     2   (0)| 00:00:01 |       |       |
-- |* 75 |          INDEX RANGE SCAN                           | I_USER_EDITIONING             |     2 |       |     1   (0)| 00:00:01 |       |       |
-- |* 76 |         TABLE ACCESS BY INDEX ROWID BATCHED         | USER_EDITIONING$              |     1 |     6 |     2   (0)| 00:00:01 |       |       |
-- |* 77 |          INDEX RANGE SCAN                           | I_USER_EDITIONING             |     2 |       |     1   (0)| 00:00:01 |       |       |
-- |  78 |         NESTED LOOPS                                |                               |     1 |    31 |     4   (0)| 00:00:01 |       |       |
-- |* 79 |          INDEX RANGE SCAN                           | I_OBJ4                        |     1 |    11 |     3   (0)| 00:00:01 |       |       |
-- |* 80 |          INDEX RANGE SCAN                           | I_USER2                       |     1 |    20 |     1   (0)| 00:00:01 |       |       |
-- |* 81 |    COUNT STOPKEY                                    |                               |       |       |            |          |       |       |
-- |* 82 |     TABLE ACCESS CLUSTER                            | HISTGRM$                      |     1 |    12 |     2   (0)| 00:00:01 |       |       |
-- |* 83 |      INDEX UNIQUE SCAN                              | I_OBJ#_INTCOL#                |     1 |       |     1   (0)| 00:00:01 |       |       |
-- |* 84 |    COUNT STOPKEY                                    |                               |       |       |            |          |       |       |
-- |* 85 |     TABLE ACCESS CLUSTER                            | HISTGRM$                      |     1 |    12 |     2   (0)| 00:00:01 |       |       |
-- |* 86 |      INDEX UNIQUE SCAN                              | I_OBJ#_INTCOL#                |     1 |       |     1   (0)| 00:00:01 |       |       |
-- |* 87 |    FILTER                                           |                               |       |       |            |          |       |       |
-- |* 88 |     HASH JOIN                                       |                               |   287 | 32718 |   107   (4)| 00:00:01 |       |       |
-- |  89 |      NESTED LOOPS                                   |                               |   368 | 33120 |   103   (0)| 00:00:01 |       |       |
-- |  90 |       NESTED LOOPS                                  |                               |   368 | 33120 |   103   (0)| 00:00:01 |       |       |
-- |* 91 |        HASH JOIN                                    |                               |    50 |  2000 |     3   (0)| 00:00:01 |       |       |
-- |  92 |         TABLE ACCESS FULL                           | FIXED_OBJ$                    |  1289 | 19335 |     3   (0)| 00:00:01 |       |       |
-- |* 93 |         FIXED TABLE FULL                            | X$KQFTA                       |  1289 | 32225 |     0   (0)| 00:00:01 |       |       |
-- |* 94 |        INDEX RANGE SCAN                             | I_HH_OBJ#_COL#                |     7 |       |     1   (0)| 00:00:01 |       |       |
-- |* 95 |       TABLE ACCESS BY INDEX ROWID                   | HIST_HEAD$                    |     7 |   350 |     2   (0)| 00:00:01 |       |       |
-- |* 96 |      FIXED TABLE FULL                               | X$KQFCO                       | 21230 |   497K|     3 (100)| 00:00:01 |       |       |
-- |* 97 |    COUNT STOPKEY                                    |                               |       |       |            |          |       |       |
-- |* 98 |     FIXED TABLE FIXED INDEX                         | X$KXTTSTEHS (ind:1)           |     1 |    52 |     0   (0)| 00:00:01 |       |       |
-- |* 99 |    COUNT STOPKEY                                    |                               |       |       |            |          |       |       |
-- |*100 |     FIXED TABLE FIXED INDEX                         | X$KXTTSTEHS (ind:1)           |     1 |    52 |     0   (0)| 00:00:01 |       |       |
-- |*101 |    FILTER                                           |                               |       |       |            |          |       |       |
-- | 102 |     NESTED LOOPS OUTER                              |                               |     1 |   483 |    16   (0)| 00:00:01 |       |       |
-- | 103 |      NESTED LOOPS                                   |                               |     1 |   479 |    15   (0)| 00:00:01 |       |       |
-- | 104 |       NESTED LOOPS OUTER                            |                               |     1 |   476 |    14   (0)| 00:00:01 |       |       |
-- | 105 |        NESTED LOOPS OUTER                           |                               |     1 |   467 |    12   (0)| 00:00:01 |       |       |
-- | 106 |         NESTED LOOPS OUTER                          |                               |     1 |   462 |    10   (0)| 00:00:01 |       |       |
-- | 107 |          NESTED LOOPS OUTER                         |                               |     1 |   436 |    10   (0)| 00:00:01 |       |       |
-- | 108 |           NESTED LOOPS                              |                               |     1 |   424 |     9   (0)| 00:00:01 |       |       |
-- | 109 |            NESTED LOOPS                             |                               |     1 |   394 |     8   (0)| 00:00:01 |       |       |
-- | 110 |             NESTED LOOPS                            |                               |     1 |   374 |     7   (0)| 00:00:01 |       |       |
-- | 111 |              NESTED LOOPS                           |                               |     1 |   351 |     6   (0)| 00:00:01 |       |       |
-- | 112 |               NESTED LOOPS                          |                               |     1 |   298 |     3   (0)| 00:00:01 |       |       |
-- | 113 |                MERGE JOIN CARTESIAN                 |                               |     1 |   258 |     0   (0)| 00:00:01 |       |       |
-- | 114 |                 NESTED LOOPS                        |                               |     1 |    38 |     0   (0)| 00:00:01 |       |       |
-- |*115 |                  FIXED TABLE FIXED INDEX            | X$KSPPI (ind:1)               |     1 |    31 |     0   (0)| 00:00:01 |       |       |
-- |*116 |                  FIXED TABLE FIXED INDEX            | X$KSPPCV (ind:1)              |     1 |     7 |     0   (0)| 00:00:01 |       |       |
-- | 117 |                 BUFFER SORT                         |                               |     1 |   220 |     0   (0)| 00:00:01 |       |       |
-- |*118 |                  FIXED TABLE FULL                   | X$KXTTSTECS                   |     1 |   220 |            |          |       |       |
-- | 119 |                TABLE ACCESS BY INDEX ROWID BATCHED  | OBJ$                          |     1 |    40 |     3   (0)| 00:00:01 |       |       |
-- |*120 |                 INDEX RANGE SCAN                    | I_OBJ1                        |     1 |       |     2   (0)| 00:00:01 |       |       |
-- |*121 |               TABLE ACCESS BY INDEX ROWID BATCHED   | OBJ$                          |     1 |    53 |     3   (0)| 00:00:01 |       |       |
-- |*122 |                INDEX RANGE SCAN                     | I_OBJ5                        |     1 |       |     2   (0)| 00:00:01 |       |       |
-- |*123 |              INDEX RANGE SCAN                       | I_USER2                       |     1 |    23 |     1   (0)| 00:00:01 |       |       |
-- |*124 |             TABLE ACCESS CLUSTER                    | COL$                          |     1 |    20 |     1   (0)| 00:00:01 |       |       |
-- |*125 |              INDEX UNIQUE SCAN                      | I_OBJ#                        |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |*126 |            TABLE ACCESS CLUSTER                     | TAB$                          |     1 |    30 |     1   (0)| 00:00:01 |       |       |
-- |*127 |             INDEX UNIQUE SCAN                       | I_OBJ#                        |     1 |       |     0   (0)| 00:00:01 |       |       |
-- | 128 |           TABLE ACCESS CLUSTER                      | SEG$                          |     1 |    12 |     1   (0)| 00:00:01 |       |       |
-- |*129 |            INDEX UNIQUE SCAN                        | I_FILE#_BLOCK#                |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |*130 |          INDEX RANGE SCAN                           | I_IMSVC1                      |     1 |    26 |     0   (0)| 00:00:01 |       |       |
-- |*131 |         INDEX RANGE SCAN                            | I_OBJ1                        |     1 |     5 |     2   (0)| 00:00:01 |       |       |
-- |*132 |        INDEX RANGE SCAN                             | I_OBJ1                        |     1 |     9 |     2   (0)| 00:00:01 |       |       |
-- | 133 |       TABLE ACCESS CLUSTER                          | TS$                           |     1 |     3 |     1   (0)| 00:00:01 |       |       |
-- |*134 |        INDEX UNIQUE SCAN                            | I_TS#                         |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |*135 |      INDEX RANGE SCAN                               | I_USER2                       |     1 |     4 |     1   (0)| 00:00:01 |       |       |
-- |*136 |     TABLE ACCESS BY INDEX ROWID BATCHED             | USER_EDITIONING$              |     1 |     6 |     2   (0)| 00:00:01 |       |       |
-- |*137 |      INDEX RANGE SCAN                               | I_USER_EDITIONING             |     2 |       |     1   (0)| 00:00:01 |       |       |
-- |*138 |     TABLE ACCESS BY INDEX ROWID BATCHED             | USER_EDITIONING$              |     1 |     6 |     2   (0)| 00:00:01 |       |       |
-- |*139 |      INDEX RANGE SCAN                               | I_USER_EDITIONING             |     2 |       |     1   (0)| 00:00:01 |       |       |
-- | 140 |     NESTED LOOPS                                    |                               |     1 |    31 |     4   (0)| 00:00:01 |       |       |
-- |*141 |      INDEX RANGE SCAN                               | I_OBJ4                        |     1 |    11 |     3   (0)| 00:00:01 |       |       |
-- |*142 |      INDEX RANGE SCAN                               | I_USER2                       |     1 |    20 |     1   (0)| 00:00:01 |       |       |
-- | 143 |    NESTED LOOPS                                     |                               |    20 | 44840 |  1053   (1)| 00:00:01 |       |       |
-- |*144 |     TABLE ACCESS BY INDEX ROWID                     | TS$                           |     1 |    11 |     1   (0)| 00:00:01 |       |       |
-- |*145 |      INDEX UNIQUE SCAN                              | I_TS1                         |     1 |       |     0   (0)| 00:00:01 |       |       |
-- | 146 |     VIEW                                            |                               |    20 | 44620 |  1052   (1)| 00:00:01 |       |       |
-- |*147 |      FILTER                                         |                               |       |       |            |          |       |       |
-- |*148 |       HASH JOIN RIGHT OUTER                         |                               |   268 |   102K|  1052   (1)| 00:00:01 |       |       |
-- | 149 |        INDEX FAST FULL SCAN                         | I_USER2                       |   830 |  3320 |     3   (0)| 00:00:01 |       |       |
-- |*150 |        FILTER                                       |                               |       |       |            |          |       |       |
-- | 151 |         NESTED LOOPS OUTER                          |                               |   268 |   101K|  1049   (1)| 00:00:01 |       |       |
-- |*152 |          HASH JOIN RIGHT OUTER                      |                               |   268 | 64856 |  1049   (1)| 00:00:01 |       |       |
-- | 153 |           TABLE ACCESS BY GLOBAL INDEX ROWID BATCHED| WRI$_OPTSTAT_HISTHEAD_HISTORY |     1 |    61 |     4   (0)| 00:00:01 | ROWID | ROWID |
-- |*154 |            INDEX RANGE SCAN                         | I_WRI$_OPTSTAT_HH_ST          |     1 |       |     3   (0)| 00:00:01 |       |       |
-- |*155 |           HASH JOIN OUTER                           |                               |   268 | 48508 |  1045   (1)| 00:00:01 |       |       |
-- | 156 |            NESTED LOOPS OUTER                       |                               |   268 | 45828 |   388   (2)| 00:00:01 |       |       |
-- |*157 |             HASH JOIN                               |                               |   268 | 38860 |   384   (1)| 00:00:01 |       |       |
-- | 158 |              NESTED LOOPS                           |                               |   904 | 91304 |   153   (0)| 00:00:01 |       |       |
-- | 159 |               NESTED LOOPS OUTER                    |                               |   128 | 10368 |   112   (0)| 00:00:01 |       |       |
-- |*160 |                HASH JOIN                            |                               |   128 |  9728 |    79   (0)| 00:00:01 |       |       |
-- |*161 |                 TABLE ACCESS BY INDEX ROWID BATCHED | OBJ$                          |   128 |  6784 |    76   (0)| 00:00:01 |       |       |
-- |*162 |                  INDEX RANGE SCAN                   | I_OBJ5                        |   201 |       |     5   (0)| 00:00:01 |       |       |
-- | 163 |                 INDEX FAST FULL SCAN                | I_USER2                       |   830 | 19090 |     3   (0)| 00:00:01 |       |       |
-- | 164 |                TABLE ACCESS CLUSTER                 | TAB$                          |     1 |     5 |     1   (0)| 00:00:01 |       |       |
-- |*165 |                 INDEX UNIQUE SCAN                   | I_OBJ#                        |     1 |       |     0   (0)| 00:00:01 |       |       |
-- | 166 |               TABLE ACCESS CLUSTER                  | COL$                          |     7 |   140 |     1   (0)| 00:00:01 |       |       |
-- |*167 |                INDEX UNIQUE SCAN                    | I_OBJ#                        |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |*168 |              TABLE ACCESS FULL                      | HIST_HEAD$                    | 83469 |  3586K|   231   (2)| 00:00:01 |       |       |
-- | 169 |             TABLE ACCESS BY INDEX ROWID             | COLTYPE$                      |     1 |    26 |     1   (0)| 00:00:01 |       |       |
-- |*170 |              INDEX UNIQUE SCAN                      | I_COLTYPE2                    |     1 |       |     0   (0)| 00:00:01 |       |       |
-- |*171 |            TABLE ACCESS FULL                        | OBJ$                          |  2040 | 20400 |   657   (1)| 00:00:01 |       |       |
-- |*172 |          FIXED TABLE FIXED INDEX                    | X$KSXMCOLST (ind:1)           |     1 |   146 |     0   (0)| 00:00:01 |       |       |
-- |*173 |       TABLE ACCESS CLUSTER                          | TAB$                          |     1 |    13 |     2   (0)| 00:00:01 |       |       |
-- |*174 |        INDEX UNIQUE SCAN                            | I_OBJ#                        |     1 |       |     1   (0)| 00:00:01 |       |       |
-- |*175 |       TABLE ACCESS BY INDEX ROWID BATCHED           | USER_EDITIONING$              |     1 |     6 |     2   (0)| 00:00:01 |       |       |
-- |*176 |        INDEX RANGE SCAN                             | I_USER_EDITIONING             |     2 |       |     1   (0)| 00:00:01 |       |       |
-- |*177 |       TABLE ACCESS BY INDEX ROWID BATCHED           | USER_EDITIONING$              |     1 |     6 |     2   (0)| 00:00:01 |       |       |
-- |*178 |        INDEX RANGE SCAN                             | I_USER_EDITIONING             |     2 |       |     1   (0)| 00:00:01 |       |       |
-- | 179 |       NESTED LOOPS                                  |                               |     1 |    31 |     4   (0)| 00:00:01 |       |       |
-- |*180 |        INDEX RANGE SCAN                             | I_OBJ4                        |     1 |    11 |     3   (0)| 00:00:01 |       |       |
-- |*181 |        INDEX RANGE SCAN                             | I_USER2                       |     1 |    20 |     1   (0)| 00:00:01 |       |       |
-- -----------------------------------------------------------------------------------------------------------------------------------------------------

-- Predicate Information (identified by operation id):
-- ---------------------------------------------------

--    3 - filter(ROWNUM<2)
--    4 - filter("HG"."EP_REPEAT_COUNT">0)
--    5 - access("HG"."OBJ#"=:B1 AND "HG"."INTCOL#"=:B2)
--    6 - filter(ROWNUM<2)
--    7 - filter("HG"."EP_REPEAT_COUNT">0)
--    8 - access("HG"."OBJ#"=:B1 AND "HG"."INTCOL#"=:B2)
--   10 - filter("TS"."ONLINE$"=1)
--   11 - access("TS"."NAME"='SYSAUX')
--   15 - filter(BITAND("U"."SPARE1",16)=0 OR BITAND("O"."FLAGS",1048576)=1048576 OR "O"."TYPE#"<>88 AND  NOT EXISTS (SELECT 0 FROM
--               "SYS"."USER_EDITIONING$" "UE" WHERE "UE"."USER#"=:B1 AND "TYPE#"=:B2) OR  EXISTS (SELECT 0 FROM "SYS"."USER_EDITIONING$" "UE" WHERE
--               "UE"."USER#"=:B3 AND "UE"."TYPE#"=:B4) AND (SYS_CONTEXT('userenv','current_edition_name')='ORA$BASE' AND "U"."TYPE#"<>2 OR "U"."TYPE#"=2 AND
--               "U"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')) OR  EXISTS (SELECT 0 FROM "SYS"."USER$" "U2","SYS"."OBJ$" "O2" WHERE
--               "O2"."TYPE#"=88 AND "O2"."DATAOBJ#"=:B5 AND "U2"."TYPE#"=2 AND "O2"."OWNER#"="U2"."USER#" AND
--               "U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))))
--   16 - access("OT"."OWNER#"="USER#"(+))
--   23 - access("O"."OWNER#"="U"."USER#")
--   24 - filter(BITAND("O"."FLAGS",128)=0)
--   25 - access("O"."SPARE3"=USERENV('SCHEMAID'))
--        filter("O"."TYPE#"=3 OR "O"."TYPE#"=4)
--   28 - access("O"."OBJ#"="T"."OBJ#"(+))
--   30 - access("O"."OBJ#"="C"."OBJ#")
--   31 - filter("TIMESTAMP#" IS NOT NULL)
--   32 - access("C"."OBJ#"="OBJ#" AND "C"."INTCOL#"="INTCOL#")
--   34 - access("O"."OBJ#"="HH"."BO#"(+) AND "HH"."GROUP#"(+)=0 AND "C"."INTCOL#"="HH"."INTCOL#"(+))
--   36 - access("C"."OBJ#"="AC"."OBJ#"(+) AND "C"."INTCOL#"="AC"."INTCOL#"(+))
--   37 - filter("OT"."TYPE#"(+)=13)
--   38 - access("AC"."TOID"="OT"."OID$"(+))
--   40 - filter("TYPE#"=:B1)
--   41 - access("UE"."USER#"=:B1)
--   42 - filter("UE"."TYPE#"=:B1)
--   43 - access("UE"."USER#"=:B1)
--   45 - access("O2"."DATAOBJ#"=:B1 AND "O2"."TYPE#"=88)
--   46 - access("O2"."OWNER#"="U2"."USER#" AND "U2"."TYPE#"=2 AND "U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))
--        filter("U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))
--   47 - filter(BITAND("U"."SPARE1",16)=0 OR BITAND("O"."FLAGS",1048576)=1048576 OR "O"."TYPE#"<>88 AND  NOT EXISTS (SELECT 0 FROM
--               "SYS"."USER_EDITIONING$" "UE" WHERE "UE"."USER#"=:B1 AND "TYPE#"=:B2) OR  EXISTS (SELECT 0 FROM "SYS"."USER_EDITIONING$" "UE" WHERE
--               "UE"."USER#"=:B3 AND "UE"."TYPE#"=:B4) AND (SYS_CONTEXT('userenv','current_edition_name')='ORA$BASE' AND "U"."TYPE#"<>2 OR "U"."TYPE#"=2 AND
--               "U"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')) OR  EXISTS (SELECT 0 FROM "SYS"."USER$" "U2","SYS"."OBJ$" "O2" WHERE
--               "O2"."TYPE#"=88 AND "O2"."DATAOBJ#"=:B5 AND "U2"."TYPE#"=2 AND "O2"."OWNER#"="U2"."USER#" AND
--               "U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))))
--   56 - filter(BITAND("O"."FLAGS",128)=0)
--   57 - access("O"."SPARE3"=USERENV('SCHEMAID') AND "O"."TYPE#"=2)
--        filter("O"."TYPE#"=2 AND  NOT EXISTS (SELECT 0 FROM "SYS"."TAB$" "T" WHERE "T"."OBJ#"=:B1 AND (BITAND("T"."PROPERTY",512)=512 OR
--               BITAND("T"."PROPERTY",8192)=8192 OR BITAND("T"."PROPERTY",36893488147419103232)=36893488147419103232)) AND LNNVL("O"."TYPE#"=3) AND
--               LNNVL("O"."TYPE#"=4))
--   58 - filter(BITAND("T"."PROPERTY",512)=512 OR BITAND("T"."PROPERTY",8192)=8192 OR
--               BITAND("T"."PROPERTY",36893488147419103232)=36893488147419103232)
--   59 - access("T"."OBJ#"=:B1)
--   60 - access("O"."OWNER#"="U"."USER#")
--   62 - access("O"."OBJ#"="T"."OBJ#"(+))
--   64 - access("O"."OBJ#"="C"."OBJ#")
--   65 - filter("TIMESTAMP#" IS NOT NULL)
--   66 - access("C"."OBJ#"="OBJ#" AND "C"."INTCOL#"="INTCOL#")
--   68 - access("C"."OBJ#"="AC"."OBJ#"(+) AND "C"."INTCOL#"="AC"."INTCOL#"(+))
--   70 - access("O"."OBJ#"="HH"."BO#"(+) AND "HH"."GROUP#"(+)=0 AND "C"."INTCOL#"="HH"."INTCOL#"(+))
--   71 - filter("OT"."TYPE#"(+)=13)
--   72 - access("AC"."TOID"="OT"."OID$"(+))
--   73 - access("OT"."OWNER#"="USER#"(+))
--   74 - filter("TYPE#"=:B1)
--   75 - access("UE"."USER#"=:B1)
--   76 - filter("UE"."TYPE#"=:B1)
--   77 - access("UE"."USER#"=:B1)
--   79 - access("O2"."DATAOBJ#"=:B1 AND "O2"."TYPE#"=88)
--   80 - access("O2"."OWNER#"="U2"."USER#" AND "U2"."TYPE#"=2 AND "U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))
--        filter("U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))
--   81 - filter(ROWNUM<2)
--   82 - filter("EP_REPEAT_COUNT">0)
--   83 - access("OBJ#"=:B1 AND "INTCOL#"=:B2)
--   84 - filter(ROWNUM<2)
--   85 - filter("EP_REPEAT_COUNT">0)
--   86 - access("OBJ#"=:B1 AND "INTCOL#"=:B2)
--   87 - filter(USERENV('SCHEMAID')=0)
--   88 - access("KQFCOTOB"="KQFTAOBJ" AND "INTCOL#"="KQFCOCNO")
--   91 - access("KQFTAOBJ"="FOBJ"."OBJ#" AND "KQFTAVER"="FOBJ"."TIMESTAMP"-TO_DATE(' 1991-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss'))
--   93 - filter("CON_ID"=0 OR "CON_ID"=3)
--   94 - access("OBJ#"="KQFTAOBJ")
--   95 - filter("TIMESTAMP#" IS NOT NULL)
--   96 - filter("CON_ID"=0 OR "CON_ID"=3)
--   97 - filter(ROWNUM<2)
--   98 - filter("OBJ#_KXTTST_HS"=:B1 AND "INTCOL#_KXTTST_HS"=:B2 AND "EP_REPEAT_COUNT_KXTTST_HS">0 AND ("CON_ID"=0 OR "CON_ID"=3))
--   99 - filter(ROWNUM<2)
--  100 - filter("OBJ#_KXTTST_HS"=:B1 AND "INTCOL#_KXTTST_HS"=:B2 AND "EP_REPEAT_COUNT_KXTTST_HS">0 AND ("CON_ID"=0 OR "CON_ID"=3))
--  101 - filter(BITAND("U"."SPARE1",16)=0 OR BITAND("O"."FLAGS",1048576)=1048576 OR "O"."TYPE#"<>88 AND  NOT EXISTS (SELECT 0 FROM
--               "SYS"."USER_EDITIONING$" "UE" WHERE "UE"."USER#"=:B1 AND "TYPE#"=:B2) OR  EXISTS (SELECT 0 FROM "SYS"."USER_EDITIONING$" "UE" WHERE
--               "UE"."USER#"=:B3 AND "UE"."TYPE#"=:B4) AND (SYS_CONTEXT('userenv','current_edition_name')='ORA$BASE' AND "U"."TYPE#"<>2 OR "U"."TYPE#"=2 AND
--               "U"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')) OR  EXISTS (SELECT 0 FROM "SYS"."USER$" "U2","SYS"."OBJ$" "O2" WHERE
--               "O2"."TYPE#"=88 AND "O2"."DATAOBJ#"=:B5 AND "U2"."TYPE#"=2 AND "O2"."OWNER#"="U2"."USER#" AND
--               "U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))))
--  115 - filter("KSPPINM"='_dml_monitoring_enabled' AND ("CON_ID"=0 OR "CON_ID"=3))
--  116 - filter("INDX"="INDX" AND ("CON_ID"=0 OR "CON_ID"=3))
--  118 - filter("CON_ID"=0 OR "CON_ID"=3)
--  120 - access("OBJ#_KXTTST_CS"="O"."OBJ#")
--  121 - filter(BITAND("O"."FLAGS",128)=0)
--  122 - access("O"."SPARE3"=USERENV('SCHEMAID') AND "O"."NAME"="O"."NAME")
--  123 - access("O"."OWNER#"="U"."USER#")
--  124 - filter("INTCOL#_KXTTST_CS"="C"."INTCOL#")
--  125 - access("C"."OBJ#"="O"."OBJ#")
--  126 - filter(BITAND("T"."PROPERTY",1)=0 AND BITAND("T"."PROPERTY",36893488147419103232)=0)
--  127 - access("O"."OBJ#"="T"."OBJ#")
--  129 - access("T"."TS#"="S"."TS#"(+) AND "T"."FILE#"="S"."FILE#"(+) AND "T"."BLOCK#"="S"."BLOCK#"(+))
--  130 - access("T"."OBJ#"="SVC"."OBJ#"(+) AND "SVC"."SUBPART#"(+) IS NULL)
--  131 - access("T"."BOBJ#"="CO"."OBJ#"(+))
--  132 - access("T"."DATAOBJ#"="CX"."OBJ#"(+))
--  134 - access("T"."TS#"="TS"."TS#")
--  135 - access("CX"."OWNER#"="CU"."USER#"(+))
--  136 - filter("TYPE#"=:B1)
--  137 - access("UE"."USER#"=:B1)
--  138 - filter("UE"."TYPE#"=:B1)
--  139 - access("UE"."USER#"=:B1)
--  141 - access("O2"."DATAOBJ#"=:B1 AND "O2"."TYPE#"=88)
--  142 - access("O2"."OWNER#"="U2"."USER#" AND "U2"."TYPE#"=2 AND "U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))
--        filter("U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))
--  144 - filter("TS"."ONLINE$"=1)
--  145 - access("TS"."NAME"='SYSAUX')
--  147 - filter((("O"."TYPE#"=3 OR "O"."TYPE#"=4) OR "O"."TYPE#"=2 AND  NOT EXISTS (SELECT 0 FROM "SYS"."TAB$" "T" WHERE "T"."OBJ#"=:B1 AND
--               (BITAND("T"."PROPERTY",512)=512 OR BITAND("T"."PROPERTY",8192)=8192 OR BITAND("T"."PROPERTY",36893488147419103232)=36893488147419103232)))
--               AND (BITAND("U"."SPARE1",16)=0 OR BITAND("O"."FLAGS",1048576)=1048576 OR "O"."TYPE#"<>88 AND  NOT EXISTS (SELECT 0 FROM
--               "SYS"."USER_EDITIONING$" "UE" WHERE "UE"."USER#"=:B2 AND "TYPE#"=:B3) OR  EXISTS (SELECT 0 FROM "SYS"."USER_EDITIONING$" "UE" WHERE
--               "UE"."USER#"=:B4 AND "UE"."TYPE#"=:B5) AND (SYS_CONTEXT('userenv','current_edition_name')='ORA$BASE' AND "U"."TYPE#"<>2 OR "U"."TYPE#"=2 AND
--               "U"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')) OR  EXISTS (SELECT 0 FROM "SYS"."USER$" "U2","SYS"."OBJ$" "O2" WHERE
--               "O2"."TYPE#"=88 AND "O2"."DATAOBJ#"=:B6 AND "U2"."TYPE#"=2 AND "O2"."OWNER#"="U2"."USER#" AND
--               "U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id'))))))
--  148 - access("OT"."OWNER#"="USER#"(+))
--  150 - filter("OBJN" IS NOT NULL OR "HT"."OBJ#" IS NOT NULL)
--  152 - access("C"."INTCOL#"="HT"."INTCOL#"(+) AND "O"."OBJ#"="HT"."OBJ#"(+))
--  154 - access("HT"."SYS_NC00027$"(+)=TIMESTAMP' 4000-12-01 01:00:00.000000000')
--  155 - access("AC"."TOID"="OT"."OID$"(+))
--  157 - access("C"."OBJ#"="OBJ#" AND "C"."INTCOL#"="INTCOL#")
--  160 - access("O"."OWNER#"="U"."USER#")
--  161 - filter(BITAND("O"."FLAGS",128)=0)
--  162 - access("O"."SPARE3"=USERENV('SCHEMAID'))
--  165 - access("O"."OBJ#"="T"."OBJ#"(+))
--  167 - access("O"."OBJ#"="C"."OBJ#")
--  168 - filter("TIMESTAMP#" IS NOT NULL)
--  170 - access("C"."OBJ#"="AC"."OBJ#"(+) AND "C"."INTCOL#"="AC"."INTCOL#"(+))
--  171 - filter("OT"."TYPE#"(+)=13)
--  172 - filter("C"."INTCOL#"="ICOL"(+) AND "O"."OBJ#"="OBJN"(+) AND ("CON_ID"(+)=0 OR "CON_ID"(+)=3))
--  173 - filter(BITAND("T"."PROPERTY",512)=512 OR BITAND("T"."PROPERTY",8192)=8192 OR
--               BITAND("T"."PROPERTY",36893488147419103232)=36893488147419103232)
--  174 - access("T"."OBJ#"=:B1)
--  175 - filter("TYPE#"=:B1)
--  176 - access("UE"."USER#"=:B1)
--  177 - filter("UE"."TYPE#"=:B1)
--  178 - access("UE"."USER#"=:B1)
--  180 - access("O2"."DATAOBJ#"=:B1 AND "O2"."TYPE#"=88)
--  181 - access("O2"."OWNER#"="U2"."USER#" AND "U2"."TYPE#"=2 AND "U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))
--        filter("U2"."SPARE2"=TO_NUMBER(SYS_CONTEXT('userenv','current_edition_id')))

-- Note
-- -----
--    - this is an adaptive plan


-- Statistiques
-- ----------------------------------------------------------
--        2071  recursive calls
--           0  db block gets
--        4347  consistent gets
--        1007  physical reads
--           0  redo size
--        3232  bytes sent via SQL*Net to client
--          74  bytes received via SQL*Net from client
--           4  SQL*Net roundtrips to/from client
--         378  sorts (memory)
--           0  sorts (disk)
--          43  rows processed