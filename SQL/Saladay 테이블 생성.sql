-- 프로젝트용 DB 계정 생성 코드 (sys계정)
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- 프로젝트 계정 생성
CREATE USER salaDay IDENTIFIED BY saladay1212;

-- 권한 부여
GRANT CONNECT, RESOURCE, CREATE VIEW TO salaDay;

-- 객체 생성 공간 할당
ALTER USER cafe DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM;

-----------------------------------------------------------------------


CREATE TABLE "MEMBER" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"MEMBER_EMAIL"	VARCHAR2(50)		NOT NULL,
	"MEMBER_PW"	VARCHAR2(100)		NOT NULL,
	"MEMBER_NICKNAME"	VARCHAR2(18)		NOT NULL,
	"MEMBER_NAME"	VARCHAR2(30)		NOT NULL,
	"MEMBER_TEL"	CHAR(11)		NOT NULL,
	"MEMBER_ADDRESS"	VARCHAR2(300)		NULL,
	"ENROLL_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MEMBER_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"AUTHORITY"	NUMBER	DEFAULT 1	NOT NULL
);

COMMENT ON COLUMN "MEMBER"."MEMBER_NO" IS '회원 번호(SEQ_MEMBER_NO)';

COMMENT ON COLUMN "MEMBER"."MEMBER_EMAIL" IS '회원 이메일(아이디)';

COMMENT ON COLUMN "MEMBER"."MEMBER_PW" IS '회원 비밀번호(암호화)';

COMMENT ON COLUMN "MEMBER"."MEMBER_NICKNAME" IS '회원 닉네임';

COMMENT ON COLUMN "MEMBER"."MEMBER_NAME" IS '회원 이름';

COMMENT ON COLUMN "MEMBER"."MEMBER_TEL" IS '회원  전화번호';

COMMENT ON COLUMN "MEMBER"."MEMBER_ADDRESS" IS '회원 주소(기본배송지)';

COMMENT ON COLUMN "MEMBER"."ENROLL_DATE" IS '회원 가입일';

COMMENT ON COLUMN "MEMBER"."MEMBER_DEL_FL" IS '탈퇴 여부(N: 탈퇴안 함, Y: 탈퇴)';

COMMENT ON COLUMN "MEMBER"."AUTHORITY" IS '권한 (0: 관리자, 1:일반회원)';

