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
            <div>
                <select name="searchType">
                    <option value="userNm"<c:if test="${searchType eq 'userNm'}">selected</c:if>>이름</option>
                    <option value="userId"<c:if test="${searchType eq 'userId'}">selected</c:if>>ID</option>
                    <option value="userDepartment"<c:if test="${searchType eq 'userDepartment'}">selected</c:if>>소속</option>
                </select>
                <input type="text" name="searchText" value="${searchText}"/>
                <input type="button" value="FIND" onclick="goFind()"/>
            </div>
            <div>
                <input type="button" class="btn btn-warning" onclick="register()" value="register"/>
                <input type="button" class="btn btn-warning" value="excel"/>
            </div>
            <div>
                <header>총 ${cnt}건</header>
                <table class="table table-hover mb-5">
                    <colgroup>
                        <col style="width: 15%;">
                        <col style="width: 30%;">
                        <col style="width: 20%;">
                        <col style="width: auto;">
                        <col style="width: 5%;">
                        <col style="width: 10%;">
                    <colgroup>
                    <thead>
                    <tr>
                        <th scope="col">NO</th>
                        <th scope="col">이름</th>
                        <th scope="col">소속</th>
                        <th scope="col">사업명</th>
                        <th scope="col">사업기간</th>
                        <th scope="col">발주처</th>
                    </tr>
                    </thead>
                    <tbody class="table-group-divider">
                    <c:forEach var="info" items="${info}">
                        <tr style="cursor:pointer;" onclick="goDetail('${info.user_id}')">
                            <td>${info.idx}</td>
                            <td>${info.user_nm}</td>
                            <td>${info.user_department_nm}</td>
                            <td>${info.project_nm}</td>
                            <td>${info.project_start_date} ~ ${info.project_end_date}</td>
                            <td>${info.project_client}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
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
    $(document).ready(function (){
        const user_role = `${userRole[0]}`;
        if(user_role === 'ROLE_USER'){
            alert("접근권한이 없습니다");
            window.location.href = "/home";
        }
    });

    function register(){
        let url = "/profile/info/register";
        let properties ="width=1000, height=400"
        window.open(url, "registerUser", properties);
    }

    function goDetail(user_id){
        const userId = user_id;
        const url = "/profile/" + userId;
        window.location.href = url;
    }

    function goFind(){
        const frm = $("#frm");
        frm.attr('action', '/profile/info/list');
        frm.attr('method', 'get');
        frm.submit();
    }

</script>

</body>
</html>
