-- db 생성
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE demo_db;

-- user 생성
create user IF NOT EXISTS 'itsmart'@'%' IDENTIFIED BY 'itsmart1!';

-- 권한 부여
GRANT ALL PRIVILEGES ON `demo_db`.* TO 'itsmart'@'%' with grant option;
flush privileges;

-- 임시 테이블 및 임시 데이터 생성 [삭제 예정]
create table emp
(
    EMPNO    varchar(8)  not null
        primary key,
    ENAME    varchar(12) null,
    HIREDATE varchar(8)  null,
    DEPTNO   varchar(4)  null
);

INSERT INTO emp(EMPNO, ENAME, HIREDATE, DEPTNO)
VALUES ('00000000',
        'gypark',
        '20201220',
        '0001');


-- 테이블 생성
CREATE TABLE TB_USER_PROFILE_INFO
(
    user_id          VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    user_pw          VARCHAR(20) NOT NULL COMMENT '비밀번호',
    user_nm          VARCHAR(6)  NOT NULL COMMENT '직원명',
    user_position    VARCHAR(3)  NOT NULL COMMENT '직급/직위',
    user_birth       VARCHAR(8)  NOT NULL COMMENT '직원 생년월일',
    user_department  VARCHAR(3)  NOT NULL COMMENT '소속',
    hire_date        VARCHAR(8)  NOT NULL COMMENT '입사일',
    user_phone       VARCHAR(11) NOT NULL COMMENT '휴대전화',
    user_address     VARCHAR(50) NOT NULL COMMENT '주소',
    user_role        CHAR(1)     NOT NULL DEFAULT '1' COMMENT '권한 (0: admin, 1: user)',
    use_yn           CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '사용 여부',
    file_id          INT COMMENT '파일 아이디',
    edu1_school_name VARCHAR(20) COMMENT '학력1_학교명',
    edu1_grad_status VARCHAR(3) COMMENT '학력1_졸업상태',
    edu1_start_date  VARCHAR(8) COMMENT '학력1_입학일',
    edu1_end_date    VARCHAR(8) COMMENT '학력1_졸업일',
    edu2_school_name VARCHAR(20) COMMENT '학력2_학교명',
    edu2_grad_status VARCHAR(3) COMMENT '학력2_졸업상태',
    edu2_start_date  VARCHAR(8) COMMENT '학력2_입학일',
    edu2_end_date    VARCHAR(8) COMMENT '학력2_졸업일',
    edu3_school_name VARCHAR(20) COMMENT '학력3_학교명',
    edu3_grad_status VARCHAR(3) COMMENT '학력3_졸업상태',
    edu3_start_date  VARCHAR(8) COMMENT '학력3_입학일',
    edu3_end_date    VARCHAR(8) COMMENT '학력3_졸업일',
    major            VARCHAR(20) COMMENT '전공',
    double_major     VARCHAR(20) COMMENT '복수 전공',
    total_grade      DECIMAL(2, 1) COMMENT '졸업 학점',
    standard_grade   DECIMAL(2, 1) COMMENT '기준 학점',
    create_date      TIMESTAMP   NOT NULL COMMENT '생성일시',
    modified_date    TIMESTAMP   NOT NULL COMMENT '수정일시',
    creator          VARCHAR(10) NOT NULL COMMENT '생성자',
    modifier         VARCHAR(10) NOT NULL COMMENT '수정자',

    PRIMARY KEY (user_id)
) COMMENT ='직원 프로필 정보 테이블';



CREATE TABLE TB_USER_PROFILE_INFO_HIST
(
    user_id          VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    hist_seq         INT         NOT NULL COMMENT '이력 순번',
    user_nm          VARCHAR(6) COMMENT '직원명',
    user_position    VARCHAR(3) COMMENT '직급/직위',
    user_birth       VARCHAR(8) COMMENT '직원 생년월일',
    user_department  VARCHAR(3) COMMENT '소속',
    hire_date        VARCHAR(8) COMMENT '입사일',
    user_phone       VARCHAR(11) COMMENT '휴대전화',
    user_address     VARCHAR(50) COMMENT '주소',
    file_id          INT COMMENT '파일 아이디',
    file_seq         INT COMMENT '파일 순번',
    edu1_school_name VARCHAR(20) COMMENT '학력1_학교명',
    edu1_grad_status VARCHAR(3) COMMENT '학력1_졸업상태',
    edu1_start_date  VARCHAR(8) COMMENT '학력1_입학일',
    edu1_end_date    VARCHAR(8) COMMENT '학력1_졸업일',
    edu2_school_name VARCHAR(20) COMMENT '학력2_학교명',
    edu2_grad_status VARCHAR(3) COMMENT '학력2_졸업상태',
    edu2_start_date  VARCHAR(8) COMMENT '학력2_입학일',
    edu2_end_date    VARCHAR(8) COMMENT '학력2_졸업일',
    edu3_school_name VARCHAR(20) COMMENT '학력3_학교명',
    edu3_grad_status VARCHAR(3) COMMENT '학력3_졸업상태',
    edu3_start_date  VARCHAR(8) COMMENT '학력3_입학일',
    edu3_end_date    VARCHAR(8) COMMENT '학력3_졸업일',
    major            VARCHAR(20) COMMENT '전공',
    double_major     VARCHAR(20) COMMENT '복수 전공',
    total_grade      DECIMAL(2, 1) COMMENT '졸업 학점',
    standard_grade   DECIMAL(2, 1) COMMENT '기준 학점',
    create_date      TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator          VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, hist_seq)
) COMMENT ='직원 프로필이력관리 테이블';


