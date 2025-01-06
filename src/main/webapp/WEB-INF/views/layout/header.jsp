<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header id="hd" class="d-flex flex-wrap justify-content-center">
    <nav class="navbar navbar-dark bg-dark fixed-top">
        <div class="container-fluid">
            <!-- NAV - 메뉴바 토글 -->
            <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas"
                    data-bs-target="#offcanvasDarkNavbar" aria-controls="offcanvasDarkNavbar"
                    aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!-- NAV - 메뉴바 토글 END -->
            <!-- 메뉴바 활성화 -->
            <div class="offcanvas offcanvas-start text-bg-dark" tabindex="-1" id="offcanvasDarkNavbar"
                 aria-labelledby="offcanvasDarkNavbarLabel">
                <!-- 메뉴바 HEADER -->
                <div class="offcanvas-header">
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"
                            aria-label="Close"></button>
                </div>
                <!-- 메뉴바 HEADER END -->
                <!-- 메뉴바 BODY -->
                <div class="offcanvas-body">
                    <!-- 사이드바 -->
                    <div class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark">
                        <!-- 사이드바 BODY -->
                        <ul class="navbar-nav justify-content-end flex-grow-1 pe-3 mb-5">
                            <li class="nav-item">
                                <a class="nav-link active" href="/home">HOME</a>
                            </li>
                            <c:if test="${userRole[0] eq 'ROLE_ADMIN'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="/profile/info/list">직원 프로필관리</a>
                                </li>
                            </c:if>
                            <li class="nav-item">
                                <a class="nav-link" href="/profile/${loginUser}">내 프로필관리</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/orgChart">회사조직도</a>
                            </li>
                        </ul>
                        <!-- 사이드바 BODY 끝-->
                        <hr>
                        <!-- drop down -->
                        <div class="dropdown">
                            <a href="#"
                               class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
                               data-bs-toggle="dropdown" data-bs-auto-close="true" aria-expanded="false">
                                <strong>${loginUser}</strong>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-dark text-small shadow">
                                <li><a class="dropdown-item" style="cursor:pointer;" onclick="changePw(`${loginUser}`)">비밀번호변경</a></li>
                                <li><a class="dropdown-item" style="cursor:pointer;" onclick="logout()">로그아웃</a></li>
                            </ul>
                        </div>
                        <!-- drop down 끝 -->
                    </div>
                    <!-- 사이드바 끝 -->
                </div>
                <!-- 메뉴바 BODY 끝-->
            </div>
            <!-- 메뉴바 활성화 끝 -->
            <!-- NAV - LOGO -->
            <a href="/home"
               class="navbar-brand">
                <img src="/images/itsmart_logo.png" style="width: auto; height: 40px;" class="bi pe-none me-2">
            </a>
            <!-- NAV - LOGO END -->
        </div>
    </nav>
</header>
