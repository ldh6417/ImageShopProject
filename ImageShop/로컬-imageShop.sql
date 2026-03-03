-- ****************** 반드시 시스템계정에서 진행할것 ********************************
-- 1.1 사용자 정의 C## 기능을 잠금, 사용자정의
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
-- 1.2 기존사용자가 model 있다면 삭제
DROP USER shopadmin  CASCADE; 
-- 1.3 사용자 정의 이름: model, 비밀번호: model, 테이블스페이스, TEMPORARY 스페이스
CREATE USER shopadmin  IDENTIFIED BY shop1234 
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP; 
-- 1.4 권한부여
GRANT connect, RESOURCE, dba to shopadmin; 
-- 1.5 계정상태 '활성'상태로 변경, 즉시로그인이 가능 
ALTER USER shopadmin ACCOUNT UNLOCK; 

-- 등록
INSERT INTO code_group(group_code,group_name) VALUES ('a00','it');



-- ***********************************************************************************
-- 상품코드그룹테이블 
drop TABLE CODE_GROUP;

CREATE TABLE CODE_GROUP( 
    GROUP_CODE VARCHAR2(3) NOT NULL, 
    GROUP_NAME VARCHAR2(30) NOT NULL,
    USE_YN VARCHAR2(1) DEFAULT 'Y',
    REG_DATE DATE DEFAULT SYSDATE,
    UPD_DATE DATE DEFAULT SYSDATE, 
    PRIMARY KEY (GROUP_CODE) 
);

-- 리스트
SELECT group_code, group_name, use_yn, reg_date	FROM code_group	ORDER BY group_code DESC, reg_date DESC;

--삭제 
DELETE FROM code_group WHERE group_code = 'A00';
        
select * from code_group;
rollback;

-- 상품코드 상세테이블
drop table CODE_DETAIL;
CREATE TABLE CODE_DETAIL( 
    GROUP_CODE VARCHAR2(3) NOT NULL, 
    CODE_VALUE VARCHAR2(3) NOT NULL, 
    CODE_NAME VARCHAR2(30) NOT NULL, 
    SORT_SEQ NUMBER NOT NULL, 
    USE_YN VARCHAR2(1) DEFAULT 'Y', 
    REG_DATE DATE DEFAULT SYSDATE, 
    UPD_DATE DATE DEFAULT SYSDATE, 
    PRIMARY KEY(GROUP_CODE, CODE_VALUE) 
);
--코드디테일 입력하기
INSERT INTO code_detail(group_code, code_value, code_name, sort_seq) VALUES('A00', 'A01', '백앤드개발자', 0);
SELECT * FROM code_detail;

--그룹코드 코드와 이름을 가져오기
SELECT group_code AS value, group_name AS label FROM code_group WHERE use_yn = 'Y' ORDER BY group_name;

-- 코드 디테일에서 short_seq 값 가져오기 
SELECT NVL(MAX(sort_seq), 0) FROM code_detail WHERE group_code = 'A00';

SELECT group_code, code_value, code_name, sort_seq, use_yn, reg_date FROM code_detail ORDER BY group_code ASC, sort_seq ASC;

SELECT group_code, code_value, code_name, sort_seq, use_yn, reg_date FROM code_detail
WHERE group_code = 'A00' AND code_value = 'A01';

-- 회원관리테이블(인증,인가) 
drop table MEMBER;
CREATE TABLE MEMBER( 
    USER_NO NUMBER(5) NOT NULL, 
    USER_ID VARCHAR2(50) NOT NULL, 
    USER_PW VARCHAR2(100) NOT NULL, 
    USER_NAME VARCHAR2(100) NOT NULL, 
    JOB VARCHAR2(3) DEFAULT '00', 
    COIN NUMBER(10) DEFAULT 0, 
    REG_DATE DATE DEFAULT SYSDATE, 
    UPD_DATE DATE DEFAULT SYSDATE, 
    ENABLED VARCHAR2(1) DEFAULT '1', 
    PRIMARY KEY (USER_NO) 
); 

drop SEQUENCE MEMBER_SEQ;
CREATE SEQUENCE MEMBER_SEQ 
    START WITH 1 
    INCREMENT BY 1; 

-- 회원인가테이블 
drop table MEMBER_AUTH;
CREATE TABLE MEMBER_AUTH( 
    USER_NO NUMBER(5) NOT NULL, 
    AUTH VARCHAR2(50) NOT NULL 
);

ALTER TABLE MEMBER_AUTH ADD CONSTRAINT FK_MEMBER_AUTH_USER_NO 
FOREIGN KEY(USER_NO) REFERENCES MEMBER(USER_NO);

