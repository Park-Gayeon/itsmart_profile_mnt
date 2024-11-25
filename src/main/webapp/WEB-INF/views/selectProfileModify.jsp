<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <%-- 웹 앱 반응형 --%>
    <meta name="viewport" content="width=device-width", initial-scale="1">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/basic.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <title>직원 프로필관리 시스템</title>
</head>

<body>
<!-- header.jsp -->
<%@ include file="layout/header.jsp" %>
<!-- header.jsp -->

<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>

<!-- main-content -->
<div class="content">
    <div class="container">
        <!-- 인적사항 form -->
        <form id="profile">
            <div class="form-floating pt-5">
                <h2 class="header">인적사항
                    <div class="description" style="position: relative; top: 0px"><span class="star">*</span> 필수 입력
                        정보입니다.
                        <input type="button" class="btn btn-warning" data-name="profile" onclick="goSave(this)"
                               value="SAVE"/>
                    </div>
                </h2>
                <div class="common-box row-box row mb-5 g-0">
                    <!-- 사진 -->
                    <div class="col-md text-center">
                        <img src="/image/image.png" class="img-profile" alt="Profile Picture">
                    </div>
                    <!-- 개인정보 -->
                    <div class="col-md-auto g-0">
                        <!-- 첫번째 row -->
                        <div class="row mb-2 g-0">
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label for="user_nm">이름 <span class="star">*</span></label>
                                <input type="text" name="user_nm" id="user_nm" value="${profile.user_nm}" readonly/>
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label for="user_birth">생년월일 <span class="star">*</span></label>
                                <input type="text" class="dateFmt" name="user_birth" id="user_birth" maxlength="10"
                                       value="${profile.user_birth}"/>
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label for="user_phone">휴대전화 <span class="star">*</span></label>
                                <input type="text" class="telFmt" name="user_phone" id="user_phone" maxlength="13" value="${profile.user_phone}"
                                />
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label for="user_id">직원ID</label>
                                <input type="text" name="user_id" id="user_id" value="${profile.user_id}" readonly/>
                            </div>
                            <div class="col-sm common-box common-box input-box pt-4 me-2">
                                <label for="user_email">이메일</label>
                                <input type="text" id="user_email" value="${profile.user_id}@itsmart.co.kr" readonly/>
                            </div>
                        </div>
                        <!-- 두번째 row -->
                        <div class="row mb-2 g-0">
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label>소속</label>
                                <select class="form-select" name="user_department">
                                    <c:forEach var="orgList" items="${orgList}">
                                        <option value="${orgList.code_id}"
                                                <c:if test="${orgList.code_id eq profile.user_department}">selected</c:if>>${orgList.code_value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label>직위/직급</label>
                                <select class="form-select" name="user_position">
                                    <c:forEach var="psitList" items="${psitList}">
                                        <option value="${psitList.code_id}"
                                                <c:if test="${psitList.code_id eq profile.user_position}">selected</c:if>>${psitList.code_value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label for="hire_date">입사일자</label>
                                <input type="text" class="dateFmt" name="hire_date" id="hire_date" maxlength="10"
                                       value="${profile.hire_date}" readonly/>
                            </div>
                            <div class="col-sm common-box common-box input-box pt-4 me-2">
                                <label for="user_address">주소 <span class="star">*</span></label>
                                <input type="text" name="user_address" id="user_address" maxlength="40"
                                       value="${profile.user_address}"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 인적사항 form 끝 -->
            <!-- 학력 form -->
            <div class="form-floating" id="schFrm">
                <h2 class="header">학력<span><button type="button" class="btn btn-primary add_field"
                                                   data-target="schFrm">ADD</button></span>
                </h2>
                <div class="common-box row-box row mb-5 g-0">
                    <div class="col-md g-0 add-main">
                        <c:forEach var="i" begin="1" end="3">
                            <c:set var="eduKey" value="edu${i}_school_name"/>
                            <c:if test="${profile[eduKey] ne ''}">
                                <!-- 첫번째 row -->
                                <div class="row mb-2 g-0 add">
                                    <div class="col-sm-1 common-box input-box pt-4">
                                        <c:set var="gubunKey" value="edu${i}_gubun"/>
                                        <label>학교구분</label>
                                        <select class="form-select schGb" style="width: 100px; font-size: 12px;"
                                                name="edu${i}_gubun">
                                            <option value="">선택해주세요</option>
                                            <option value="010" ${profile[gubunKey] == '010' ? 'selected' : ''}>
                                                고등학교
                                            </option>
                                            <option value="011" ${profile[gubunKey] == '011' ? 'selected' : ''}>
                                                대학교(2,3년)
                                            </option>
                                            <option value="012" ${profile[gubunKey] == '012' ? 'selected' : ''}>
                                                대학교(4년)
                                            </option>
                                            <option value="013" ${profile[gubunKey] == '013' ? 'selected' : ''}>
                                                대학원
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col-sm-3 common-box input-box pt-4 me-2">
                                        <label for="edu${i}_school_name">학교명</label>
                                        <input type="text" name="edu${i}_school_name" id="edu${i}_school_name" maxlength="15"
                                               value="${profile[eduKey]}"/>
                                    </div>
                                    <div class="col-sm-2 common-box input-box pt-4">
                                        <c:set var="startDateKey" value="edu${i}_start_date"/>
                                        <label for="edu${i}_start_date">입학년월</label>
                                        <input type="text" class="dateFmt" name="edu${i}_start_date" id="edu${i}_start_date"
                                               maxlength="10" value="${profile[startDateKey]}"/>
                                    </div>
                                    <div class="col-sm-2 common-box input-box pt-4 me-2">
                                        <c:set var="endDateKey" value="edu${i}_end_date"/>
                                        <label for="edu${i}_end_date">졸업년월</label>
                                        <input type="text" class="dateFmt" name="edu${i}_end_date" id="edu${i}_end_date"
                                               maxlength="10" value="${profile[endDateKey]}"/>
                                    </div>
                                    <div class="col-sm-1 common-box input-box pt-4 me-2">
                                        <c:set var="statusKey" value="edu${i}_grad_status"/>
                                        <label>졸업상태</label>
                                        <select class="form-select" style="width: 100px; font-size: 12px"
                                                name="edu${i}_grad_status">
                                            <option value="">선택해주세요</option>
                                            <option value="001" ${profile[statusKey] == '001' ? 'selected' : ''}>
                                                졸업
                                            </option>
                                            <option value="002" ${profile[statusKey] == '002' ? 'selected' : ''}>
                                                졸업예정
                                            </option>
                                            <option value="003" ${profile[statusKey] == '003' ? 'selected' : ''}>
                                                재학중
                                            </option>
                                        </select>
                                    </div>
                                    <c:if test="${i eq 1}">
                                        <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                            <button type="button" class="btn btn-danger clear_field"
                                                    onclick="clearField()">CLEAR
                                            </button>
                                        </div>
                                    </c:if>
                                    <c:if test="${i ne 1}">
                                        <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                            <button type="button" class="btn btn-danger remove-field"
                                                    data-target="schFrm">REMOVE
                                            </button>
                                        </div>
                                    </c:if>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:if test="${profile.edu1_school_name eq ''}">
                            <!-- 첫번째 row -->
                            <div class="row mb-2 g-0 add">
                                <div class="col-sm-1 common-box input-box pt-4">
                                    <label>학교구분</label>
                                    <select class="form-select schGb" style="width: 100px; font-size: 12px"
                                            name="edu1_gubun">
                                        <option value="">선택해주세요</option>
                                        <option value="010">고등학교</option>
                                        <option value="011">대학교(2,3년)</option>
                                        <option value="012">대학교(4년)</option>
                                        <option value="013">대학원</option>
                                    </select>
                                </div>
                                <div class="col-sm-3 common-box input-box pt-4 me-2">
                                    <label>학교명</label>
                                    <input type="text" name="edu1_school_name" maxlength="15"/>
                                </div>
                                <div class="col-sm-2 common-box input-box pt-4">
                                    <label>입학년월</label>
                                    <input type="text" name="edu1_start_date"/>
                                </div>
                                <div class="col-sm-2 common-box input-box pt-4 me-2">
                                    <label>졸업년월</label>
                                    <input type="text" name="edu1_end_date"/>
                                </div>
                                <div class="col-sm-1 common-box input-box pt-4 me-2">
                                    <label>졸업상태</label>
                                    <select class="form-select" style="width: 100px; font-size: 12px"
                                            name="edu1_grad_status">
                                        <option value="">선택해주세요</option>
                                        <option value="001">졸업</option>
                                        <option value="002">졸업예정</option>
                                        <option value="003">재학중</option>
                                    </select>
                                </div>
                                <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                    <button type="button" class="btn btn-danger clear_field"
                                            onclick="clearField()">CLEAR
                                    </button>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- 두번째 row -->
                    <div class="row mb-2 g-0" id="schSub" style="<c:if test="${profile.major eq ''}">display: none;</c:if>">
                        <div class="col-sm-3 common-box input-box pt-4 me-2">
                            <label for="major">전공명</label>
                            <input type="text" name="major" id="major" maxlength="18" value="${profile.major}"/>
                        </div>
                        <div class="col-sm-3 common-box input-box pt-4 me-2">
                            <label for="double_major">복수전공명</label>
                            <input type="text" name="double_major" id="double_major" maxlength="18"
                                   value="${profile.double_major}"/>
                        </div>
                        <div class="col-sm-1 common-box input-box pt-4">
                            <label for="total_grade">학점</label>
                            <input type="text" class="grade" name="total_grade" id="total_grade" maxlength="3" onkeyup="onlyDot(this)" value="${profile.total_grade}"/>
                        </div>
                        <div class="col-sm-1 common-box input-box pt-4">
                            <label for="standard_grade">총점</label>
                            <input type="text" class="grade" name="standard_grade" id="standard_grade" maxlength="3" onkeyup="onlyDot(this)" value="${profile.standard_grade}"/>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <!-- 학력 form 끝 -->

        <!-- 자격증 form -->
        <form id="qualification">
            <div class="form-floating" id="qlFrm">
                <h2 class="header">자격증
                    <span>
                        <button type="button" class="btn btn-primary add_field" data-target="qlFrm">ADD</button>
                        <button type="button" class="btn btn-outline-success" data-name="qualification"
                                onclick="goSave(this)">SAVE</button>
                    </span>
                </h2>
                <div class="common-box row-box row mb-5 g-0">
                    <div class="col-md g-0 add-main">
                        <c:choose>
                            <c:when test="${not empty profile.qualificationList}">
                                <c:forEach var="qualification" items="${profile.qualificationList}"
                                           varStatus="qlStatus">
                                    <div class="row mb-2 g-0 add" id="qualificationList_${qlStatus.index}">
                                        <input type="hidden" class="seq"
                                               name="qualificationList[${qlStatus.index}].qualification_seq"
                                               value="${qualification.qualification_seq}">
                                        <div class="col-sm-2 common-box input-box pt-4 me-2">
                                            <label>자격증명</label>
                                            <input type="text"
                                                   name="qualificationList[${qlStatus.index}].qualification_nm" maxlength="18"
                                                   value="${qualification.qualification_nm}">
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4 me-2">
                                            <label>발행기관</label>
                                            <input type="text" name="qualificationList[${qlStatus.index}].issuer" maxlength="18"
                                                   value="${qualification.issuer}"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <label>취득일자</label>
                                            <input type="text" class="dateFmt" maxlength="10"
                                                   name="qualificationList[${qlStatus.index}].acquisition_date"
                                                   value="${qualification.acquisition_date}"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <label>만기일자</label>
                                            <input type="text" class="dateFmt" maxlength="10"
                                                   name="qualificationList[${qlStatus.index}].expiry_date"
                                                   value="${qualification.expiry_date}"/>
                                        </div>
                                        <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                            <c:choose>
                                                <c:when test="${qlStatus.index == 0}">
                                                    <button type="button" class="btn btn-danger clear_field"
                                                            onclick="clearField()">CLEAR
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button" class="btn btn-danger remove-field"
                                                            data-target="qlFrm">REMOVE
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="row mb-2 g-0 add" id="qualificationList_0">
                                    <input type="hidden" class="seq" name="qualificationList[0].qualification_seq"
                                           value="1">
                                    <div class="col-sm-2 common-box input-box pt-4 me-2">
                                        <label>자격증명</label>
                                        <input type="text" name="qualificationList[0].qualification_nm" maxlength="18"/>
                                    </div>
                                    <div class="col-sm-2 common-box input-box pt-4 me-2">
                                        <label>발행기관</label>
                                        <input type="text" name="qualificationList[0].issuer" maxlength="18"/>
                                    </div>
                                    <div class="col-sm-2 common-box input-box pt-4">
                                        <label>취득일자</label>
                                        <input type="text" class="dateFmt" maxlength="10"
                                               name="qualificationList[0].acquisition_date"/>
                                    </div>
                                    <div class="col-sm-2 common-box input-box pt-4">
                                        <label>만기일자</label>
                                        <input type="text" class="dateFmt" maxlength="10"
                                               name="qualificationList[0].expiry_date"/>
                                    </div>
                                    <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                        <button type="button" class="btn btn-danger clear_field"
                                                onclick="clearField()">CLEAR
                                        </button>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </form>
        <!-- 자격증 form 끝 -->
        <!-- 경력 form -->
        <div class="form-floating">
            <h2 class="header">경력</h2>
            <div class="common-box row-box row mb-5 g-0">
                <!-- 근무경력 form -->
                <form id="workExperience">
                    <div class="pb-3" id="workFrm">
                        <header class="header">근무경력
                            <span id="wk_career" class="fw-bolder" style="font-size: 12px;"></span>
                            <span>
                                <button type="button" class="btn btn-primary add_field"
                                          data-target="workFrm">ADD
                                </button>
                                <button type="button" class="btn btn-outline-success"
                                        data-name="workExperience" onclick="goSave(this)">SAVE
                                </button>
                            </span>
                        </header>
                        <div class="col-md g-0 add-main">
                            <c:choose>
                                <c:when test="${not empty profile.workExperienceList}">
                                    <c:forEach var="work" items="${profile.workExperienceList}" varStatus="wkStatus">
                                        <div class="row mb-2 g-0 add" id="workExperienceList_${wkStatus.index}">
                                            <input type="hidden" class="seq"
                                                   name="workExperienceList[${wkStatus.index}].work_seq"
                                                   value="${work.work_seq}"/>
                                            <div class="col-sm-3 common-box input-box pt-4 me-2">
                                                <label>회사명</label>
                                                <input type="text" maxlength="18"
                                                       name="workExperienceList[${wkStatus.index}].work_place"
                                                       value="${work.work_place}"/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4">
                                                <label>입사일자</label>
                                                <input type="text" class="dateFmt" maxlength="10"
                                                       name="workExperienceList[${wkStatus.index}].work_start_date"
                                                       value="${work.work_start_date}"/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4">
                                                <label>퇴사일자</label>
                                                <input type="text" class="dateFmt" maxlength="10"
                                                       name="workExperienceList[${wkStatus.index}].work_end_date"
                                                       value="${work.work_end_date}"/>
                                            </div>
                                            <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                                <c:choose>
                                                    <c:when test="${wkStatus.index == 0}">
                                                        <button type="button" class="btn btn-danger clear_field"
                                                                onclick="clearField()">CLEAR
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="btn btn-danger remove-field"
                                                                data-target="workFrm">REMOVE
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="row mb-2 g-0 add" id="workExperienceList_0">
                                        <input type="hidden" class="seq" name="workExperienceList[0].work_seq"/>
                                        <div class="col-sm-3 common-box input-box pt-4 me-2">
                                            <label>회사명</label>
                                            <input type="text" name="workExperienceList[0].work_place" maxlength="18"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <label>입사일자</label>
                                            <input type="text" class="dateFmt" maxlength="10"
                                                   name="workExperienceList[0].work_start_date"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <label>퇴사일자</label>
                                            <input type="text" class="dateFmt" maxlength="10"
                                                   name="workExperienceList[0].work_end_date"/>
                                        </div>
                                        <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                            <button type="button" class="btn btn-danger clear_field"
                                                    onclick="clearField()">CLEAR
                                            </button>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </form>
                <!-- 근무경력 form 끝-->
                <hr>
                <!-- 사업경력 form -->
                <form id="project">
                    <div id="pjFrm">
                        <header class="header">사업경력
                            <span id="pj_career" class="fw-bolder" style="font-size: 12px;"></span>
                            <span>
                                <button type="button" class="btn btn-primary" data-target="pjFrm"
                                          onclick="addProject()">ADD
                                </button>
                                <button type="button" class="btn btn-outline-success"
                                    data-name="project" onclick="goSave(this)">SAVE
                                </button>
                            </span>
                        </header>
                        <div class="table-responsive common-box p-3">
                            <header>진행사항</header>
                            <table class="table table-hover mb-5">
                                <colgroup>
                                    <col style="width: 5%;">
                                    <col style="width: 15%;">
                                    <col style="width: 30%;">
                                    <col style="width: 20%;">
                                    <col style="width: 15%;">
                                    <col style="width: 5%;">
                                    <col style="width: 5%;">
                                    <col style="width: 5%;">
                                <colgroup>
                                <thead>
                                <tr>
                                    <th scope="col">NO</th>
                                    <th scope="col">발주처</th>
                                    <th scope="col">사업명</th>
                                    <th scope="col">참여기간</th>
                                    <th scope="col">담당업무</th>
                                    <th scope="col">역할</th>
                                    <th scope="col">기술</th>
                                    <th scope="col"></th>
                                </tr>
                                </thead>
                                <tbody class="table-group-divider" id="project_ing">
                                <c:set var="count_ing" value="1"/>
                                <c:forEach var="project_ing" items="${profile.projectList}" varStatus="pjStatus">
                                    <fmt:parseDate var="project_end_date" value="${project_ing.project_end_date}"
                                                   pattern="yyyyMMdd"/>
                                    <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                    var="project_end_date"/>
                                    <c:if test="${today <= project_end_date}">
                                        <tr class="add" id="projectList_${pjStatus.index}">
                                            <td>${count_ing}</td>
                                            <input type="hidden"
                                                   name="projectList[${pjStatus.index}].project_seq"
                                                   value="${project_ing.project_seq}"/>
                                            <input type="hidden" class="useYn" name="projectList[${pjStatus.index}].use_yn" value="${project_ing.use_yn}"/>
                                            <td><input type="text" name="projectList[${pjStatus.index}].project_client" maxlength="18"
                                                       value="${project_ing.project_client}"/></td>
                                            <td><input type="text" name="projectList[${pjStatus.index}].project_nm" maxlength="18"
                                                       value="${project_ing.project_nm}"/></td>
                                            <td><input type="text" class="dateFmt" maxlength="10"
                                                       name="projectList[${pjStatus.index}].project_start_date"
                                                       value="${project_ing.project_start_date}"/>
                                                ~ <input type="text" class="dateFmt" maxlength="10"
                                                         name="projectList[${pjStatus.index}].project_end_date"
                                                         value="${project_ing.project_end_date}"/></td>
                                            <td>
                                                <select class="form-select" style="width: auto" onchange="selectTaskLar(this)"
                                                        name="projectList[${pjStatus.index}].assigned_task_lar">
                                                    <c:forEach var="taskLarList" items="${taskLarList}">
                                                        <option value="${taskLarList.code_id}"
                                                                <c:if test="${taskLarList.code_id eq project_ing.assigned_task_lar}">selected</c:if>>${taskLarList.code_value}</option>
                                                    </c:forEach>
                                                </select>
                                                <select class="form-select" style="width: auto"
                                                        name="projectList[${pjStatus.index}].assigned_task_mid">
                                                    <c:forEach var="taskMidList" items="${taskMidList}">
                                                        <option value="${taskMidList.code_id}"
                                                                <c:if test="${taskMidList.code_id eq project_ing.assigned_task_mid}">selected</c:if>>${taskMidList.code_value}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td>
                                                <select class="form-select" style="width: auto"
                                                        name="projectList[${pjStatus.index}].project_role">
                                                    <c:forEach var="roleList" items="${roleList}">
                                                        <option value="${roleList.code_id}"
                                                                <c:if test="${roleList.code_id eq project_ing.project_role}">selected</c:if>>${roleList.code_value}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td>
                                                <input type="button" class="btn btn-warning"
                                                       onclick="viewSkill(${project_ing.project_seq})" value="확인"/>
                                            </td>
                                            <td>
                                                <input type="button" class="btn btn-danger"
                                                       onclick="remove(this, 'old')" value="REMOVE"/>
                                            </td>
                                        </tr>
                                        <c:set var="count_ing" value="${count_ing+1}"/>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                            <header>이력사항</header>
                            <table class="table table-hover">
                                <colgroup>
                                    <col style="width: 5%;">
                                    <col style="width: 15%;">
                                    <col style="width: 30%;">
                                    <col style="width: 20%;">
                                    <col style="width: 15%;">
                                    <col style="width: 5%;">
                                    <col style="width: 5%;">
                                    <col style="width: 5%;">
                                <colgroup>
                                <thead>
                                <tr>
                                    <th scope="col">NO</th>
                                    <th scope="col">발주처</th>
                                    <th scope="col">사업명</th>
                                    <th scope="col">참여기간</th>
                                    <th scope="col">담당업무</th>
                                    <th scope="col">역할</th>
                                    <th scope="col">기술</th>
                                    <th scope="col"></th>
                                </tr>
                                </thead>
                                <tbody class="table-group-divider" id="project_hist">
                                <c:set var="count_hist" value="1"/>
                                <c:forEach var="project_hist" items="${profile.projectList}" varStatus="pjStatus">
                                    <fmt:parseDate var="project_end_date" value="${project_hist.project_end_date}"
                                                   pattern="yyyyMMdd"/>
                                    <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                    var="project_end_date"/>
                                    <c:if test="${today > project_end_date}">
                                        <tr class="add" id="projectList_${pjStatus.index}">
                                            <td>${count_hist}</td>
                                            <input type="hidden"
                                                   name="projectList[${pjStatus.index}].project_seq"
                                                   value="${project_hist.project_seq}"/>
                                            <input type="hidden" class="useYn" name="projectList[${pjStatus.index}].use_yn" value="${project_hist.use_yn}"/>
                                            <td><input type="text" name="projectList[${pjStatus.index}].project_client" maxlength="18"
                                                       value="${project_hist.project_client}"/></td>
                                            <td><input type="text" name="projectList[${pjStatus.index}].project_nm" maxlength="18"
                                                       value="${project_hist.project_nm}"/></td>
                                            <td><input type="text" class="dateFmt" maxlength="10"
                                                       name="projectList[${pjStatus.index}].project_start_date"
                                                       value="${project_hist.project_start_date}"/>
                                                ~ <input type="text" class="dateFmt" maxlength="10"
                                                         name="projectList[${pjStatus.index}].project_end_date"
                                                         value="${project_hist.project_end_date}"/></td>
                                            <td>
                                                <select class="form-select" style="width: auto"
                                                        name="projectList[${pjStatus.index}].assigned_task_lar">
                                                    <c:forEach var="taskLarList" items="${taskLarList}">
                                                        <option value="${taskLarList.code_id}"
                                                                <c:if test="${taskLarList.code_id eq project_hist.assigned_task_lar}">selected</c:if>>${taskLarList.code_value}</option>
                                                    </c:forEach>
                                                </select>
                                                <select class="form-select" style="width: auto"
                                                        name="projectList[${pjStatus.index}].assigned_task_mid">
                                                    <c:forEach var="taskMidList" items="${taskMidList}">
                                                        <option value="${taskMidList.code_id}"
                                                                <c:if test="${taskMidList.code_id eq project_hist.assigned_task_mid}">selected</c:if>>${taskMidList.code_value}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td>
                                                <select class="form-select" style="width: auto"
                                                        name="projectList[${pjStatus.index}].project_role">
                                                    <c:forEach var="roleList" items="${roleList}">
                                                        <option value="${roleList.code_id}"
                                                                <c:if test="${roleList.code_id eq project_hist.project_role}">selected</c:if>>${roleList.code_value}</option>
                                                    </c:forEach>
                                                </select>
                                            <td>
                                                <input type="button" class="btn btn-warning"
                                                       onclick="viewSkill(${project_hist.project_seq})" value="확인"/>
                                            </td>
                                            <td>
                                                <input type="button" class="btn btn-danger"
                                                       onclick="remove(this, 'old')" value="REMOVE"/>
                                            </td>
                                        </tr>
                                        <c:set var="count_hist" value="${count_hist+1}"/>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </form>
                <!-- 사업경력 form 끝-->
            </div>
        </div>
    </div>
</div>
<!-- 자격증 form 끝 -->


</div>
<!-- main-content -->

<!-- footer.jsp -->
<%@ include file="layout/footer.jsp" %>
<!-- footer.jsp -->
<script src="//code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.bundle.js"></script>
<script src="/js/common.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        const wk_totalMonth = [[${wk_totalMonth}]];
        const pj_totalMonth = [[${pj_totalMonth}]];

        let calc_wk_totalMonth = convertToString(wk_totalMonth);
        let calc_pj_totalMonth = convertToString(pj_totalMonth);

        document.getElementById("wk_career").innerText = calc_wk_totalMonth;
        document.getElementById("pj_career").innerText = calc_pj_totalMonth;

        // 날짜 및 휴대전화 포맷
        $(".container").find(".dateFmt, .telFmt").each(function(){
            formatInput($(this));
        });

        $(".add_field").click(function () {
            let frmId = $(this).data("target");
            let newRow;
            let listNm;
            let schCnt = $("#schFrm .add-main")[0].childElementCount;

            if (frmId == 'qlFrm') {
                listNm = 'qualificationList';
                newRow =
                    `<div class="row mb-2 g-0 add" id="qualificationList_">
                            <input type="hidden" class="seq" name="qualificationList[].qualification_seq" value=""/>
                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                <label>자격증명</label>
                                <input type="text" name="qualificationList[].qualification_nm" maxlength="18"/>
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                <label>발행기관</label>
                                <input type="text" name="qualificationList[].issuer" maxlength="18"/>
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4">
                                <label>취득일자</label>
                                <input type="text" class="dateFmt" maxlength="10" name="qualificationList[].acquisition_date"/>
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4">
                                <label>만기일자</label>
                                <input type="text" class="dateFmt" maxlength="10" name="qualificationList[].expiry_date"/>
                            </div>
                            <div class="col-sm-1" style="text-align: center; padding-top: 15px;"><button type="button" class="btn btn-danger remove-field" data-target="qlFrm">REMOVE</button></div>
                        </div>`;
            } else if (frmId == 'workFrm') {
                listNm = 'workExperienceList';
                newRow =
                    `<div class="row mb-2 g-0 add" id="workExperienceList_">
                                        <input type="hidden" class="seq" name="workExperienceList[].work_seq" value=""/>
                                        <div class="col-sm-3 common-box input-box pt-4 me-2">
                                            <label>회사명</label>
                                            <input type="text" name="workExperienceList[].work_place" maxlength="18"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <label>입사일자</label>
                                            <input type="text" class="dateFmt" maxlength="10" name="workExperienceList[].work_start_date"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <label>퇴사일자</label>
                                            <input type="text" class="dateFmt" maxlength="10" name="workExperienceList[].work_end_date"/>
                                        </div>
                                        <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                            <button type="button" class="btn btn-danger remove-field" data-target="workFrm">REMOVE</button>
                                        </div>
                                    </div>`;
            } else if (frmId == 'schFrm') {
                listNm = 'edu';
                newRow = `<div class="row mb-2 g-0 add">
                            <div class="col-sm-1 common-box input-box pt-4">
                                <label>학교구분</label>
                                <select class="form-select schGb" style="width: 100px; font-size: 12px"
                                        name="edu1_gubun">
                                    <option value="">선택해주세요</option>
                                    <option value="010">고등학교</option>
                                    <option value="011">대학교(2,3년)</option>
                                    <option value="012">대학교(4년)</option>
                                    <option value="013">대학원</option>
                                </select>
                            </div>
                            <div class="col-sm-3 common-box input-box pt-4 me-2">
                                <label>학교명</label>
                                <input type="text" name="edu1_school_name" maxlength="15"/>
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4">
                                <label>입학년월</label>
                                <input type="text" class="dateFmt" maxlength="10" name="edu1_start_date"/>
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                <label>졸업년월</label>
                                <input type="text" class="dateFmt" maxlength="10" name="edu1_end_date"/>
                            </div>
                            <div class="col-sm-1 common-box input-box pt-4 me-2">
                                <label>졸업상태</label>
                                <select class="form-select" style="width: 100px; font-size: 12px"
                                        name="edu1_grad_status">
                                    <option value="">선택해주세요</option>
                                    <option value="001">졸업</option>
                                    <option value="002">졸업예정</option>
                                    <option value="003">재학중</option>
                                </select>
                            </div>
                            <div class="col-sm-1" style="text-align: center; padding-top: 15px;">
                                <button type="button" class="btn btn-danger remove-field" data-target="schFrm">REMOVE</button>
                                </button>
                            </div>
                        </div>
                    `;
                if(schCnt == 3){
                    alert("학력은 3개 이상 작성 할 수 없습니다");
                    return;
                }
            }
            $("#" + frmId + " .add-main").append(newRow);
            updateRowIndex(frmId, listNm);
        });

        $(document).on("click", ".remove-field", function () {
            let frmId = $(this).data("target");
            let listNm;
            if (frmId === "qlFrm") {
                listNm = "qualificationList";
            } else if (frmId === "workFrm") {
                listNm = "workExperienceList";
            } else if (frmId === 'schFrm'){
                listNm = "edu";
            }
            $(this).closest(".add").remove();
            updateRowIndex(frmId, listNm);

            if (frmId === 'schFrm') {
                $(".schGb").trigger("change");
            }
        });

        $(document).on("change", ".schGb", function (){
           const chkArr = ["011", "012", "013"];
           let show = false;
           $(".schGb").each(function (){
               if(chkArr.includes($(this).val())){
                   show = true;
                   return;
               }
           });
           if(show){
               $("#schSub").show();
           }else{
               $("#schSub").hide();
           }
        });

        $(".container").on("keyup", ".dateFmt, .telFmt", function(){
            formatInput($(this));
        });


    });
    // 전역변수로 선언
    let addCnt = 0;

    function updateRowIndex(frmId, listNm) {
        $("#" + frmId + " .add").each(function (i) {
            if(frmId == 'schFrm'){
                i += 1;
                $(this).find("input, select").each(function(){
                    let name = $(this).attr("name");
                    if(name && name.startsWith(listNm)){
                        let newName = name.replace(/edu\d+_/, 'edu' + i + '_');
                        $(this).attr("name", newName);
                    }
                });
            } else {
                $(this).attr("id", listNm + "_" + i);
                // 모든 input 및 select 태그에서 name 속성 업데이트(인덱스 정렬)
                $(this).find("input, select").each(function () {
                    let name = $(this).attr("name");
                    if (name && name.startsWith(listNm)) {
                        let newName = name.replace(/\[\d*\]/, '[' + i + ']');
                        $(this).attr("name", newName);
                    }
                });
                $(this).find(".seq").attr("value", i + 1); // seq 새로 부여
            }
        });
    }

    function clearField() {
        alert("아직 구현중");
    }

    function addProject() {
        let user_id = $('input[name=user_id]').val();
        let url = "/profile/project/modify/add?user_id=" + user_id;
        let properties ="width=800,height=300"
        window.open(url, "addNewProject", properties);
    }

    // 팝업창에서 데이터 받아오기
    function addProjectRow(data) {
        const PjEndDate = new Date(data.project_end_date);
        const todayDate = new Date();

        // 이걸로 추가가 된 횟수를 센다.
        addCnt += data.addCnt;

        // 진행/이력 구분
        const target = PjEndDate >= todayDate ? document.getElementById("project_ing") : document.getElementById("project_hist");
        let newRow;
        let project_seq = Number(data.project_seq) + addCnt; // TB_PROJECT 에서 MAX(SEQ)를 조회한 값에 addCnt를 더해줌으로써 seq 를 새롭게 생성
        let frmId = 'pjFrm';
        let listNm = 'projectList';
        newRow = `<tr class="add">
                    <td>+</td>
                    <input type="hidden" name="projectList[].project_seq" value="` + project_seq + `"/>
                    <td><input type="text" name="projectList[].project_client" maxlength="18"
                               value="` + data.project_client + `" readonly/></td>
                    <td><input type="text" name="projectList[].project_nm" maxlength="18"
                               value="` + data.project_nm + `" readonly/></td>
                    <td><input type="text" class="dateFmt" maxlength="10"
                               name="projectList[].project_start_date"
                               value="` + data.project_start_date + `" readonly/>
                        ~ <input type="text" class="dateFmt" maxlength="10"
                                 name="projectList[].project_end_date"
                                 value="` + data.project_end_date + `" readonly/></td>
                    <td>
                        <input type="hidden" name="projectList[].assigned_task_lar" value="` + data.assigned_task_lar + `"/>
                        <select class="form-select" style="width: auto" disabled>
                                <option>` + data.assigned_task_lar_nm + `</option>
                        </select>
                        <input type="hidden" name="projectList[].assigned_task_mid" value="` + data.assigned_task_mid + `"/>
                        <select class="form-select" style="width: auto" disabled>
                                <option>` + data.assigned_task_mid_nm + `</option>
                        </select>
                    </td>
                    <td>
                        <input type="hidden" name="projectList[].project_role" value="` + data.project_role + `"/>
                        <select class="form-select" style="width: auto" disabled>
                                <option>` + data.project_role_nm + `</option>
                        </select>
                    <td>

                    </td>
                    <td>
                        <input type="button" class="btn btn-danger"
                               onclick="remove(this, 'new')" value="REMOVE"/>
                    </td>
                </tr>
        `;

        target.insertAdjacentHTML('beforeend', newRow);
        updateRowIndex(frmId, listNm);

    }

    function viewSkill(project_seq) {
        let user_id = $('input[name=user_id]').val();
        let flag = 1;
        let url = "/profile/project/modify/select/skill?user_id=" + user_id + "&project_seq=" + project_seq + "&flag=" + flag;
        let properties = "width=600, height=400";
        window.open(url, "viewSkill", properties)
    }

    function validateForm(frmId){
        if(frmId === "profile"){
            // 휴대폰번호 검증
            const phoneNum = $(".telFmt").val();
            if(!chkTel(phoneNum)){
                alert("휴대폰번호를 확인해주세요.");
                $(".telFmt").focus();
                return false;
            }
            // 학점 검증
            if (!validateGrades()) return false;
        }

        // 날짜 검증
        if(!validateDates(frmId)) return false;

        // 데이터 빈 값 검증
        if(!chkInputs(frmId)) return false;

        return true;
    }

    function validateGrades() {
        const chkArr = ["011", "012", "013"];
        let isValid = true;
        let cnt = 0;

        $(".schGb").each(function (){
            const schGbValue = $(this).val();
            if(chkArr.includes(schGbValue)){
                cnt++;
            }
        });
        if(cnt > 0){
            $(".grade").each(function(){
                const grade = $(this).val();
                if(!chkGrade(grade)){
                    alert("학점, 혹은 총점 입력값이 올바르지 않습니다");
                    $(this).focus();
                    isValid = false;
                    return false;
                }
            });
        } else {
            $(".grade").val('');
            $("#major").val('');
            $("#double_major").val('');
        }

        return isValid;
    }

    function validateDates(frmId){
        let isValidDates = true;
        $("#" + frmId).find(".dateFmt").each(function (){
            const date = $(this).val();
            if(!chkDate(date)){
                alert("입력일자를 확인해주세요");
                $(this).focus();
                isValidDates = false;
                return false;
            }
        });

        if(!isValidDates) return false;

        // 날짜 start_date < end_date && 날짜 빈값 검증
        if(!chkDateForm(frmId)) return false;

        return true;
    }

    function formatDates(frmId){
        // 날짜 포맷
        $("#" + frmId).find(".dateFmt").each(function () {
            const date = $(this).val().replaceAll('-', '');
            $(this).val(date);
        });
    }

    function formatPhone(){
        const phone = $(".telFmt").val().replaceAll('-', '');
        $(".telFmt").val(phone);
    }

    function buildUrl(frmId, userId){
        if (frmId == 'profile') {
            return "/profile/modify/save/" + userId;
        } else {
            return "/profile/" + frmId + "/modify/save/" + userId;
        }
    }

    function sendAjaxRequest(url, data){
        $.ajax({
            url: url,
            type: "POST",
            data: data,
            success: function (response) {
                if (response === "SUCCESS") {
                    alert("저장되었습니다.");
                    location.reload();
                } else {
                    alert("저장에 실패했습니다.");
                }
            },
            error: function () {
                alert("서버 오류가 발생했습니다. 다시 시도해 주세요.")
            }
        });
    }

    function goSave(frm) {
        let frmId = $(frm).data("name");

        // 검증 실패시 종료
        if(!validateForm(frmId)) return;

        // 날짜 포맷 변경
        formatDates(frmId);

        // 휴대폰 포맷 변경
        formatPhone();

        if(confirm("저장하시겠습니까?")){
            const frmData = $("#" + frmId).serialize();
            const userId = $('input[name=user_id]').val();
            const url = buildUrl(frmId, userId);

            sendAjaxRequest(url, frmData);
        }
    }

    function remove(ob, str) {
        let frmId = 'pjFrm';
        let listNm = 'projectList';
        if(str == 'new'){
            $(ob).closest(".add").remove();
            addCnt--;
            updateRowIndex(frmId, listNm);
        }else {
            $(ob).closest(".add").hide();
            let updateEl = $(ob).closest(".add").find(".useYn");
            updateEl.val('N');
        }
    }

    function selectTaskLar(ob){
        const parentId = $(ob).val();
        const url = "/profile/project/modify/select/task";
        const $subCategory = $(ob).next();

        // 중분류를 초기화 한다.
        $subCategory.empty().append('<option value="">-- 중분류 선택 --</option>');

        $.ajax({
            url: url,
            type: "GET",
            data: {code_id : parentId},
            dataType: 'json',
            success: function (response) {
                response.forEach( data => {
                    $subCategory.append('<option value="' + data.code_id + '">' + data.code_value + '</option>');
                });
            },
            error: function () {
                alert("서버 오류가 발생했습니다. 다시 시도해 주세요.")
            }
        });
    }

    // start_date, end_date에 대한 유효성 검사
    function compareDate(frm, startDt, endDt){
        let isValid = true;

        $("#" + frm).find(".add").each(function(i){
            if(!isValid) return false; // 이전 반복에서 실패하면 즉시 중단
            let startVal = null;
            let endVal = null;

            // 현재 항목의 input 요소 순회
            $(this).find("input").each(function(){
                const name = $(this).attr("name");

                if(name && name.endsWith(startDt)) {
                    startVal = $(this).val();
                    if(!startVal){
                        alert("입력값을 확인해주세요");
                        $(this).focus();
                        isValid = false;
                        return false; // 반복중단
                    }
                }
                if(name && name.endsWith(endDt)) {
                    endVal = $(this).val();
                    if(!endVal){
                        alert("입력값을 확인해주세요");
                        $(this).focus();
                        isValid = false;
                        return false; // 반복중단
                    }
                }
            });
            // 시작일과 종료일 비교
            if(startVal && endVal){
                const fmtStartDt = new Date(startVal);
                const fmtEndDt = new Date(endVal);
                if(fmtStartDt > fmtEndDt){
                    alert("입력날짜가 적합하지 않습니다.");
                    isValid = false;
                    return false; // 반복중단
                }
            }
        });
        return isValid;
    }

    function chkDateForm(frmId){
        let frm = null;
        if(frmId == "profile"){
            frm = { frmNm: "schFrm", startDt: "start_date", endDt: "end_date"}
        } else if(frmId == "qualification"){
            frm = { frmNm: "qlFrm", startDt: "acquisition_date", endDt: "expiry_date"}
        } else if(frmId == "workExperience"){
            frm = { frmNm: "workFrm", startDt: "work_start_date", endDt: "work_end_date"}
        } else { // project
            frm = { frmNm: "pjFrm", startDt: "project_start_date", endDt: "project_end_date"}
        }
        const isVaild = compareDate(frm.frmNm, frm.startDt, frm.endDt);
        if(!isVaild){
            return false;
        }
        return true;
    }

    // 빈 값에 대한 유효성 검사
    function chkInputs(frmId){
        let isValid = true;

        $("#" + frmId).find("input, select").each(function (){
            if(!isValid) return false;
            const name = $(this).attr("name");
            if(name){
                let input = $(this).val();
                console.log(name + " - " +input);
                const nullable = ['major', 'double_major', 'total_grade', 'standard_grade'];
                if(!nullable.includes(name) && input === ''){
                    alert("항목을 입력하세요");
                    $(this).focus();
                    isValid = false;
                    return false;
                }
            }
        });
        return isValid;
    }



</script>

</body>
</html>
