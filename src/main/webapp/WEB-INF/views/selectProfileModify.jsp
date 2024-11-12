<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <%-- 웹 앱 반응형 --%>
    <meta name="viewport" content="width=device-width" , initial-scale="1">
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
    <form id="frm">
        <div class="container">
            <!-- 인적사항 form -->
            <div class="form-floating pt-5">
                <h2 class="header">인적사항
                    <div class="description" style="position: relative; top: 0px"><span class="star">*</span> 필수 입력
                        정보입니다.
                        <input type="button" class="btn btn-warning" onclick="goSave()" value="SAVE"/>
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
                                <input type="text" name="user_birth" id="user_birth" value="${profile.user_birth}"/>
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label for="user_phone">휴대전화 <span class="star">*</span></label>
                                <input type="tel" name="user_phone" id="user_phone" value="${profile.user_phone}"/>
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label for="user_id">직원ID</label>
                                <input type="text" name="user_id" id="user_id" value="${profile.user_id}" readonly/>
                            </div>
                            <div class="col-sm common-box common-box input-box pt-4 me-2">
                                <label for="user_email">이메일</label>
                                <input type="email" id="user_email" value="${profile.user_id}@itsmart.co.kr" readonly/>
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
                                <input type="text" name="hire_date" id="hire_date" value="${profile.hire_date}"
                                       readonly/>
                            </div>
                            <div class="col-sm common-box common-box input-box pt-4 me-2">
                                <label for="user_address">주소 <span class="star">*</span></label>
                                <input type="text" name="user_address" id="user_address"
                                       value="${profile.user_address}"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 인적사항 form 끝 -->
            <!-- 학력 form -->
            <div class="form-floating">
                <h2 class="header">학력</h2>
                <div class="common-box row-box row mb-5 g-0">
                    <div class="col-md g-0">
                        <c:forEach var="i" begin="1" end="3">
                            <c:set var="eduKey" value="edu${i}_school_name"/>
                            <c:choose>
                                <c:when test="${not empty profile[eduKey]}">
                                    <!-- 첫번째 row -->
                                    <div class="row mb-2 g-0">
                                        <div class="col-sm-1 common-box input-box pt-4">
                                            <c:set var="gubunKey" value="edu${i}_gubun"/>
                                            <label">학교구분</label>
                                            <select class="form-select" style="width: 100px; font-size: 12px;" name="eduGubun${i}">
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
                                            <input type="text" name="edu${i}_school_name" id="edu${i}_school_name"
                                                   value="${profile[eduKey]}"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4">
                                            <c:set var="startDateKey" value="edu${i}_start_date"/>
                                            <label for="edu${i}_start_date">입학년월</label>
                                            <input type="text" name="edu${1}_start_date" id="edu${i}_start_date"
                                                   value="${profile[startDateKey]}"/>
                                        </div>
                                        <div class="col-sm-2 common-box input-box pt-4 me-2">
                                            <c:set var="endDateKey" value="edu${i}_end_date"/>
                                            <label for="edu${i}_end_date">졸업년월</label>
                                            <input type="text" name="edu${i}_end_date" id="edu${i}_end_date"
                                                   value="${profile[endDateKei]}"/>
                                        </div>
                                        <div class="col-sm-1 common-box input-box pt-4 me-2">
                                            <c:set var="statusKey" value="edu${i}_grad_status"/>
                                            <label>졸업상태</label>
                                            <select class="form-select" style="width: 100px; font-size: 12px" name="edu${i}_grad_status">
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
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="col-md g-0">
                                        <!-- 첫번째 row -->
                                        <div class="row mb-2 g-0">
                                            <div class="col-sm-1 common-box input-box pt-4">
                                                <label>학교구분</label>
                                                <select class="form-select" style="width: 100px; font-size: 12px" name="edu${i}_gubun">
                                                    <option value="010">고등학교</option>
                                                    <option value="011">대학교(2,3년)</option>
                                                    <option value="012">대학교(4년)</option>
                                                    <option value="013">대학원</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-3 common-box input-box pt-4 me-2">
                                                <label for="edu${i}_school_name">학교명</label>
                                                <input type="text" name="edu${i}_school_name" id="edu${i}_school_name"
                                                       value=""/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4">
                                                <label for="edu${i}_start_date">입학년월</label>
                                                <input type="text" name="edu${i}_start_date" id="edu${i}_start_date"
                                                       value=""/>
                                            </div>
                                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                                <label for="edu${i}_end_date">졸업년월</label>
                                                <input type="text" name="edu${i}_end_date" id="edu${i}_end_date"
                                                       value=""/>
                                            </div>
                                            <div class="col-sm-1 common-box input-box pt-4 me-2">
                                                <label>졸업상태</label>
                                                <select class="form-select" style="width: 100px; font-size: 12px"
                                                        name="edu${i}_grad_status">
                                                    <option value="001">졸업</option>
                                                    <option value="002">졸업예정</option>
                                                    <option value="003">재학중</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>

                    <!-- 두번째 row -->
                    <div class="row mb-2 g-0">
                        <div class="col-sm-3 common-box input-box pt-4 me-2">
                            <label for="major">전공명</label>
                            <input type="text" name="major" id="major" value="${profile.major}"/>
                        </div>
                        <div class="col-sm-3 common-box input-box pt-4 me-2">
                            <label for="double_major">복수전공명</label>
                            <input type="text" name="double_major" id="double_major"
                                   value="${profile.double_major}"/>
                        </div>
                        <div class="col-sm-1 common-box input-box pt-4">
                            <label for="total_grade">학점</label>
                            <input type="text" name="total_grade" id="total_grade" value="${profile.total_grade}"/>
                        </div>
                        <div class="col-sm-1 common-box input-box pt-4">
                            <label for="standard_grade">총점</label>
                            <input type="text" name="standard_grade" id="standard_grade"
                                   value="${profile.standard_grade}"/>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 학력 form 끝 -->

            <!-- 자격증 form -->
            <div class="form-floating">
                <h2 class="header">자격증</h2>
                <div class="common-box row-box row mb-5 g-0">
                    <div class="col-md g-0">
                        <div class="row mb-2 g-0">
                            <c:forEach var="qualification" items="${profile.qualificationList}" varStatus="qlStatus">
                                <div class="col-sm-2 common-box input-box pt-4 me-2">
                                    <label for="qualification_nm">자격증명</label>
                                    <input type="text" name="qualificationList[${qlStatus.index}].qualification_nm"
                                           id="qualification_nm"
                                           value="${qualification.qualification_nm}">
                                </div>
                                <div class="col-sm-2 common-box input-box pt-4 me-2">
                                    <label for="issuer">발행기관</label>
                                    <input type="text" name="qualificationList[${qlStatus.index}].issuer" id="issuer"
                                           value="${qualification.issuer}"/>
                                </div>
                                <div class="col-sm-2 common-box input-box pt-4">
                                    <label for="acquisition_date">취득일자</label>
                                    <input type="text" name="qualificationList[${qlStatus.index}].acquisition_date"
                                           id="acquisition_date"
                                           value="${qualification.acquisition_date}"/>
                                </div>
                                <div class="col-sm-2 common-box input-box pt-4">
                                    <label for="expiry_date">만기일자</label>
                                    <input type="text" name="qualificationList[${qlStatus.index}].expiry_date"
                                           id="expiry_date"
                                           value="${qualification.expiry_date}"/>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 자격증 form 끝 -->
            <!-- 경력 form -->
            <div class="form-floating">
                <h2 class="header">경력</h2>
                <div class="common-box row-box row mb-5 g-0">
                    <!-- 근무경력 form -->
                    <div class="pb-3">
                        <header class="header">근무경력<span class="fw-bolder" style="font-size: 12px;">(총 n년 n개월)</span>
                        </header>
                        <div class="col-md g-0">
                            <div class="row mb-2 g-0">
                                <c:forEach var="work" items="${profile.workExperienceList}" varStatus="wkStatus">
                                    <div class="col-sm-3 common-box input-box pt-4 me-2">
                                        <label for="work_place">회사명</label>
                                        <input type="text" name="workExperienceList[${wkStatus.index}].work_place"
                                               id="work_place"
                                               value="${work.work_place}"/>
                                    </div>
                                    <div class="col-sm-2 common-box input-box pt-4">
                                        <label for="work_start_date">입사일자</label>
                                        <input type="text" name="workExperienceList[${wkStatus.index}].work_start_date"
                                               id="work_start_date"
                                               value="${work.work_start_date}"/>
                                    </div>
                                    <div class="col-sm-2 common-box input-box pt-4">
                                        <label for="work_end_date">퇴사일자</label>
                                        <input type="text" name="workExperienceList[${wkStatus.index}].work_end_date"
                                               id="work_end_date"
                                               value="${work.work_end_date}"/>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <!-- 근무경력 form 끝-->
                    <hr>
                    <!-- 사업경력 form -->
                    <div>
                        <header class="header">사업경력<span class="fw-bolder" style="font-size: 12px;">(총 n년 n개월)</span>
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
                                    <col style="width: 10%;">
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
                                </tr>
                                </thead>
                                <tbody class="table-group-divider">
                                <c:set var="count_ing" value="1"/>
                                <c:forEach var="project_ing" items="${profile.projectList}" varStatus="pjStatus">
                                    <fmt:parseDate var="project_end_date" value="${project_ing.project_end_date}"
                                                   pattern="yyyyMMdd"/>
                                    <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                    var="project_end_date"/>
                                    <c:if test="${today <= project_end_date}">
                                        <tr>
                                            <td>${count_ing}</td>
                                            <input type="hidden" name="projectList[${pjStatus.index}].project_seq"
                                                   value="${project_ing.project_seq}"/>
                                            <td><input type="text" name="projectList[${pjStatus.index}].project_client"
                                                       value="${project_ing.project_client}"/></td>
                                            <td><input type="text" name="projectList[${pjStatus.index}].project_nm"
                                                       value="${project_ing.project_nm}"/></td>
                                            <td><input type="text"
                                                       name="projectList[${pjStatus.index}].project_start_date"
                                                       value="${project_ing.project_start_date}"/>
                                                ~ <input type="text"
                                                         name="projectList[${pjStatus.index}].project_end_date"
                                                         value="${project_ing.project_end_date}"/></td>
                                            <td>
                                                    <%--해당 구역은 ajax 개발 예정중 (업무분류)--%>
                                                <select class="form-select" style="width: auto"
                                                        name="projectList[${pjStatus.index}].assigned_task_lar_nm">
                                                    <c:forEach var="taskLarList" items="${taskLarList}">
                                                        <option value="${taskLarList.code_id}"
                                                                <c:if test="${taskLarList.code_id eq project_ing.assigned_task_lar}">selected</c:if>>${taskLarList.code_value}</option>
                                                    </c:forEach>
                                                </select>
                                                <select class="form-select" style="width: auto"
                                                        name="projectList[${pjStatus.index}].assigned_task_lar_nm">
                                                    <c:forEach var="taskLarList" items="${taskLarList}">
                                                        <option value="${taskLarList.code_id}"
                                                                <c:if test="${taskLarList.code_id eq project_ing.assigned_task_mid}">selected</c:if>>${taskLarList.code_value}</option>
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
                                    <col style="width: 10%;">
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
                                </tr>
                                </thead>
                                <tbody class="table-group-divider">
                                <c:set var="count_hist" value="1"/>
                                <c:forEach var="project_hist" items="${profile.projectList}" varStatus="pjStatus">
                                    <fmt:parseDate var="project_end_date" value="${project_hist.project_end_date}"
                                                   pattern="yyyyMMdd"/>
                                    <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                    var="project_end_date"/>
                                    <c:if test="${today > project_end_date}">
                                        <tr>
                                            <td>${count_hist}</td>
                                            <input type="hidden" name="projectList[${pjStatus.index}].project_seq"
                                                   value="${project_hist.project_seq}"/>
                                            <td><input type="text" name="projectList[${pjStatus.index}].project_client"
                                                       value="${project_hist.project_client}"/></td>
                                            <td><input type="text" name="projectList[${pjStatus.index}].project_nm"
                                                       value="${project_hist.project_nm}"/></td>
                                            <td><input type="text"
                                                       name="projectList[${pjStatus.index}].project_start_date"
                                                       value="${project_hist.project_start_date}"/>
                                                ~ <input type="text"
                                                         name="projectList[${pjStatus.index}].project_end_date"
                                                         value="${project_hist.project_end_date}"/></td>
                                            <td>
                                                    <%--해당 구역은 ajax 개발 예정중 (업무분류)--%>
                                                <select class="form-select" style="width: auto"
                                                        name="projectList[${pjStatus.index}].assigned_task_lar_nm">
                                                    <c:forEach var="taskLarList" items="${taskLarList}">
                                                        <option value="${taskLarList.code_id}"
                                                                <c:if test="${taskLarList.code_id eq project_hist.assigned_task_lar}">selected</c:if>>${taskLarList.code_value}</option>
                                                    </c:forEach>
                                                </select>
                                                <select class="form-select" style="width: auto"
                                                        name="projectList[${pjStatus.index}].assigned_task_lar_nm">
                                                    <c:forEach var="taskLarList" items="${taskLarList}">
                                                        <option value="${taskLarList.code_id}"
                                                                <c:if test="${taskLarList.code_id eq project_hist.assigned_task_mid}">selected</c:if>>${taskLarList.code_value}</option>
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
                                        </tr>
                                        <c:set var="count_hist" value="${count_hist+1}"/>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- 사업경력 form 끝-->
                </div>
            </div>
        </div>
    </form>
</div>
<!-- 자격증 form 끝 -->


</div>
<!-- main-content -->

<!-- footer.jsp -->
<%@ include file="layout/footer.jsp" %>
<!-- footer.jsp -->
<script src="//code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.bundle.js"></script>
<script type="text/javascript">

    function viewSkill(project_seq) {
        let user_id = $('input[name=user_id]').val();
        let url = "/profile/detail/skill/select?user_id=" + user_id + "&project_seq=" + project_seq;
        let properties = "width=600, height=400";
        window.open(url, "registerNewProfile", properties)
    }

    function goSave() {
        if (confirm("저장하시겠습니까?")) {
            alert("구현중입니다.");
        }
    }
</script>

</body>
</html>