SELECT user_no, user_id, user_pw, user_name,
(SELECT code_name FROM code_detail WHERE group_code = 'A00' AND code_value = job) AS job, coin, reg_date
FROM member
ORDER BY reg_date DESC;

SELECT * FROM code_detail;

SELECT M.user_no, 
user_id, 
user_pw, 
user_name, 
job, 
coin, 
reg_date, 
upd_date, 
A.auth 
FROM member M LEFT OUTER JOIN member_auth A ON M.user_no 
= A.user_no 
WHERE M.user_no = 1;

DELETE FROM MEMBER_AUTH;
DELETE FROM MEMBER;
COMMIT;

SELECT * FROM member_auth;

update member_auth set auth = 'ROLE_ADMIN' WHERE user_no = 4;

SELECT group_code, code_value,
		code_name, sort_seq, use_yn, reg_date FROM code_detail
		WHERE group_code
		= 'A00' AND code_value = 'A04';

--자동등록 테이블 
DROP TABLE PERSISTENT_LOGINS;
CREATE TABLE PERSISTENT_LOGINS( 
    USERNAME VARCHAR2(64) NOT NULL,
    SERIES VARCHAR2(64) NOT NULL,
    TOKEN VARCHAR2(64) NOT NULL, 
    LAST_USED DATE NOT NULL, 
    PRIMARY KEY(SERIES) 
);


-- 회원 게시판테이블 
drop table board;
CREATE TABLE BOARD ( 
    BOARD_NO NUMBER NOT NULL, 
    TITLE VARCHAR2(200) NOT NULL, 
    CONTENT VARCHAR2(3000), 
    WRITER VARCHAR2(50) NOT NULL, 
    REG_DATE DATE DEFAULT SYSDATE, 
    PRIMARY KEY (BOARD_NO) 
); 
 
drop SEQUENCE BOARD_SEQ;

CREATE SEQUENCE BOARD_SEQ 
START WITH 1 
INCREMENT BY 1;

INSERT INTO board(board_no, title, content, writer) VALUES(board_seq.NEXTVAL, '타이틀테스트', '내용','eee');
SELECT * FROM board;
commit;

-- 공지사항 테이블
CREATE TABLE NOTICE( 
    NOTICE_NO NUMBER NOT NULL,
    TITLE VARCHAR2(200) NOT NULL, 
    CONTENT VARCHAR2(3000), 
    REG_DATE DATE DEFAULT SYSDATE, 
    PRIMARY KEY (NOTICE_NO) 
); 
 
CREATE SEQUENCE NOTICE_SEQ 
START WITH 1 
INCREMENT BY 1;

-- 상품테이블
CREATE TABLE ITEM( 
    ITEM_ID NUMBER(10) NOT NULL, 
    ITEM_NAME VARCHAR2(30) NOT NULL, 
    PRICE NUMBER(7) NOT NULL, 
    DESCRIPTION VARCHAR2(500) NOT NULL,
    PICTURE_URL VARCHAR2(200), 
    PREVIEW_URL VARCHAR2(200), 
    PRIMARY KEY (ITEM_ID) 
); 
 
CREATE SEQUENCE ITEM_SEQ 
START WITH 1 
INCREMENT BY 1; 


-- 코인충전테이블
CREATE TABLE CHARGE_COIN_HISTORY( 
    HISTORY_NO NUMBER(10) NOT NULL, 
    USER_NO NUMBER(10) NOT NULL, 
    AMOUNT NUMBER(10) NOT NULL, 
    REG_DATE DATE DEFAULT SYSDATE, 
    PRIMARY KEY(HISTORY_NO) 
); 
 
CREATE SEQUENCE CHARGE_COIN_HISTORY_SEQ 
START WITH 1 
INCREMENT BY 1;

-- 구매상품테이블
CREATE TABLE USER_ITEM ( 
    USER_ITEM_NO NUMBER(10) NOT NULL, 
    USER_NO NUMBER(10) NOT NULL, 
    ITEM_ID NUMBER(10) NOT NULL, 
    REG_DATE DATE DEFAULT SYSDATE, 
    PRIMARY KEY (USER_ITEM_NO) 
); 

CREATE SEQUENCE USER_ITEM_SEQ 
START WITH 1 
INCREMENT BY 1; 

-- 지급내역테이블
CREATE TABLE PAY_COIN_HISTORY( 
    HISTORY_NO NUMBER(10) NOT NULL, 
    USER_NO NUMBER(10) NOT NULL, 
    ITEM_ID NUMBER(10) NOT NULL, 
    AMOUNT NUMBER(10) NOT NULL,
    REG_DATE DATE DEFAULT SYSDATE, 
    PRIMARY KEY (HISTORY_NO) 
); 

CREATE SEQUENCE PAY_COIN_HISTORY_SEQ 
START WITH 1 
INCREMENT BY 1; 





