<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <%-- 웹 앱 반응형 --%>
    <meta name="viewport" content="width=device-width" , initial-scale="1">
    <link rel="stylesheet" href="/css/bootstrap.css">
    <link rel="stylesheet" href="/css/basic.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <title>직원 프로젝트 기술</title>
</head>
<body>


<div class="content" tabindex="-1">
    <div class="container pb-0">
        <div class="common-box row-box row mb-0 g-0">
            <div class="modal-header">
                <h5 class="modal-title">직원 기술</h5>
            </div>
            <div class="modal-body" style="padding-top: 15px">
                <div class="container text-center">
                    <div class="col-md-auto g-0">
                    <c:forEach var="skill" items="${skill.skillList}">
                        <div class="col-sm-2 common-box common-box input-box" style="display: block;">
                            <input type="text" style="text-align: center" name="skill_nm" value="${skill.skill_nm}"/>
                        </div>
                    </c:forEach>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>


<script src="/js/bootstrap.bundle.js"></script>
</body>
</html>
