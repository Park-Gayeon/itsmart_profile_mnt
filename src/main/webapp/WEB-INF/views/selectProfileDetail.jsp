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
                    <div class="description" style="position: relative; top: 0px">
                        <input type="button" class="btn btn-warning" onclick="excel()" value="EXCEL"/>
                        <input type="button" class="btn btn-warning" onclick="goModify()" value="EDT"/>
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
                                <input type="text" name="user_birth" id="user_birth" value="${profile.user_birth}"
                                       readonly/>
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label for="user_phone">휴대전화 <span class="star">*</span></label>
                                <input type="text" name="user_phone" id="user_phone" value="${profile.user_phone}"
                                       readonly/>
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label for="user_id">직원ID <span class="star">*</span></label>
                                <input type="text" name="user_id" id="user_id" value="${profile.user_id}" readonly/>
                            </div>
                            <div class="col-sm common-box common-box input-box pt-4 me-2">
                                <label for="user_email">이메일 <span class="star">*</span></label>
                                <input type="email" id="user_email" value="${profile.user_id}@itsmart.co.kr" readonly/>
                            </div>
                        </div>
                        <!-- 두번째 row -->
                        <div class="row mb-2 g-0">
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label for="user_department">소속 <span class="star">*</span></label>
                                <input type="hidden" name="user_department" value="${profile.user_department}">
                                <input type="text" name="user_department_nm" id="user_department"
                                       value="${profile.user_department_nm}" readonly/>
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label for="user_position">직위/직급 <span class="star">*</span></label>
                                <input type="hidden" name="user_position" value="${profile.user_position}">
                                <input type="text" name="user_position_nm" id="user_position"
                                       value="${profile.user_position_nm}" readonly/>
                            </div>
                            <div class="col-sm-2 common-box common-box input-box pt-4 me-2">
                                <label for="hire_date">입사일자 <span class="star">*</span></label>
                                <input type="text" name="hire_date" id="hire_date" value="${profile.hire_date}"
                                       readonly/>
                            </div>
                            <div class="col-sm common-box common-box input-box pt-4 me-2">
                                <label for="user_address">주소 <span class="star">*</span></label>
                                <input type="text" name="user_address" id="user_address" value="${profile.user_address}"
                                       readonly/>
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
                    <!-- 학력 -->
                    <div class="col-md g-0">
                        <c:forEach var="i" begin="1" end="3">
                            <c:set var="eduKey" value="edu${i}_school_name"/>
                            <c:if test="${profile[eduKey] ne ''}">
                            <!-- 첫번째 row -->
                            <div class="row mb-2 g-0">
                                <div class="col-sm-1 common-box input-box pt-4">
                                    <c:set var="gubunKey" value="edu${i}_gubun"/>
                                    <label>학교구분</label>
                                    <input type="text" name="edu${i}_gubun"
                                           value="${profile[gubunKey]}" readonly/>
                                </div>
                                <div class="col-sm-3 common-box input-box pt-4 me-2">
                                    <label>학교명</label>
                                    <input type="text" name="edu${i}_school_name"
                                           value="${profile[eduKey]}" readonly/>
                                </div>
                                <div class="col-sm-2 common-box input-box pt-4">
                                    <c:set var="startDateKey" value="edu${i}_start_date"/>
                                    <label>입학년월</label>
                                    <input type="text" name="edu${i}_start_date"
                                           value="${profile[startDateKey]}" readonly/>
                                </div>
                                <div class="col-sm-2 common-box input-box pt-4 me-2">
                                    <c:set var="endDateKey" value="edu${i}_end_date"/>
                                    <label>졸업년월</label>
                                    <input type="text" name="edu${i}_end_date"
                                           value="${profile[endDateKey]}" readonly/>
                                </div>
                                <div class="col-sm-1 common-box input-box pt-4 me-2">
                                    <c:set var="statusKey" value="edu${i}_grad_status"/>
                                    <label>졸업상태</label>
                                    <input type="text" name="edu${i}_grad_status"
                                           value="${profile[statusKey]}" readonly/>
                                </div>
                            </div>
                            </c:if>
                        </c:forEach>
                        <!-- 두번째 row -->
                        <div class="row mb-2 g-0" style="<c:if test="${profile.major eq ''}">display: none;</c:if>">
                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                <label for="major">전공명</label>
                                <input type="text" name="major" id="major" value="${profile.major}" readonly/>
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                <label for="double_major">복수전공명</label>
                                <input type="text" name="double_major" id="double_major" value="${profile.double_major}"
                                       readonly/>
                            </div>
                            <div class="col-sm-1 common-box input-box pt-4">
                                <label for="total_grade">학점</label>
                                <input type="text" name="total_grade" id="total_grade" value="${profile.total_grade}"
                                       readonly/>
                            </div>
                            <div class="col-sm-1 common-box input-box pt-4">
                                <label for="standard_grade">총점</label>
                                <input type="text" name="standard_grade" id="standard_grade"
                                       value="${profile.standard_grade}" readonly/>
                            </div>
                        </div>
                    </div>
                    <!-- 학력 끝 -->
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
                                           value="${qualification.qualification_nm}" readonly>
                                </div>
                                <div class="col-sm-2 common-box input-box pt-4 me-2">
                                    <label for="issuer">발행기관</label>
                                    <input type="text" name="qualificationList[${qlStatus.index}].issuer" id="issuer"
                                           value="${qualification.issuer}" readonly/>
                                </div>
                                <div class="col-sm-2 common-box input-box pt-4">
                                    <label for="acquisition_date">취득일자</label>
                                    <input type="text" name="qualificationList[${qlStatus.index}].acquisition_date"
                                           id="acquisition_date" t
                                           value="${qualification.acquisition_date}" readonly/>
                                </div>
                                <div class="col-sm-2 common-box input-box pt-4">
                                    <label for="expiry_date">만기일자</label>
                                    <input type="text" name="qualificationList[${qlStatus.index}].expiry_date"
                                           id="expiry_date"
                                           value="${qualification.expiry_date}" readonly/>
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
                        <header class="header">근무경력<span id="wk_career" class="fw-bolder" style="font-size: 12px;"></span>
                        </header>
                        <div class="col-md g-0">
                            <div class="row mb-2 g-0">
                                <c:forEach var="work" items="${profile.workExperienceList}" varStatus="wkStatus">
                                    <div class="col-sm-3 common-box input-box pt-4 me-2">
                                        <label for="work_place">회사명</label>
                                        <input type="text" name="workExperienceList[${wkStatus.index}].work_place"
                                               id="work_place" value="${work.work_place}"
                                               readonly/>
                                    </div>
                                    <div class="col-sm-2 common-box input-box pt-4">
                                        <label for="work_start_date">입사일자</label>
                                        <input type="text" name="workExperienceList[${wkStatus.index}].work_start_date"
                                               id="work_start_date"
                                               value="${work.work_start_date}" readonly/>
                                    </div>
                                    <div class="col-sm-2 common-box input-box pt-4">
                                        <label for="workExperienceList[${wkStatus.index}].work_end_date">퇴사일자</label>
                                        <input type="text" name="workExperienceList[${wkStatus.index}].work_end_date"
                                               id="work_end_date"
                                               value="${work.work_end_date}" readonly/>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <!-- 근무경력 form 끝-->
                    <!-- 사업경력 form -->
                    <div>
                        <header class="header">사업경력<span id="pj_career" class="fw-bolder" style="font-size: 12px;"></span>
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
                                            <input type="hidden" name="projectList[${pjStatus.index}].project_seq"
                                                   value="${project_ing.project_seq}"/>
                                            <input type="hidden" name="projectList[${pjStatus.index}].project_client"
                                                   value="${project_ing.project_client}"/>
                                            <input type="hidden" name="projectList[${pjStatus.index}].project_nm"
                                                   value="${project_ing.project_nm}"/>
                                            <input type="hidden"
                                                   name="projectList[${pjStatus.index}].project_start_date"
                                                   value="${project_ing.project_start_date}"/>
                                            <input type="hidden" name="projectList[${pjStatus.index}].project_end_date"
                                                   value="${project_ing.project_end_date}"/>
                                            <input type="hidden" name="projectList[${pjStatus.index}].assigned_task_lar"
                                                   value="${project_ing.assigned_task_lar}"/>
                                            <input type="hidden"
                                                   name="projectList[${pjStatus.index}].assigned_task_lar_nm"
                                                   value="${project_ing.assigned_task_lar_nm}"/>
                                            <input type="hidden" name="projectList[${pjStatus.index}].assigned_task_mid"
                                                   value="${project_ing.assigned_task_mid}"/>
                                            <input type="hidden"
                                                   name="projectList[${pjStatus.index}].assigned_task_mid_nm"
                                                   value="${project_ing.assigned_task_mid_nm}"/>
                                            <input type="hidden" name="projectList[${pjStatus.index}].project_role"
                                                   value="${project_ing.project_role}"/>
                                            <td>${count_ing}</td>
                                            <td>${project_ing.project_client}</td>
                                            <td>${project_ing.project_nm}</td>
                                            <td>${project_ing.project_start_date} ~ ${project_ing.project_end_date}</td>
                                            <td>${project_ing.assigned_task_lar_nm}
                                                > ${project_ing.assigned_task_mid_nm}</td>
                                            <td>${project_ing.project_role_nm}</td>
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
                                            <input type="hidden" name="projectList[${pjStatus.index}].project_seq"
                                                   value="${project_hist.project_seq}"/>
                                            <input type="hidden" name="projectList[${pjStatus.index}].project_client"
                                                   value="${project_hist.project_client}"/>
                                            <input type="hidden" name="projectList[${pjStatus.index}].project_nm"
                                                   value="${project_hist.project_nm}"/>
                                            <input type="hidden"
                                                   name="projectList[${pjStatus.index}].project_start_date"
                                                   value="${project_hist.project_start_date}"/>
                                            <input type="hidden" name="projectList[${pjStatus.index}].project_end_date"
                                                   value="${project_hist.project_end_date}"/>
                                            <input type="hidden"
                                                   name="projectList[${pjStatus.index}].assigned_task_lar_nm"
                                                   value="${project_hist.assigned_task_lar_nm}"/>
                                            <input type="hidden"
                                                   name="projectList[${pjStatus.index}].assigned_task_mid_nm"
                                                   value="${project_hist.assigned_task_mid_nm}"/>
                                            <input type="hidden" name="projectList[${pjStatus.index}].project_role"
                                                   value="${project_hist.project_role}"/>
                                            <td>${count_hist}</td>
                                            <td>${project_hist.project_client}</td>
                                            <td>${project_hist.project_nm}</td>
                                            <td>${project_hist.project_start_date}
                                                ~ ${project_hist.project_end_date}</td>
                                            <td>${project_hist.assigned_task_lar_nm}
                                                > ${project_hist.assigned_task_mid_nm}</td>
                                            <td>${project_hist.project_role_nm}</td>
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
    $(document).ready(function () {
        const wk_totalMonth = [[${wk_totalMonth}]];
        const pj_totalMonth = [[${pj_totalMonth}]];

        let calc_wk_totalMonth = convertToString(wk_totalMonth);
        let calc_pj_totalMonth = convertToString(pj_totalMonth);

        document.getElementById("wk_career").innerText = calc_wk_totalMonth;
        document.getElementById("pj_career").innerText = calc_pj_totalMonth;

    });

    function viewSkill(project_seq) {
        let user_id = $('input[name=user_id]').val();
        let url = "/profile/detail/skill/select?user_id=" + user_id + "&project_seq=" + project_seq;
        let properties = "width=600, height=400";
        window.open(url, "registerNewProfile", properties)
    }

    function excel() {
        alert("엑셀다운기능 준비중");
    }

    function goModify() {
        let frm = $("#frm");
        let user_id = $('input[name=user_id]').val();
        frm.attr('action', '/profile/modify/info/' + user_id);
        frm.attr('method', 'post');
        frm.submit();
    }

    function convertToString(totalMonth){
        const year = Math.floor(totalMonth / 12);
        const months = totalMonth % 12;

        let result = "";
        if(year > 0){
            result += year + '년 ';
        }
        if(months > 0){
            result += months + '개월';
        }
        return result;
    }
</script>

</body>
</html>
