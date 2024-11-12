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
            <div class="modal-body py-3">
                <div class="container text-center">
                    <div class="col-md-auto g-0">
                    <c:forEach var="skill" items="${skill.skillList}">
                        <div class="col-sm-2 common-box common-box input-box">
                            <input type="text" style="text-align: center" name="skill_nm" value="${skill.skill_nm}" readonly/>
                        </div>
                    </c:forEach>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="window.close()">Close</button>
                <%--<button type="button" class="btn btn-primary" onclick="saveSkill()">Save</button>--%>
            </div>
        </div>
    </div>
</div>

<script src="//code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/js/bootstrap.bundle.js"></script>
<script type="text/javascript">
    function saveSkill(){
        if(confirm("저장하시겠습니까 ?")){
            alert("저장되었습니다. - 로직구현이전");
            window.close();
        }
    }
</script>
</body>
</html>