CREATE TABLE TB_PROJECT_INFO
(
    user_id            VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    project_seq        INT         NOT NULL COMMENT '사업 순번',
    project_nm         VARCHAR(20) NOT NULL COMMENT '사업명',
    project_start_date VARCHAR(8)  NOT NULL COMMENT '투입시작일',
    project_end_date   VARCHAR(8)  NOT NULL COMMENT '투입종료일',
    project_role       VARCHAR(3)  NOT NULL COMMENT '역할',
    project_client     VARCHAR(20) NOT NULL COMMENT '발주처',
    assigned_task_lar  VARCHAR(3)  NOT NULL COMMENT '담당업무(대분류)',
    assigned_task_mid  VARCHAR(3)  NOT NULL COMMENT '담당업무(소분류)',
    use_yn             CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '사용 여부',
    create_date        TIMESTAMP   NOT NULL COMMENT '생성일시',
    modified_date      TIMESTAMP   NOT NULL COMMENT '수정일시',
    creator            VARCHAR(10) NOT NULL COMMENT '생성자',
    modifier           VARCHAR(10) NOT NULL COMMENT '수정자',

    PRIMARY KEY (user_id, project_seq)
) COMMENT ='참여사업 정보테이블';


CREATE TABLE TB_PROJECT_INFO_HIST
(
    user_id            VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    project_seq        INT         NOT NULL COMMENT '사업 순번',
    hist_seq           INT         NOT NULL COMMENT '이력 순번',
    project_nm         VARCHAR(20) COMMENT '사업명',
    project_start_date VARCHAR(8) COMMENT '투입시작일',
    project_end_date   VARCHAR(8) COMMENT '투입종료일',
    project_role       VARCHAR(3) COMMENT '역할',
    project_client     VARCHAR(20) COMMENT '발주처',
    assigned_task_lar  VARCHAR(3) COMMENT '담당업무(대분류)',
    assigned_task_mid  VARCHAR(3) COMMENT '담당업무(소분류)',
    create_date        TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator            VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, project_seq, hist_seq)
) COMMENT ='참여사업 이력관리 테이블';


CREATE TABLE TB_USER_SKILL_INFO
(
    user_id       VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    project_seq   INT         NOT NULL COMMENT '사업 순번',
    skill_id      INT         NOT NULL COMMENT '기술 아이디',
    skill_nm      VARCHAR(10) NOT NULL COMMENT '기술명',
    use_yn        CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    created_date  TIMESTAMP   NOT NULL COMMENT '생성일시',
    modified_date TIMESTAMP   NOT NULL COMMENT '수정일시',
    creator       VARCHAR(10) NOT NULL COMMENT '생성자',
    modifier      VARCHAR(10) NOT NULL COMMENT '수정자',

    PRIMARY KEY (user_id, project_seq, skill_id)
) COMMENT ='직원 기술 정보테이블';



CREATE TABLE TB_USER_SKILL_INFO_HIST
(
    user_id      VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    project_seq  INT         NOT NULL COMMENT '사업 순번',
    skill_id     INT         NOT NULL COMMENT '기술 아이디',
    hist_seq     INT         NOT NULL COMMENT '이력 순번',
    skill_nm     VARCHAR(10) COMMENT '기술명',
    created_date TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator      VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, project_seq, skill_id, hist_seq)
) COMMENT ='직원 기술 이력관리 테이블';



CREATE TABLE TB_USER_QUALIFICATION_INFO
(
    user_id           VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    qualification_seq INT         NOT NULL COMMENT '자격증 순번',
    qualification_nm  VARCHAR(20) NOT NULL COMMENT '자격증 명',
    issuer            VARCHAR(20) NOT NULL COMMENT '발행기관',
    acquisition_date  VARCHAR(8)  NOT NULL COMMENT '취득일자',
    expiry_date       VARCHAR(8) COMMENT '만기일자',
    is_expired        CHAR(1)              DEFAULT 'N' COMMENT '만기여부',
    use_yn            CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    created_date      TIMESTAMP   NOT NULL COMMENT '생성일시',
    modified_date     TIMESTAMP   NOT NULL COMMENT '수정일시',
    creator           VARCHAR(10) NOT NULL COMMENT '생성자',
    modifier          VARCHAR(10) NOT NULL COMMENT '수정자',

    PRIMARY KEY (user_id, qualification_seq)
) COMMENT ='직원 자격증 정보테이블';



