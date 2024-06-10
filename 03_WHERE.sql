-- WHERE
-- 특정 조건에 맞는 레코드(데이터)만을 선택하는데 사용된다.
-- 방법이 다양하다.

-- 같음(=)연산자를 사용하는 WHERE
select menu_name,
       menu_price,
       orderable_status
from tbl_menu
where orderable_status = 'Y';

/*
 tbl_menu 테이블에 있는 컬럼 menu_name, menu_price, orderable_status를 조회한다.
 단, menu_price가 13000 인 데이터만 조회한다.
 */
select menu_name,
       menu_price,
       orderable_status
from tbl_menu
where menu_price = 13000;

-- select에 담지 않아도, 다른 컬럼의 속성으로 제한할 수 있다.
select menu_name,
       menu_price
from tbl_menu
where orderable_status = 'Y';

-- 같지않음(!=, <>)연산자를 사용하는 WHERE
-- ColumnA != B -> A 컬럼에 있는 내용중 B와 같지 않은 데이터만 보여주기
-- ColumnA <> B -> A 컬럼에 있는 내용중 B와 같지 않은 데이터만 보여주기
select menu_code,
       menu_name,
       orderable_status
from tbl_menu
# where orderable_status != 'Y';
where orderable_status <> 'Y';

-- 대소비교 연산자(>, >= <, <=)를 사용하는 WHERE
select menu_name,
       menu_price,
       orderable_status
from tbl_menu
where menu_price >= 20000;

/*
 AND 연산자
 AND연산자 = 둘중에 하나라도 flase면 false, 둘다 true여야만 true 반환
 true = 1, false = 0, null = 값이 없다.
 */
-- true가 되는 조건
select 1 and 1;
-- true and true = true
-- false가 되는  조건
select 1 and 0, 0 and 0, 0 and null;
-- null이 되는 조건
select 1 and null, null and null;

-- WHERE에서의 AND조건은 두 조건을 모두 충족시키는 것을 조회한다.
select menu_name,
       menu_price,
       category_code,
       orderable_status
from tbl_menu
where orderable_status = 'Y'
  and category_code = 10;

/*
 tbl_menu 테이블에 있는 menu_name, menu_price, category_code, orderable_status를 조회하는데,
 주문가능 여부가 'Y'이고 가격이 10000원 이하인 데이터 조회.
 */
select menu_name,
       menu_price,
       category_code,
       orderable_status
from tbl_menu
where orderable_status = 'Y'
  and menu_price <= 10000;

/*
 OR 연산자
 */
-- ture가 되는 조건
select 1 or 1, 0 or 1, 1 or null;
-- false가 되는 조건
select 0 or 0;
-- null이 되는 조건
select 0 or null, null or null;

-- WHERE에서의 OR조건은 두 조건중 하나라도 충족하면 조회한다.
select menu_name,
       menu_price,
       category_code,
       orderable_status
from tbl_menu
where orderable_status = 'Y'
   or category_code = 12;

/*
 AND와 OR연산의 우선순위
 - AND가 OR보다 우선순위가 높다.
 - OR의 우선순위를 높이고싶다면 ()를 이용한다.
 */
select 1 or 0 and 0; -- ()가 없다면 0 AND 0이 먼저 진행되므로 두번째 연산은 1 OR 0이 된다. -> 1
select (1 or 0) and 0; -- 1 OR 0이 먼저 연산되므로 두번째 연산은 1 AND 0이 된다. -> 0

select *
from tbl_menu
where category_code = 4
   or menu_price = 9000
    and menu_code > 10;
/*
 BETWEEN 연산자
 BETWEEN연산자 : 경계값을 포함하고 사이의 값을 포함한다.
 BETWEEN 사용법
 [column_name] between [A] and [B]
 */
select menu_name,
       menu_price,
       category_code
from tbl_menu
where menu_price between 10000 and 25000;
-- BETWEEN의 부정표현
-- NOT BETWEEN : 경계값을 포함하지 않는다.
select menu_name,
       menu_price,
       category_code
from tbl_menu
where menu_price not between 10000 and 25000;

/* LIKE 연산자
   - 특정패턴과 일치하는 형을 검색해준다.

   패턴
   - % : 0개 이상의 문자를 의미한다.
   ex) '%apple%'는 apple이라는 단어가 포함된 모든 문자열을 의미한다. -> efasefefappleadhbwedk, aaaaappleeeeee
   ex) 'apple%' -> appleajwdvjawvd, appleeeeeee
   ex) '%apple' -> ajhdajapple, aaaaaaaaaaaapple
   -> %위치에 따라 찾는 방향이 다르니 주의

   - _ : 1개의 문자를 나타낸다.
   ex) 'a_k'는 a로 시작하고 k로 끝나는 세글자 문자열을 의미한다. -> aak, abk, ack, adk ...
 */
select *
from tbl_menu
where menu_name like '민트%';

-- 메뉴에서 '갈치' 라는 단어가 들어간 메뉴를 찾아보세요
select *
from tbl_menu
where menu_name like '%갈치%';

-- LIKE 부정표현
-- NOT LIKE : 해당하는 형이 포함하지 않은 데이터만 조회
select *
from tbl_menu
where menu_name not like '%갈치%';

/*
 IN 연산자
 특정 열의 값이 지정된 목록 중 하나와 일치하는지에 확인하는데 사용된다.

 IN 사용법
 [column_name] in (4, 5, 6, ...)
 */
select menu_name,
       category_code
from tbl_menu
where category_code in (4, 5, 6);
-- category_code가 (4, 5, 6) 목록중에 해당하는 데이터만 조회.

-- IN 부정표현
-- not in : 목록에 해당하지 않는 데이터만 조회
select menu_name,
       category_code
from tbl_menu
where category_code not in (4, 5, 6);

/*
 IS NULL 연산자
 값이 null인지 아닌지를 확인하여 조회한다.
 */
select category_code,
       category_name,
       ref_category_code
from tbl_category
where ref_category_code is null;

-- IS NULL 부정표현
-- is not null : null이 아닌 데이터만 조회
select category_code,
       category_name,
       ref_category_code
from tbl_category
where ref_category_code is not null;