CREATE TABLE "REVIEW" (
	"REVIEW_NO"	NUMBER		NOT NULL,
	"RATING"	NUMBER		NOT NULL,
	"REVIEW_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"REVIEW_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"REVIEW_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"ORDER_MENU_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REVIEW"."REVIEW_NO" IS '리뷰번호(SEQ_REVIEW_NO)';

COMMENT ON COLUMN "REVIEW"."RATING" IS '별점';

COMMENT ON COLUMN "REVIEW"."REVIEW_CONTENT" IS '리뷰내용';

COMMENT ON COLUMN "REVIEW"."REVIEW_DATE" IS '리뷰작성일';

COMMENT ON COLUMN "REVIEW"."REVIEW_DEL_FL" IS '리뷰삭제여부(삭제: Y)';

COMMENT ON COLUMN "REVIEW"."MEMBER_NO" IS '회원 번호';

COMMENT ON COLUMN "REVIEW"."ORDER_MENU_NO" IS '주문한 메뉴 번호';

CREATE TABLE "OPTION" (
	"OPTION_NO"	NUMBER		NOT NULL,
	"OPTION_TYPE"	CHAR(1)		NOT NULL,
	"OPTION_NAME"	VARCHAR2(100)		NOT NULL,
	"OPTION_IMG"	VARCHAR2(300)	DEFAULT '/resources/images/menu/menuImg.png'	NOT NULL,
	"OPTION_PRICE"	NUMBER		NOT NULL,
	"OPTION_DEL_FL"	CHAR(1)		DEFAULT 'N' NOT NULL 
);

COMMENT ON COLUMN "OPTION"."OPTION_NO" IS '옵션번호(SEQ_OPTION_NO)';

COMMENT ON COLUMN "OPTION"."OPTION_TYPE" IS '옵션구분(M 메인,  T 토핑,  S 소스)';

COMMENT ON COLUMN "OPTION"."OPTION_NAME" IS '옵션이름';

COMMENT ON COLUMN "OPTION"."OPTION_IMG" IS '옵션사진(메뉴사진과 기본이미지 동일)';

COMMENT ON COLUMN "OPTION"."OPTION_PRICE" IS '옵션가격';

COMMENT ON COLUMN "OPTION"."OPTION_DEL_FL" IS '옵션 삭제여부(N: 사용, Y: 사용안 함)';

CREATE TABLE "MENU" (
	"MENU_NO"	NUMBER		NOT NULL,
	"MENU_NAME"	VARCHAR2(100)		NOT NULL,
	"MENU_PRICE"	NUMBER		NOT NULL,
	"MENU_IMG"	VARCHAR2(300)	DEFAULT '/resources/images/menu/menuImg.png'	NOT NULL,
	"MENU_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"MENU_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL
);

COMMENT ON COLUMN "MENU"."MENU_NO" IS '메뉴번호(SEQ_MENU_NO)';

COMMENT ON COLUMN "MENU"."MENU_NAME" IS '메뉴명';

COMMENT ON COLUMN "MENU"."MENU_PRICE" IS '메뉴가격';

COMMENT ON COLUMN "MENU"."MENU_IMG" IS '메뉴사진';

COMMENT ON COLUMN "MENU"."MENU_CONTENT" IS '메뉴설명';

COMMENT ON COLUMN "MENU"."MENU_DEL_FL" IS '메뉴 삭제여부(N: 사용, Y: 사용안 함)';

CREATE TABLE "DELIVERY" (
	"DELIVERY_NO"	NUMBER		NOT NULL,
	"DELIVERY_DATE"	DATE		NOT NULL,
	"ORDER_NO"	NUMBER		NOT NULL,
	"DELIVERY_CODE"	CHAR(1)	DEFAULT 'A'	NOT NULL
);

COMMENT ON COLUMN "DELIVERY"."DELIVERY_NO" IS '배송번호(SEQ_DELIVERY_NO)';

COMMENT ON COLUMN "DELIVERY"."DELIVERY_DATE" IS '배송예정일';

COMMENT ON COLUMN "DELIVERY"."ORDER_NO" IS '주문번호';

COMMENT ON COLUMN "DELIVERY"."DELIVERY_CODE" IS '배송코드(A:결제완료, B:배송준비,  C:배송중,  D:배송완료)';

CREATE TABLE "PACKAGE" (
	"PACKAGE_NO"	NUMBER		NOT NULL,
	"PACKAGE_NAME"	VARCHAR2(100)		NOT NULL,
	"PACKAGE_TYPE"	NUMBER		NOT NULL,
	"PACKAGE_IMG"	VARCHAR2(300)		NOT NULL
);

COMMENT ON COLUMN "PACKAGE"."PACKAGE_NO" IS '패키지 번호(SEQ_PACKAGE_NO)';

COMMENT ON COLUMN "PACKAGE"."PACKAGE_NAME" IS '패키지 이름';

COMMENT ON COLUMN "PACKAGE"."PACKAGE_TYPE" IS '패키지 구분(1: 1주, 2: 2주)';

COMMENT ON COLUMN "PACKAGE"."PACKAGE_IMG" IS '패키지 이미지';

CREATE TABLE "LIKE" (
	"REVIEW_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "LIKE"."REVIEW_NO" IS '리뷰번호';

COMMENT ON COLUMN "LIKE"."MEMBER_NO" IS '회원 번호';

CREATE TABLE "DELIVERY_MANAGE" (
	"DELIVERY_CODE"	CHAR(1)		NOT NULL,
	"DELIVERY_STATUS"	VARCHAR2(20)		NOT NULL
);

COMMENT ON COLUMN "DELIVERY_MANAGE"."DELIVERY_CODE" IS '배송코드(A:결제완료, B:배송준비, C:배송중, D:배송완료)';

COMMENT ON COLUMN "DELIVERY_MANAGE"."DELIVERY_STATUS" IS '배송상태(A:결제완료, B:배송준비, C:배송중, D:배송완료)';

CREATE TABLE "ORDER_MENU" (
	"ORDER_MENU_NO"	NUMBER		NOT NULL,
	"ORDER_NO"	NUMBER		NOT NULL,
	"MENU_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "ORDER_MENU"."ORDER_MENU_NO" IS '주문한 메뉴 번호(SEQ_ORDER_MENU_NO)';

COMMENT ON COLUMN "ORDER_MENU"."ORDER_NO" IS '주문번호';

COMMENT ON COLUMN "ORDER_MENU"."MENU_NO" IS '메뉴번호';

CREATE TABLE "ORDER" (
	"ORDER_NO"	NUMBER		NOT NULL,
	"ORDER_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"CANCLE_DATE"	DATE	DEFAULT NULL	NULL,
	"ORDER_PRICE"	NUMBER		NOT NULL,
	"ORDER_DEL_FL"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"ORDER_NAME"	VARCHAR2(30)		NOT NULL,
	"ORDER_TEL"	CHAR(11)		NOT NULL,
	"ORDER_ADDRESS"	VARCHAR2(300)		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"PACKAGE_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "ORDER"."ORDER_NO" IS '주문번호(SEQ_ORDER_NO)';

COMMENT ON COLUMN "ORDER"."ORDER_DATE" IS '주문일자';

COMMENT ON COLUMN "ORDER"."CANCLE_DATE" IS '취소일자';

COMMENT ON COLUMN "ORDER"."ORDER_PRICE" IS '주문한 메뉴 총 가격';

COMMENT ON COLUMN "ORDER"."ORDER_DEL_FL" IS '주문 취소 여부(Y:취소, N:주문)';

COMMENT ON COLUMN "ORDER"."ORDER_NAME" IS '배송받을 사람 이름';

COMMENT ON COLUMN "ORDER"."ORDER_TEL" IS '배송지 연락처';

COMMENT ON COLUMN "ORDER"."ORDER_ADDRESS" IS '배송지 주소';

COMMENT ON COLUMN "ORDER"."MEMBER_NO" IS '회원 번호';

COMMENT ON COLUMN "ORDER"."PACKAGE_NO" IS '패키지 번호';

CREATE TABLE "CART" (
	"CART_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"PACKAGE_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "CART"."CART_NO" IS '장바구니번호(SEQ_CART_NO)';

COMMENT ON COLUMN "CART"."MEMBER_NO" IS '회원 번호';

COMMENT ON COLUMN "CART"."PACKAGE_NO" IS '패키지 번호';

CREATE TABLE "ORDER_MENU_OPTION" (
	"ORDER_MENU_NO"	NUMBER		NOT NULL,
	"OPTION_NO"	NUMBER		NOT NULL,
	"OPTION_COUNT"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "ORDER_MENU_OPTION"."ORDER_MENU_NO" IS '주문한 메뉴 번호';

COMMENT ON COLUMN "ORDER_MENU_OPTION"."OPTION_NO" IS '옵션번호';

COMMENT ON COLUMN "ORDER_MENU_OPTION"."OPTION_COUNT" IS '옵션 수량';

CREATE TABLE "CART_MENU" (
	"CART_MENU_NO"	NUMBER		NOT NULL,
	"CART_NO"	NUMBER		NOT NULL,
	"MENU_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "CART_MENU"."CART_MENU_NO" IS '장바구니에 담은 메뉴 번호(SEQ_CART_MENU_NO)';

COMMENT ON COLUMN "CART_MENU"."CART_NO" IS '장바구니번호';

COMMENT ON COLUMN "CART_MENU"."MENU_NO" IS '메뉴번호';

CREATE TABLE "CART_MENU_OPTION" (
	"CART_MENU_NO"	NUMBER		NOT NULL,
	"OPTION_NO"	NUMBER		NOT NULL,
	"CART_OPTION_COUNT"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "CART_MENU_OPTION"."CART_MENU_NO" IS '장바구니에 담은 메뉴 번호';

COMMENT ON COLUMN "CART_MENU_OPTION"."OPTION_NO" IS '옵션번호';

COMMENT ON COLUMN "CART_MENU_OPTION"."CART_OPTION_COUNT" IS '장바구니 옵션 수량';

CREATE TABLE "REVIEW_IMG" (
	"REVIEW_IMG_NO"	NUMBER		NOT NULL,
	"IMG_PATH"	VARCHAR2(300)		NOT NULL,
	"IMG_RENAME"	VARCHAR2(300)		NOT NULL,
	"IMG_ORIGINAL"	VARCHAR2(300)		NOT NULL,
	"IMG_ORDER"	NUMBER		NOT NULL,
	"REVIEW_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "REVIEW_IMG"."REVIEW_IMG_NO" IS '리뷰 이미지 번호(SEQ_REVIEW_IMG_NO)';

COMMENT ON COLUMN "REVIEW_IMG"."IMG_PATH" IS '리뷰 이미지 저장 폴더 경로';

COMMENT ON COLUMN "REVIEW_IMG"."IMG_RENAME" IS '변경된 리뷰 이미지 파일 이름';

COMMENT ON COLUMN "REVIEW_IMG"."IMG_ORIGINAL" IS '원본 리뷰 이미지 파일 이름';

COMMENT ON COLUMN "REVIEW_IMG"."IMG_ORDER" IS '리뷰 이미지 파일 순서 번호';

COMMENT ON COLUMN "REVIEW_IMG"."REVIEW_NO" IS '리뷰 이미지가 첨부된 리뷰번호';

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MEMBER_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "PK_REVIEW" PRIMARY KEY (
	"REVIEW_NO"
);

ALTER TABLE "OPTION" ADD CONSTRAINT "PK_OPTION" PRIMARY KEY (
	"OPTION_NO"
);

ALTER TABLE "MENU" ADD CONSTRAINT "PK_MENU" PRIMARY KEY (
	"MENU_NO"
);

ALTER TABLE "DELIVERY" ADD CONSTRAINT "PK_DELIVERY" PRIMARY KEY (
	"DELIVERY_NO"
);

ALTER TABLE "PACKAGE" ADD CONSTRAINT "PK_PACKAGE" PRIMARY KEY (
	"PACKAGE_NO"
);

ALTER TABLE "LIKE" ADD CONSTRAINT "PK_LIKE" PRIMARY KEY (
	"REVIEW_NO",
	"MEMBER_NO"
);

ALTER TABLE "DELIVERY_MANAGE" ADD CONSTRAINT "PK_DELIVERY_MANAGE" PRIMARY KEY (
	"DELIVERY_CODE"
);

ALTER TABLE "ORDER_MENU" ADD CONSTRAINT "PK_ORDER_MENU" PRIMARY KEY (
	"ORDER_MENU_NO"
);

ALTER TABLE "ORDER" ADD CONSTRAINT "PK_ORDER" PRIMARY KEY (
	"ORDER_NO"
);

ALTER TABLE "CART" ADD CONSTRAINT "PK_CART" PRIMARY KEY (
	"CART_NO"
);

ALTER TABLE "ORDER_MENU_OPTION" ADD CONSTRAINT "PK_ORDER_MENU_OPTION" PRIMARY KEY (
	"ORDER_MENU_NO",
	"OPTION_NO"
);

ALTER TABLE "CART_MENU" ADD CONSTRAINT "PK_CART_MENU" PRIMARY KEY (
	"CART_MENU_NO"
);

ALTER TABLE "CART_MENU_OPTION" ADD CONSTRAINT "PK_CART_MENU_OPTION" PRIMARY KEY (
	"CART_MENU_NO",
	"OPTION_NO"
);

ALTER TABLE "REVIEW_IMG" ADD CONSTRAINT "PK_REVIEW_IMG" PRIMARY KEY (
	"REVIEW_IMG_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "FK_MEMBER_TO_REVIEW_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "REVIEW" ADD CONSTRAINT "FK_ORDER_MENU_TO_REVIEW_1" FOREIGN KEY (
	"ORDER_MENU_NO"
)
REFERENCES "ORDER_MENU" (
	"ORDER_MENU_NO"
);

ALTER TABLE "DELIVERY" ADD CONSTRAINT "FK_ORDER_TO_DELIVERY_1" FOREIGN KEY (
	"ORDER_NO"
)
REFERENCES "ORDER" (
	"ORDER_NO"
);

ALTER TABLE "DELIVERY" ADD CONSTRAINT "FK_DELIVERY_MANAGE_TO_DELIVERY_1" FOREIGN KEY (
	"DELIVERY_CODE"
)
REFERENCES "DELIVERY_MANAGE" (
	"DELIVERY_CODE"
);

ALTER TABLE "LIKE" ADD CONSTRAINT "FK_REVIEW_TO_LIKE_1" FOREIGN KEY (
	"REVIEW_NO"
)
REFERENCES "REVIEW" (
	"REVIEW_NO"
);

ALTER TABLE "LIKE" ADD CONSTRAINT "FK_MEMBER_TO_LIKE_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "ORDER_MENU" ADD CONSTRAINT "FK_ORDER_TO_ORDER_MENU_1" FOREIGN KEY (
	"ORDER_NO"
)
REFERENCES "ORDER" (
	"ORDER_NO"
);

ALTER TABLE "ORDER_MENU" ADD CONSTRAINT "FK_MENU_TO_ORDER_MENU_1" FOREIGN KEY (
	"MENU_NO"
)
REFERENCES "MENU" (
	"MENU_NO"
);

ALTER TABLE "ORDER" ADD CONSTRAINT "FK_MEMBER_TO_ORDER_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "ORDER" ADD CONSTRAINT "FK_PACKAGE_TO_ORDER_1" FOREIGN KEY (
	"PACKAGE_NO"
)
REFERENCES "PACKAGE" (
	"PACKAGE_NO"
);

ALTER TABLE "CART" ADD CONSTRAINT "FK_MEMBER_TO_CART_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "CART" ADD CONSTRAINT "FK_PACKAGE_TO_CART_1" FOREIGN KEY (
	"PACKAGE_NO"
)
REFERENCES "PACKAGE" (
	"PACKAGE_NO"
);

ALTER TABLE "ORDER_MENU_OPTION" ADD CONSTRAINT "FK_ORDER_MENU_TO_ORDER_MENU_OPTION_1" FOREIGN KEY (
	"ORDER_MENU_NO"
)
REFERENCES "ORDER_MENU" (
	"ORDER_MENU_NO"
);

ALTER TABLE "ORDER_MENU_OPTION" ADD CONSTRAINT "FK_OPTION_TO_ORDER_MENU_OPTION_1" FOREIGN KEY (
	"OPTION_NO"
)
REFERENCES "OPTION" (
	"OPTION_NO"
);

ALTER TABLE "CART_MENU" ADD CONSTRAINT "FK_CART_TO_CART_MENU_1" FOREIGN KEY (
	"CART_NO"
)
REFERENCES "CART" (
	"CART_NO"
);

ALTER TABLE "CART_MENU" ADD CONSTRAINT "FK_MENU_TO_CART_MENU_1" FOREIGN KEY (
	"MENU_NO"
)
REFERENCES "MENU" (
	"MENU_NO"
);

ALTER TABLE "CART_MENU_OPTION" ADD CONSTRAINT "FK_CART_MENU_TO_CART_MENU_OPTION_1" FOREIGN KEY (
	"CART_MENU_NO"
)
REFERENCES "CART_MENU" (
	"CART_MENU_NO"
);

ALTER TABLE "CART_MENU_OPTION" ADD CONSTRAINT "FK_OPTION_TO_CART_MENU_OPTION_1" FOREIGN KEY (
	"OPTION_NO"
)
REFERENCES "OPTION" (
	"OPTION_NO"
);

ALTER TABLE "REVIEW_IMG" ADD CONSTRAINT "FK_REVIEW_TO_REVIEW_IMG_1" FOREIGN KEY (
	"REVIEW_NO"
)
REFERENCES "REVIEW" (
	"REVIEW_NO"
);


-- 시퀀스 생성
CREATE SEQUENCE SEQ_MEMBER_NO NOCACHE; -- 회원번호
CREATE SEQUENCE SEQ_PACKAGE_NO NOCACHE; -- 패키지 번호
CREATE SEQUENCE SEQ_MENU_NO NOCACHE; -- 메뉴 번호
CREATE SEQUENCE SEQ_ORDER_NO NOCACHE; -- 주문 번호
CREATE SEQUENCE SEQ_OPTION_NO NOCACHE; -- 옵션(재료) 번호
CREATE SEQUENCE SEQ_ORDER_MENU_NO NOCACHE; -- 주문별 메뉴 번호
CREATE SEQUENCE SEQ_SEQ_DELIVERY_NO NOCACHE; -- 배송번호
CREATE SEQUENCE SEQ_CART_NO NOCACHE; -- 장바구니번호
CREATE SEQUENCE SEQ_CART_MENU_NO NOCACHE; -- 장바구니에 담은 메뉴 번호
CREATE SEQUENCE SEQ_REVIEW_NO NOCACHE; --리뷰번호
CREATE SEQUENCE SEQ_REVIEW_IMG_NO NOCACHE; --리뷰 이미지 번호


