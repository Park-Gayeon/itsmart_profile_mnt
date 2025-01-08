<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <%-- 웹 앱 반응형 --%>
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/basic.css">
    <link rel="stylesheet" href="/css/info.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <title>직원 프로필관리 시스템</title>
</head>
<body>
<!-- header.jsp -->
<%@ include file="layout/header.jsp" %>
<!-- header.jsp -->

<!-- main-content -->
<div class="content">
    <form id="frm">
        <div class="container-md pt-3 mb-md-5">
            <h2>직원 프로필관리</h2>
            <div class="input-group pb-2 justify-content-md-end">
                <select name="searchType" class="search-type ps-3">
                    <option value="userNm" <c:if test="${searchType eq 'userNm'}">selected</c:if>>이름</option>
                    <option value="userId" <c:if test="${searchType eq 'userId'}">selected</c:if>>ID</option>
                    <option value="userDepartment" <c:if test="${searchType eq 'userDepartment'}">selected</c:if>>소속
                    </option>
                </select>
                <div class="search-group">
                    <input type="text" name="searchText" class="search-input px-sm-3 searchInput" value="${searchText}"
                           maxlength="30"/>
                    <button type="button" id="find" class="btn btn-secondary"><span>검색</span>
                    </button>
                </div>
            </div>
            <div>
                <header class="description mb-sm-2 basic-medium">총 ${cnt}건
                    <div class="primary-btn">
                        <button type="button" class="btn btn-secondary" onclick="excel()"><span>엑셀</span></button>
                        <button type="button" class="btn btn-warning" onclick="register()"><span>신규등록</span></button>
                    </div>
                </header>
                <div class="container-info mb-5">
                    <div class="table-responsive">
                        <table class="table table-hover mb-5">
                            <colgroup>
                                <col style="width: 3%;">
                                <%-- no --%>
                                <col style="width: 7%;">
                                <%-- 이름 --%>
                                <col style="width: 10%;">
                                <%-- 소속 --%>
                                <col style="width: 7%;">
                                <%-- 직책 --%>
                                <col style="width: 10%;">
                                <%-- 발주처 --%>
                                <col style="width: auto;">
                                <%-- 사업명 --%>
                                <col style="width: 15%;">
                                <%-- 사업기간 --%>
                                <col style="width: 10%;">
                                <%-- 수행경력 --%>
                                <col style="width: 5%;">
                                <%-- 자격증여부 --%>
                            <colgroup>
                            <thead>
                            <tr>
                                <th scope="col">NO</th>
                                <th scope="col">이름</th>
                                <th scope="col">소속</th>
                                <th scope="col">직급</th>
                                <th scope="col">발주처</th>
                                <th scope="col">사업명</th>
                                <th scope="col">사업기간</th>
                                <th scope="col">수행경력</th>
                                <th scope="col">자격증</th>
                            </tr>
                            </thead>
                            <tbody class="table-group-divider">
                            <c:forEach var="info" items="${info}" varStatus="status">
                                <tr style="cursor: pointer" onclick="goDetail('${info.user_id}')">
                                    <td>${cnt - ((page.curPage -1) * page.pageSize + status.index)}</td>
                                    <td>${info.user_nm}</td>
                                    <td>${info.user_department_nm}</td>
                                    <td>${info.user_position_nm}</td>
                                    <td>${info.project_client}</td>
                                    <td>${info.project_nm}</td>
                                    <c:choose>
                                        <c:when test="${info.project_start_date != null}">
                                            <fmt:parseDate var="project_start_date" value="${info.project_start_date}"
                                                           pattern="yyyyMMdd"/>
                                            <fmt:formatDate value="${project_start_date}" pattern="yyyy-MM-dd"
                                                            var="project_start_date"/>
                                            <fmt:parseDate var="project_end_date" value="${info.project_end_date}"
                                                           pattern="yyyyMMdd"/>
                                            <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                            var="project_end_date"/>
                                            <td>${project_start_date} ~ ${project_end_date}</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td></td>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${info.project_totalMonth != null && info.project_totalMonth != 0}">
                                            <td class="fmt">${info.project_totalMonth}</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td></td>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${info.qualification_yn eq 1}">
                                            <td class="text-center">Y</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td></td>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <hr>
                        <input type="hidden" name="curPage"/>
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <li class="page-item">
                                    <c:choose>
                                        <c:when test="${page.curRange ne 1}">
                                            <a class="page-link" href="#" aria-label="Previous"
                                               onClick="fn_paging(${page.startPage - 1})">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="page-link disabled" href="#" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                                <c:forEach var="pageNum" begin="${page.startPage}" end="${page.endPage}">
                                    <li class="page-item">
                                        <c:choose>
                                            <c:when test="${pageNum eq page.curPage}">
                                                <a class="page-link disabled" style="background-color: #fff;" href="#"
                                                   onClick="fn_paging('${pageNum}')">${pageNum}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="page-link" href="#"
                                                   onClick="fn_paging('${pageNum}')">${pageNum}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </c:forEach>
                                <li class="page-item">
                                    <c:choose>
                                        <c:when test="${page.curRange ne page.rangeCnt && page.rangeCnt > 1}">
                                            <a class="page-link" href="#" aria-label="Next"
                                               onClick="fn_paging(${page.endPage + 1})">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="page-link disabled" href="#" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
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
        const user_role = `${userRole[0]}`;
        if (user_role === 'ROLE_USER') {
            alert("접근권한이 없습니다");
            window.location.href = "/home";
        }
        setTimeout(function () {
            $(".fmt").each(function () {
                let pj_totalMonth = $(this).text().trim();
                let calc_pj_totalMonth = convertToString(pj_totalMonth);
                $(this).text(calc_pj_totalMonth);
            });
        }, 100); // 렌더링 지연 후 실행


        $(document).on("keydown", ".searchInput", function (e) {
            if (e.which == 13) {
                e.preventDefault();
                $("#find").click();
            }
        });

        $("#find").on("click", function () {
            goFind();
        })
    });

    function register() {
        let url = "/profile/info/register";
        let properties = calcSize(1000, 450);
        // 팝업 열기
        window.open(url, "registerUser", properties);
    }

    function goDetail(user_id) {
        const userId = user_id;
        const url = "/profile/" + userId;
        window.location.href = url;
    }

    function goFind() {
        $("input[name=curPage]").val(1);
        const frm = $("#frm");

        frm.attr('action', '/profile/info/list');
        frm.attr('method', 'get');
        frm.submit();
    }

    function fn_paging(pageNum) {
        $("input[name=curPage]").val(pageNum);

        const frm = $("#frm");
        frm.attr('action', '/profile/info/list');
        frm.attr('method', 'get');
        frm.submit();
    }

    function excel() {
        fetch("/excel/info/download", {
            method: 'POST'
        }).then(response => {
            if (!response.ok) { // HTTP 상태 코드가 200-299 범위에 없을 경우
                return response.text().then(errorMessage => {
                    throw new Error(errorMessage); // 서버에서 반환한 에러 메세지
                })
            }
            return response.blob(); // Blob 데이터 반환
        }).then(blob => {
            // Blob 데이터를 URL 객체로 변환
            const url = window.URL.createObjectURL(blob);
            // 다운로드 링크 생성 및 클릭 이벤트 실행
            const a = document.createElement('a');
            a.style.display = 'none';
            a.href = url;
            a.download = "profile_list.xlsx"; // 다운로드할 파일 이름 설정
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(url);// URL 객체 해제
        }).catch(error => {
            // 오류 발생
            alert(error);
        })
    }

</script>

</body>
</html>