CREATE TABLE TB_USER_QUALIFICATION_INFO_HIST
(
    user_id           VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    qualification_seq INT         NOT NULL COMMENT '자격증 순번',
    hist_seq          INT         NOT NULL COMMENT '이력 순번',
    qualification_nm  VARCHAR(20) COMMENT '자격증 명',
    issuer            VARCHAR(20) COMMENT '발행기관',
    acquisition_date  VARCHAR(8) COMMENT '취득일자',
    expiry_date       VARCHAR(8) COMMENT '만기일자',
    is_expired        CHAR(1) DEFAULT 'N' COMMENT '만기여부',
    created_date      TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator           VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, qualification_seq, hist_seq)
) COMMENT ='직원 자격증 이력관리 테이블';



CREATE TABLE TB_WORK_EXPERIENCE_INFO
(
    user_id         VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    work_seq        INT         NOT NULL COMMENT '근무지 순번',
    work_place      VARCHAR(20) NOT NULL COMMENT '근무지',
    work_start_date VARCHAR(8)  NOT NULL COMMENT '입사일자',
    word_end_date   VARCHAR(8)  NOT NULL COMMENT '퇴사일자',
    use_yn          CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    created_date    TIMESTAMP   NOT NULL COMMENT '생성일시',
    modified_date   TIMESTAMP   NOT NULL COMMENT '수정일시',
    creator         VARCHAR(10) NOT NULL COMMENT '생성자',
    modifier        VARCHAR(10) NOT NULL COMMENT '수정자',

    PRIMARY KEY (user_id, work_seq)
) COMMENT ='직원 근무지 정보테이블';



CREATE TABLE TB_WORK_EXPERIENCE_INFO_HIST
(
    user_id         VARCHAR(10) NOT NULL COMMENT '직원 아이디',
    work_seq        INT         NOT NULL COMMENT '근무지 순번',
    hist_seq        INT         NOT NULL COMMENT '이력 순번',
    work_place      VARCHAR(20) COMMENT '근무지',
    work_start_date VARCHAR(8) COMMENT '입사일자',
    word_end_date   VARCHAR(8) COMMENT '퇴사일자',
    created_date    TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator         VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, work_seq, hist_seq)
) COMMENT ='직원 근무지 이력관리 테이블';



CREATE TABLE TB_ATTACHMENT_INFO
(
    user_id        VARCHAR(10)  NOT NULL COMMENT '직원 아이디',
    file_seq       INT          NOT NULL COMMENT '파일 순번',
    file_ori_nm    VARCHAR(20)  NOT NULL COMMENT '로컬파일명',
    file_sver_nm   VARCHAR(50)  NOT NULL COMMENT '서버파일명',
    file_sver_path VARCHAR(100) NOT NULL COMMENT '파일 서버경로',
    file_extension VARCHAR(8)   NOT NULL COMMENT '파일확장자',
    use_yn         CHAR(1)      NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    created_date   TIMESTAMP    NOT NULL COMMENT '생성일시',
    creator        VARCHAR(10)  NOT NULL COMMENT '생성자',

    PRIMARY KEY (user_id, file_seq)
) COMMENT ='첨부파일 정보테이블';



CREATE TABLE TB_COMMON_CODE
(
    code_group_id VARCHAR(5)  NOT NULL COMMENT '코드그룹 아이디',
    code_id       VARCHAR(3)  NOT NULL COMMENT '코드상세 아이디',
    code_group_nm VARCHAR(10) NOT NULL COMMENT '코드그룹 명',
    code_value    VARCHAR(50) NOT NULL COMMENT '코드 값',
    parent_id     VARCHAR(3) COMMENT '상위코드 아이디',
    level         INT         NOT NULL COMMENT '계층 레벨',
    use_yn        CHAR(1)     NOT NULL DEFAULT 'Y' COMMENT '사용여부',
    created_date  TIMESTAMP   NOT NULL COMMENT '생성일시',
    creator       VARCHAR(10) NOT NULL COMMENT '생성자',

    PRIMARY KEY (code_group_id, code_id)
) COMMENT ='공통코드 테이블';


-- parent_id 컬럼에 인덱스 추가
CREATE INDEX idx_tb_common_code_parent_id ON TB_COMMON_CODE (parent_id);
