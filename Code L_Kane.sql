CREATE TABLE `Bond_Jan_2020` (
    `ID_CUSIP` TEXT,
    `ID_ISIN` TEXT,
    `Issuer` TEXT,
    `PARENT_COMP_NAME` TEXT,
    `CRNCY` TEXT,
    `Maturity` TEXT,
    `PX_LAST` TEXT,
    `MARKET_SECTOR_DES` TEXT,
    `ISSUER_INDUSTRY` TEXT,
    `INDUSTRY_SECTOR` TEXT,
    `Industry_Group` TEXT,
    `Industry_Subgroup` TEXT,
    `COLLAT_TYP` TEXT,
    `RTG_MOODY` TEXT,
    `RTG_SP` TEXT,
    `RTG_DBRS` TEXT,
    `RTG_FITCH` TEXT,
    `RTG_MDY_ISSUER` TEXT,
    `RTG_SP_LT_LC_ISSUER_CREDIT` TEXT,
    `RTG_DBRS_LT_ISSUER_RATING` TEXT,
    `RTG_FITCH_SEN_UNSECURED` TEXT,
    `Callable` TEXT,
    `Is_Subordinated` TEXT,
    `PRVT_PLACE` TEXT,
    `SERIES` TEXT,
    `GUARANTOR_TYPE` TEXT,
    `CNTRY_OF_INCORPORATION` TEXT,
    `CNTRY_OF_DOMICILE` TEXT,
    `Security_Type` TEXT
);


CREATE TABLE `IG_to_Rating` (
    `IG` TEXT,
    `RTG_FINAL` TEXT
);


CREATE TABLE `LT_Rating_to_IG` (
    `RTG_MOODY` TEXT,
    `RTG_SP` TEXT,
    `RTG_DBRS` TEXT,
    `RTG_FITCH` TEXT,
    `IG` TEXT
);

--Leetcode


--Step 1:
create table unique_id_cusip as
select distinct id_cusip
from bond_jan_2020
where id_cusip is not null
  and id_cusip <> ''
;


--Step 2:
create table deriv_rating as
select 
       a.*,
       b.ig as ig_moody,
       c.ig as ig_dbrs,
       d.ig as ig_sp,
       e.ig as ig_fitch,
       (
          case when b.ig is not null then 1 else 0 end
        + case when c.ig is not null then 1 else 0 end
        + case when d.ig is not null then 1 else 0 end
        + case when e.ig is not null then 1 else 0 end
       ) as rtg_num
from bond_jan_2020 a
left join lt_rating_to_ig b on a.rtg_moody = b.rtg_moody
left join lt_rating_to_ig c on a.rtg_dbrs  = c.rtg_dbrs
left join lt_rating_to_ig d on a.rtg_sp    = d.rtg_sp
left join lt_rating_to_ig e on a.rtg_fitch = e.rtg_fitch
;

--Step 3:

create table deriv_rating_1 as
select id_cusip, ig_moody as val from deriv_rating
union
select id_cusip, ig_dbrs  from deriv_rating
union 
select id_cusip, ig_sp    from deriv_rating
union
select id_cusip, ig_fitch from deriv_rating
order by id_cusip, val desc
;

--Step 4:

create table deriv_rating_2 as
select *
from deriv_rating_1
where val is not null
;

--Step 5:

create table deriv_rating_3 as
select 
      a.*,
      b.rtg_num
from deriv_rating_2 a
inner join (
    select id_cusip, count(*) as rtg_num
    from deriv_rating_2
    group by id_cusip
) b
on a.id_cusip = b.id_cusip
;

create table deriv_rating_3_1 as
select 
      a.*,
      (
        select count(*) from deriv_rating_2 b
        where b.id_cusip = a.id_cusip
      ) as rtg_num
from deriv_rating_2 a
;

--Step 6:

create table deriv_rating_4 as
select 
      a.id_cusip,
      (
        select val
        from deriv_rating_3 b
        where b.id_cusip = a.id_cusip
          and b.rtg_num >= 2
         limit 1,1
      ) as final_val
from unique_id_cusip a
where final_val is not null
union
select 
      id_cusip,
      val
from deriv_rating_3
where rtg_num = 1
;


--Step 7:

create table deriv_rating_5 as
select 
      a.*,
      b.final_val as final_ig
from deriv_rating a
left join deriv_rating_4 b
on a.id_cusip = b.id_cusip
;


--Step 8:

create table deriv_rating_6 as
select 
      a.*,
      b.rtg_final
from deriv_rating_5 a
left join ig_to_rating b
on a.final_ig = b.ig
;

--Step 9:

create table deriv_rating_report as
select 
      *,
      case
          when rtg_final is null and cntry_of_incorporation in ('US', 'CA') 
           and industry_sector = 'Government' then 'AAA'
          when rtg_final is null and cntry_of_incorporation not in ('US', 'CA') 
           and  industry_sector = 'Government' then 'A'
           else coalesce(rtg_final, 'N/A')
      end as rtg_final_adj
from deriv_rating_6
;









