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

<!-- main-content -->
<div class="content">
    <div class="container">
    <div class="container_org">
        <h2 class="text-center mb-5">조직도</h2>
        <div class="mb-sm-5 ps-sm-3">
            <c:forEach var="orgChart" items="${orgChart}">
                <div class="org-node" style="padding-left: ${orgChart.level * 50}px;">
                    <div class="org-title basic-bold" title="${orgChart.full_path}">
                        <c:set var="imgSrc"
                               value="${orgChart.childCnt > 0 ? (orgChart.code_id =='003' || orgChart.code_id =='004' ? '/images/caret-down.svg' : '/images/caret-down-fill.svg') : '/images/caret-right-fill.svg'}"/>
                        <c:if test="${orgChart.code_id ne '001'}">
                            <img src="${imgSrc}" alt="icon">
                        </c:if>
                            ${orgChart.hierarchy_value}
                    </div>
                    <div class="user-list">
                        <c:forEach var="users" items="${users}">
                            <c:if test="${orgChart.code_id == users.user_department}">
                                <div class="user-item">
                                    <span class="basic-medium">${users.user_nm}</span>
                                    <span class="basic-thin" style="font-size: 12px;"> ${users.user_position_nm}</span>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
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