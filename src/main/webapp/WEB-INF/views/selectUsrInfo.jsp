<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<div class="content" tabindex="-1">
    <div class="container-md py-sm-2">
        <div class="container-info row-box row mb-0 g-0">
            <h2 class="header">기본정보</h2>
            <div class="py-3">
                <form>
                    <div class="col-sm-auto g-0">
                        <div class="row mb-2 g-0">
                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                <span>이름</span>
                                <input type="text" name="user_nm" value="${info.user_nm}" readonly>
                            </div>
                            <div class="col-sm-3 common-box input-box pt-4 me-2">
                                <span>소속</span>
                                <input type="text" name="user_department_nm" value="${info.user_department_nm}" readonly>
                            </div>
                            <div class="col-sm-2 common-box input-box pt-4 me-2">
                                <span>직급</span>
                                <input type="text" name="user_position_nm" value="${info.user_position_nm}" readonly>
                            </div>
                            <div class="col-sm-4 common-box input-box pt-4">
                                <span>수행경력</span>
                                <input type="text" class="fmt" name="project_totalMonth" value="${info.project_totalMonth}" readonly>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script src="//code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="/js/common.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        setTimeout(function () {
            const pj_totalMonth = $(".fmt").val().trim();
            const calc_pj_totalMonth = convertToString(pj_totalMonth);
            $(".fmt").val(calc_pj_totalMonth);
        }, 100); // 렌더링 지연 후 실행
    })

</script>
</html>
