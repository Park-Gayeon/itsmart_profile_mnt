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
    <link rel="stylesheet" href="/css/org.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <title>직원 프로필관리 시스템</title>
</head>
<body>
<!-- header.jsp -->
<%@ include file="layout/header.jsp" %>
<!-- header.jsp -->

<!-- main-content -->
<div class="content">
    <div class="container py-md-5 my-md-5">
        <div class="container_org">
            <h2 class="text-center mb-5">조직도</h2>
            <div class="mb-sm-5 ps-sm-3">
                <c:forEach var="orgChart" items="${orgChart}">
                    <div class="org-node" style="padding-left: ${orgChart.level * 50}px;" data-level="${orgChart.level}"
                         data-codeid="${orgChart.code_id}" data-parentid="${orgChart.parent_id}">
                        <div class="org-title basic-bold" title="${orgChart.full_path}" onclick="toggleOrg(this)">
                            <img class="toggle-icon" src="" alt="toggle-icon">
                            <%--<c:set var="imgSrc"
                                   value="${orgChart.childCnt > 0 ? (orgChart.code_id =='003' || orgChart.code_id =='004' ? '/images/caret-down.svg' : '/images/caret-down-fill.svg') : '/images/caret-right-fill.svg'}"/>
                            <c:if test="${orgChart.code_id ne '001'}">
                                <img src="${imgSrc}" alt="icon">
                            </c:if>--%>
                            ${orgChart.hierarchy_value}
                        </div>
                        <div class="user-list">
                            <c:forEach var="users" items="${users}">
                                <c:if test="${orgChart.code_id == users.user_department}">
                                    <div class="user-item">
                                        <span class="basic-medium">${users.user_nm}</span>
                                        <span class="basic-thin"> ${users.user_position_nm}</span>
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
        $(".org-node").each(function() {
            updateToggleIcon($(this));
        });
    })

    function updateToggleIcon(element) { // 'org-node'
        const $icon = $(element).find(".toggle-icon");
        const hasUserList = $(element).find(".user-list").length > 0;
        const isHidden = $(element).find(".user-list").hasClass('hidden');
        const hasChildNodes = $(".org-node").filter(function() {
            return $(this).data('parentid') === $(element).data('codeid');
        }).length > 0;

        if(hasChildNodes){
            if(isHidden){
                $icon.attr('src', '/images/caret-down-fill.svg');
            } else {
                $icon.attr('src', '/images/caret-down.svg');
            }
        } else {
            if(hasUserList && isHidden){
                $icon.attr('src', '/images/caret-right-fill.svg');
            } else {
                $icon.attr('src', '/images/caret-right.svg');
            }
        }
    }

    function toggleOrg(element) {

        const $userList = $(element).next();
        if ($userList.hasClass('hidden')) {
            $userList.removeClass('hidden').addClass('visible_usr');
        } else {
            $userList.removeClass('visible_usr').addClass('hidden');
        }

        const $parent = $(element).closest(".org-node");
        const isHidden = $parent.next().hasClass('hidden');

        const toggleChildren = function (parentCodeId, parentLevel, hiddenState) {
            $(".org-node").each(function () {
                const $currentNode = $(this);
                const currentParentId = $currentNode.data('parentid');
                const currentLevel = $currentNode.data('level');

                if (currentParentId == parentCodeId && currentLevel > parentLevel) {
                    // 상태 토글을 올바르게 적용
                    if (hiddenState) {
                        $currentNode.removeClass('visible').addClass('hidden');
                        $currentNode.find(".user-list").removeClass('visible_usr').addClass('hidden');
                    } else {
                        $currentNode.removeClass('hidden').addClass('visible');
                        $currentNode.find(".user-list").removeClass('hidden').addClass('visible_usr');
                    }

                    toggleChildren($currentNode.data('codeid'), currentLevel, hiddenState); // 재귀적으로 하위 노드들도 같은 상태를 적용
                }
            });
        };

        // 클릭된 요소 상태에 따라 하위 요소의 숨기기/보이기 동작을 설정
        toggleChildren($parent.data('codeid'), $parent.data('level'), !isHidden);
        updateToggleIcon($parent);
    }


</script>

</body>
</html>