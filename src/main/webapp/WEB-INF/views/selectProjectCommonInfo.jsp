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
            <h2>프로젝트 관리</h2>
            <div class="input-group pb-2 justify-content-md-end">
                <select name="searchType" class="search-type ps-3">
                    <option value="projectNm" <c:if test="${searchType eq 'projectNm'}">selected</c:if>>사업명</option>
                    <option value="client" <c:if test="${searchType eq 'client'}">selected</c:if>>발주처</option>
                    <option value="masterId" <c:if test="${searchType eq 'masterId'}">selected</c:if>>MASTER_ID</option>
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
                        <button type="button" class="btn btn-warning" onclick="register()"><span>등록</span></button>
                    </div>
                </header>
                <div class="container-info mb-5">
                    <div class="table-responsive">
                        <table class="table table-hover mb-5">
                            <colgroup>
                                <col style="width: 5%;">
                                <%-- no --%>
                                <col style="width: 10%;">
                                <%-- id --%>
                                <col style="width: 30%;">
                                <%-- 사업명 --%>
                                <col style="width: auto;">
                                <%-- 발주처 --%>
                                <col style="width: 10%;">
                                <%-- 사업시작일 --%>
                                <col style="width: 10%;">
                                <%-- 사업종료일 --%>
                                <col style="width: 8%;">
                                <%-- 사용여부 --%>
                            <colgroup>
                            <thead>
                            <tr>
                                <th scope="col">NO</th>
                                <th scope="col">MASTER_ID</th>
                                <th scope="col">사업명</th>
                                <th scope="col">발주처</th>
                                <th scope="col">사업시작일</th>
                                <th scope="col">사업종료일</th>
                                <th scope="col">사용여부</th>
                            </tr>
                            </thead>
                            <tbody class="table-group-divider">
                            <c:forEach var="list" items="${list}" varStatus="status">
                                <tr>
                                    <td>${cnt - ((page.curPage -1) * page.pageSize + status.index)}</td>
                                    <td>${list.master_id}</td>
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
                                    <td>
                                        <div class="form-check">
                                            <input class="form-check-input radio" type="radio"
                                                   name="use_yn_${status.index}"
                                                   id="use_yn_y${status.index}" value="Y"
                                            <c:if test="${list.use_yn eq 'Y'}"> checked</c:if>>
                                            <label class="form-check-label" for="use_yn_y${status.index}">
                                                Y
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input radio" type="radio"
                                                   name="use_yn_${status.index}"
                                                   id="use_yn_n${status.index}" value="N"
                                            <c:if test="${list.use_yn eq 'N'}"> checked</c:if>>
                                            <label class="form-check-label" for="use_yn_n${status.index}">
                                                N
                                            </label>
                                        </div>
                                    </td>
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

        $(document).on("keydown", ".searchInput", function (e) {
            if (e.which == 13) {
                e.preventDefault();
                $("#find").click();
            }
        });

        $("#find").on("click", function () {
            goFind();
        });

        let previousValue = {};

        $(".radio").mousedown(function () {
            let name = $(this).attr("name");
            previousValue[name] = $("input[name='" + name + "']:checked").val();
        });

        // 라디오 버튼 클릭
        $(".radio").click(function () {
            let name = $(this).attr("name");
            let clickYn = $(this).val(); // 클릭한 값
            let oriYn = previousValue[name];
            let master_id = $(this).closest("tr").find("input[name=master_id]").val();

            if (clickYn === oriYn) {
                alert("변경할 데이터가 없습니다.");
                return;
            }

            if (confirm("사용여부 변경시 모든 직원의 수행이력에 즉시 반영됩니다.\n변경하시겠습니까?")) {
                $.ajax({
                    url: "/project/common/update",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({
                        master_id: master_id,
                        use_yn: $("input[name='" + name + "']:checked").val()
                    }),
                    success: function () {
                        alert("변경되었습니다.");
                        window.location.reload();
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            } else {
                // 취소한 경우 이전 상태로 복원
                $("input[name='" + name + "']").each(function () {
                    if ($(this).val() == oriYn) {
                        $(this).prop("checked", true);
                    } else {
                        $(this).prop("checked", false);
                    }
                });
            }
        });
    });

    function register() {
        let url = "/project/common/register";
        let properties = calcSize(670, 200);
        // 팝업 열기
        window.open(url, "registerProject", properties);
    }

    function goFind() {
        $("input[name=curPage]").val(1);
        const frm = $("#frm");
        frm.find("input, select").each(function() {
            const name = $(this).attr("name");
            if (name !== "curPage" && name !== "searchType" && name !== "searchText") {
                $(this).remove();
            }
        });

        frm.attr('action', '/project/common/list');
        frm.attr('method', 'get');
        frm.submit();
    }

    function fn_paging(pageNum) {
        $("input[name=curPage]").val(pageNum);

        const frm = $("#frm");
        frm.find("input, select").each(function() {
            const name = $(this).attr("name");
            if (name !== "curPage" && name !== "searchType" && name !== "searchText") {
                $(this).remove();
            }
        });
        frm.attr('action', '/project/common/list');
        frm.attr('method', 'get');
        frm.submit();
    }

</script>

</body>
</html>
