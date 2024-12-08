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
<style>

    .container_org {
        max-width: 800px;
        margin: 0 auto;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }

    .org-node {
        padding: 10px 15px;
        display: flex;
    }

    .org-title {
        font-weight: bold;
        font-size: 18px;
        white-space: pre; /* 공백 유지 */
    }

    .user-list {
        margin-left: 20px;
        margin-top: 20px;
    }

    .user-item {
        padding: 2px 0;
    }
</style>
<body>
<!-- header.jsp -->
<%@ include file="layout/header.jsp" %>
<!-- header.jsp -->

<!-- main-content -->
<div class="content">
    <div class="container_org">
        <h1 style="text-align: center;">조직도</h1>
        <div style="padding-left: 20px;">
            <c:forEach var="orgChart" items="${orgChart}">
                <div class="org-node">
                    <div class="org-title">${orgChart.hierarchy_value}</div>
                    <div class="user-list">
                        <c:forEach var="users" items="${users}">
                            <c:if test="${orgChart.code_id == users.user_department}">
                                <div class="user-item">
                                    <span style="font-weight: bold; font-size: 15px;">${users.user_nm}</span><span
                                        style="font-size: 10px;"> ${users.user_position_nm}</span>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
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
    })


</script>

</body>
</html>