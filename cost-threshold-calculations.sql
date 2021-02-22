CREATE TABLE #SubtreeCost(StatementSubtreeCost DECIMAL(18,2));
DECLARE @R as int
Declare @S as int
declare @T as int
declare @U as int
declare @V as bigint
declare @W as int
declare @X as int
 
;WITH XMLNAMESPACES
(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
INSERT INTO #SubtreeCost
SELECT
    CAST(n.value('(@StatementSubTreeCost)[1]', 'VARCHAR(128)') AS DECIMAL(18,2))
FROM sys.dm_exec_cached_plans AS cp
CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS qp
CROSS APPLY query_plan.nodes('/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple') AS qn(n)
WHERE n.query('.').exist('//RelOp[@PhysicalOp="Parallelism"]') = 1;
 
set @R = (select count(*) from #SubtreeCost)
select @R as item_count

set @S = (select sum(statementsubtreecost) from #subtreecost)
select @S as total_cost

select Stdev(statementsubtreecost) as StandardDeviation from #SubtreeCost

SELECT AVG(StatementSubtreeCost) AS AverageSubtreeCost
FROM #SubtreeCost;

set @T = (select AVG(StatementSubtreeCost) + STDEV(StatementSubtreeCost) from #subtreecost)
select @T as Proposed_threshold
set @U = (select @T + STDEV(StatementSubtreeCost) from #subtreecost)
select @U as Proposed_Threshold_2_Deviations

set @V = (select sum(statementsubtreecost) from #subtreecost where (statementsubtreecost > @T))
--select @V
set @W = (select count(*) from #subtreecost where (StatementSubtreeCost > @T))
set @X = (select sum(statementsubtreecost) from #subtreecost where (statementsubtreecost > @U))
select @W as Count_Above_Threshold


select ((@W*100/@R)) as Percent_parallel_by_count

select (@V*100/@S) as Percent_parallel_by_cost

select (@X*100/@S) as Percent_Parallel_by_Cost_2_Deviations




SELECT
    ((SELECT TOP 1 StatementSubtreeCost
    FROM
        (
        SELECT TOP 50 PERCENT StatementSubtreeCost
        FROM #SubtreeCost
        ORDER BY StatementSubtreeCost ASC
        ) AS A
    ORDER BY StatementSubtreeCost DESC
    )
    +
    (SELECT TOP 1 StatementSubtreeCost
    FROM
        (
        SELECT TOP 50 PERCENT StatementSubtreeCost
        FROM #SubtreeCost
        ORDER BY StatementSubtreeCost DESC
        ) AS A
    ORDER BY StatementSubtreeCost ASC))
    /2 AS MEDIAN;
 
SELECT TOP 1 StatementSubtreeCost AS MODE
FROM   #SubtreeCost
GROUP  BY StatementSubtreeCost
ORDER  BY COUNT(1) DESC;

select * from #subtreecost order by StatementSubtreeCost desc

DROP TABLE #SubtreeCost;
