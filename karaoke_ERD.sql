
/* Drop Tables */

DROP TABLE announcement CASCADE CONSTRAINTS;
DROP TABLE Files CASCADE CONSTRAINTS;
DROP TABLE pointslog CASCADE CONSTRAINTS;
DROP TABLE posts CASCADE CONSTRAINTS;
DROP TABLE replies CASCADE CONSTRAINTS;
DROP TABLE userinfo CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_NEW_TABLE_userNum;
DROP SEQUENCE SEQ_pointslog_logid;
DROP SEQUENCE SEQ_userinfo_userNum;




/* Create Sequences */

CREATE SEQUENCE SEQ_NEW_TABLE_userNum INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_pointslog_logid INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_userinfo_userNum INCREMENT BY 1 START WITH 1;



/* Create Tables */

CREATE TABLE announcement
(
	annNo number NOT NULL,
	anndate date DEFAULT sysdate,
	anntitle varchar2(500),
	anncontent varchar2(1000),
	-- 회원이 로그인할 때 쓸 아이디이다. 
	userid varchar2(50) NOT NULL UNIQUE,
	PRIMARY KEY (annNo)
);


CREATE TABLE Files
(
	-- 파일들을 관리하기 위한 고유 번호
	fileno number NOT NULL,
	-- 회원이 로그인할 때 쓸 아이디이다. 
	userid varchar2(50) NOT NULL UNIQUE,
	-- 파일크기
	filesize number,
	filename varchar2(500),
	filedate date,
	PRIMARY KEY (fileno)
);


CREATE TABLE pointslog
(
	logid number NOT NULL,
	-- 회원이 로그인할 때 쓸 아이디이다. 
	userid varchar2(50) NOT NULL UNIQUE,
	theOtherId varchar2(50),
	eventdate date,
	amount number,
	-- 포인트를 상대방에게 주고 난 뒤 얼마나 남아있는지 추적하기 위한 칼럼
	balance number,
	PRIMARY KEY (logid)
);


CREATE TABLE posts
(
	-- 게시물번호
	postno number NOT NULL 게시물 번호. 기본키,
	-- 회원이 로그인할 때 쓸 아이디이다. 
	userid varchar2(50) NOT NULL UNIQUE,
	postview ,
	postlike ,
	-- 베스트 게시물 등재 여부
	-- 
	-- 
	isBest ,
	PRIMARY KEY (postno)
);


CREATE TABLE replies
(
	replyno  NOT NULL,
	-- 회원이 로그인할 때 쓸 아이디이다. 
	userid varchar2(50) NOT NULL UNIQUE,
	replyContent varchar2(500),
	replyDate date DEFAULT sysdate,
	PRIMARY KEY (replyno)
);


-- 회원 정보 테이블이다.
CREATE TABLE userinfo
(
	-- 유저 아이디와 별도로 만들 user number. 시퀀스처리
	userNum number NOT NULL 기본키,
	-- 회원이 로그인할 때 쓸 아이디이다. 
	userid varchar2(50) NOT NULL UNIQUE,
	-- 유저 비밀번호
	userpwd varchar2(40) NOT NULL,
	-- 유저가 회원 가입할 때 입력한 실명
	username varchar2(30),
	-- 유저 휴대폰 번호. 
	userphone varchar2(20),
	userbirth varchar2(20),
	-- 가입날짜
	signupDate date DEFAULT sysdate,
	userAddress varchar2(100),
	userEmail varchar2(50),
	-- 유저의 포인트 보유수 
	userpoint number(10),
	isManager char(2),
	PRIMARY KEY (userNum)
);



/* Create Foreign Keys */

ALTER TABLE announcement
	ADD FOREIGN KEY (userid)
	REFERENCES userinfo (userid)
;


ALTER TABLE Files
	ADD FOREIGN KEY (userid)
	REFERENCES userinfo (userid)
;


ALTER TABLE pointslog
	ADD FOREIGN KEY (userid)
	REFERENCES userinfo (userid)
;


ALTER TABLE posts
	ADD FOREIGN KEY (userid)
	REFERENCES userinfo (userid)
;


ALTER TABLE replies
	ADD FOREIGN KEY (userid)
	REFERENCES userinfo (userid)
;




