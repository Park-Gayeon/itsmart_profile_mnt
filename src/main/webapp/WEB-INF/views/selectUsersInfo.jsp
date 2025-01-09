<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/basic.css">
    <link rel="stylesheet" href="/css/pop.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <title>투입인력 기본정보</title>
</head>
<body>
<div id="content" class="content" tabindex="-1">
    <div class="container-md py-sm-2">
        <div class="container-info row-box row mb-0 g-0">
            <h2 class="header">투입인력</h2>
            <div class="py-3">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <colgroup>
                            <col style="width: 5%;">
                            <col style="width: 10%;">
                            <col style="width: 10%;">
                            <col style="width: 10%;">
                            <col style="width: 10%;">
                            <col style="width: 10%;">
                            <col style="width: 10%;">
                        </colgroup>
                        <thead>
                        <th scope="col">NO</th>
                        <th scope="col">이름</th>
                        <th scope="col">소속</th>
                        <th scope="col">직급</th>
                        <th scope="col">수행경력</th>
                        <th scope="col">투입시작일</th>
                        <th scope="col">투입종료일</th>
                        </thead>
                        <tbody class="table-group-divider">
                        <c:forEach var="info" items="${info}" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${info.user_nm}</td>
                                <td>${info.user_department_nm}</td>
                                <td>${info.user_position_nm}</td>
                                <td class="fmt">${info.project_totalMonth}</td>
                                <fmt:parseDate var="project_start_date" value="${info.project_start_date}"
                                               pattern="yyyyMMdd"/>
                                <fmt:formatDate value="${project_start_date}" pattern="yyyy-MM-dd"
                                                var="project_start_date"/>
                                <fmt:parseDate var="project_end_date" value="${info.project_end_date}"
                                               pattern="yyyyMMdd"/>
                                <fmt:formatDate value="${project_end_date}" pattern="yyyy-MM-dd"
                                                var="project_end_date"/>
                                <td>${project_start_date}</td>
                                <td>${project_end_date}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="//code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/js/common.js"></script>
<script type="text/javascript">
    $(document).ready(function () {

        /* 동적으로 팝업 높이 조절 */
        let strWidth;
        let strHeight;

        if(window.innerWidth && window.innerHeight &&
        window.outerWidth && window.outerHeight){
            strWidth = $("#content").outerWidth() + (window.outerWidth - window.innerWidth);
            strHeight = $("#content").outerHeight() + (window.outerHeight - window.innerHeight);
        }
        else {
            let strDocumentWidth = $(document).outerWidth();
            let strDocumentHeight = $(document).outerHeight();
            window.resizeTo(strDocumentWidth, strDocumentHeight);

            let strMenuWidth = strDocumentWidth - $(window).width();
            let strMenuHeight = strDocumentHeight - $(window).height();

            strWidth = $("#content").outerWidth() + strMenuWidth;
            strHeight = $("content").outerHeight() + strMenuHeight;
        }
        window.resizeTo(strWidth, strHeight);

        setTimeout(function () {
            $(".fmt").each(function () {
                const pj_totalMonth = $(this).text().trim();
                const calc_pj_totalMonth = convertToString(pj_totalMonth);
                $(this).text(calc_pj_totalMonth);
            });
        }, 100); // 렌더링 지연 후 실행
    });

</script>
</html>
