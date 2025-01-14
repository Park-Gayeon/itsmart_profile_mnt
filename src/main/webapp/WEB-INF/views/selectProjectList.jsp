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
    <link rel="stylesheet" href="/css/pop.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <title>프로젝트 불러오기</title>
</head>
<body>
<!-- main-content -->
<div class="content">
    <form id="frm">
        <div class="container-md pt-3 mb-md-5">
            <div>
                <div class="container-info mb-5">
                    <h2 class="header">불러오기
                        <div class="description">
                            <button type="button" class="btn btn-success" onclick="sendDataToParent()"><span>저장</span>
                            </button>
                        </div>
                    </h2>
                    <div class="input-group pb-2 justify-content-sm-end">
                        <select name="searchType" class="search-type ps-3">
                            <option value="projectNm" <c:if test="${searchType eq 'projectNm'}">selected</c:if>>
                                사업명
                            </option>
                            <option value="client" <c:if test="${searchType eq 'client'}">selected</c:if>>발주처
                            </option>
                        </select>
                        <div class="search-group">
                            <input type="text" name="searchText" class="search-input px-sm-3 searchInput"
                                   value="${searchText}"
                                   maxlength="30"/>
                            <button type="button" id="find" class="btn btn-secondary"><span>검색</span>
                            </button>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover mb-5">
                            <colgroup>
                                <col style="width: 5%;">
                                <%-- radio --%>
                                <col style="width: 5%;">
                                <%-- no --%>
                                <col style="width: 35%;">
                                <%-- 사업명 --%>
                                <col style="width: 25%;">
                                <%-- 발주처 --%>
                                <col style="width: 15%;">
                                <%-- 사업시작일 --%>
                                <col style="width: 15%;">
                                <%-- 사업종료일 --%>
                            <colgroup>
                            <thead>
                            <tr>
                                <th scope="col"></th>
                                <th scope="col">NO</th>
                                <th scope="col">사업명</th>
                                <th scope="col">발주처</th>
                                <th scope="col">사업시작일</th>
                                <th scope="col">사업종료일</th>
                            </tr>
                            </thead>
                            <tbody class="table-group-divider">
                            <input type="hidden" id="project_seq" name="project_seq" value="${maxSeq}"/>
                            <input type="hidden" name="user_id" value="${userId}"/>
                            <c:forEach var="list" items="${list}" varStatus="status">
                                <tr>
                                    <td>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="select"/>
                                        </div>
                                    </td>
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
                                    <input type="hidden" name="master_id" value="${list.master_id}"/>
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

    function goFind() {
        $("input[name=curPage]").val(1);
        const frm = $("#frm");
        frm.find("input, select").each(function () {
            const name = $(this).attr("name");
            if (name !== "curPage" && name !== "searchType" && name !== "searchText" && name !== "user_id") {
                $(this).remove();
            }
        });

        frm.attr('action', '/project/common/getList');
        frm.attr('method', 'get');
        frm.submit();
    }

    function fn_paging(pageNum) {
        $("input[name=curPage]").val(pageNum);

        const frm = $("#frm");
        frm.find("input, select").each(function () {
            const name = $(this).attr("name");
            if (name !== "curPage" && name !== "searchType" && name !== "searchText" && name !== "user_id") {
                $(this).remove();
            }
        });
        frm.attr('action', '/project/common/getList');
        frm.attr('method', 'get');
        frm.submit();
    }

    function sendDataToParent() {
        let selectTr = $("input[type=radio]:checked").closest("tr");

        let rowData = [];
        selectTr.find("td").each(function () {
            if ($(this).children().first().is(".form-check")) {
                return; // 라디오 버튼을 포함한 td는 건너뜀
            }
            rowData.push($(this).text().trim());
        });
        rowData.push(selectTr.find("input[name=master_id]").val());

        const project_seq = $("input[name=project_seq]").val();
        const project_nm = rowData[1];
        const project_client = rowData[2];
        const project_start_date = rowData[3];
        const project_end_date = rowData[4];
        const master_id = rowData[5];

        const data = {
            project_seq: project_seq,
            project_nm: project_nm,
            project_client: project_client,
            project_start_date: project_start_date,
            project_end_date: project_end_date,
            master_id: master_id,
            flag: "new",
            addCnt: 1
        };

        window.opener.addProjectRow(data);
        window.close();
    }

</script>

</body>
</html>
