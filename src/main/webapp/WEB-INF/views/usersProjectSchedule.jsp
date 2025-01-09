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
            <h2>프로젝트 일정관리</h2>
            <div class="input-group pb-2 justify-content-md-end">
                <div class="search-group gap-2">
                    <span class="align-content-center">시작일자</span>
                    <input type="date" name="project_start_date" class="dateFmt" value="${project_start_date}"/>
                    <span class="align-content-center">종료일자</span>
                    <input type="date" name="project_end_date" class="dateFmt" value="${project_end_date}"/>

                    <button type="button" id="find" class="btn btn-secondary"><span>검색</span>
                    </button>
                </div>
            </div>
            <div>
                <header class="description mb-sm-2 basic-medium">총 ${cnt}건</header>
                <div class="container-info mb-5">
                    <div class="table-responsive">
                        <table class="table table-hover mb-5">
                            <colgroup>
                                <col style="width: 5%;">
                                <%-- no --%>
                                <col style="width: auto;">
                                <%-- 사업명 --%>
                                <col style="width: 20%;">
                                <%-- 발주처 --%>
                                <col style="width: 10%;">
                                <%-- 사업시작일 --%>
                                <col style="width: 10%;">
                                <%-- 사업종료일 --%>
                            <colgroup>
                            <thead>
                            <tr>
                                <th scope="col">NO</th>
                                <th scope="col">사업명</th>
                                <th scope="col">발주처</th>
                                <th scope="col">사업시작일</th>
                                <th scope="col">사업종료일</th>
                            </tr>
                            </thead>
                            <tbody class="table-group-divider">
                            <c:forEach var="list" items="${list}" varStatus="status">
                                <tr style="cursor: pointer" onclick="goPopup('${list.project_nm}')">
                                    <td>${cnt - ((page.curPage -1) * page.pageSize + status.index)}</td>
                                    <td>${list.project_nm}</td>
                                    <td>${list.project_client}</td>
                                    <fmt:parseDate var="project_start_date" value="${list.project_start_date}"
                                                   pattern="yyyyMMdd"/>
                                    <fmt:formatDate value="${project_start_date}" pattern="yyyy-MM-dd"
                                                    var="project_start_date"/>
                                    <fmt:parseDate var="project_end_date" value="${list.project_end_date}"
                                                   pattern="yyyyMMdd"/>
                                    <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                    var="project_end_date"/>
                                    <td>${project_start_date}</td>
                                    <td>${project_end_date}</td>
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


    function goPopup(project_nm) {
        const project_start_date = $("input[name=project_start_date]").val();
        const project_end_date = $("input[name=project_end_date]").val();
        const url = "/schedule/info/" + encodeURIComponent(project_nm) + "?project_start_date=" + project_start_date + "&project_end_date=" + project_end_date;
        let properties = calcSize(700, 200);
        window.open(url, "usrInfo", properties);
    }

    function goFind() {
        $("input[name=curPage]").val(1);

        const frm = $("#frm");

        frm.attr('action', '/schedule/list');
        frm.attr('method', 'get');
        frm.submit();
    }

    function fn_paging(pageNum) {
        $("input[name=curPage]").val(pageNum);

        const frm = $("#frm");
        frm.attr('action', '/schedule/list');
        frm.attr('method', 'get');
        frm.submit();
    }

</script>

</body>
</html>
