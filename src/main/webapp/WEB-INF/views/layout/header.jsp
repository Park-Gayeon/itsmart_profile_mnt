<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
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
                    <div class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark" style="width: 280px;">
                        <!-- 사이드바 헤더 -->
                        <!-- TODO : 아이티스마트 로고 추가 -->
                        <a href="/"
                           class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
                            <img src="/image/arrow-through-heart.svg" alt="" width="32" height="32"
                                 class="bi pe-none me-2">
                            <strong>ITSMART</strong>
                        </a>
                        <!-- 사이드바 헤더 끝 -->
                        <hr>
                        <!-- 사이드바 BODY -->
                        <ul class="navbar-nav justify-content-end flex-grow-1 pe-3 mb-auto">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="/">HOME</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">직원 프로필관리</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">내 프로필관리</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">회사조직도</a>
                            </li>
                        </ul>
                        <!-- 사이드바 BODY 끝-->
                        <hr>
                        <div class="dropdown">
                            <a href="#"
                               class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <strong>${model.empName}</strong>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-dark text-small shadow">
                                <!-- TODO : login 페이지 이동 -->
                                <li><a class="dropdown-item" href="#">로그아웃
                                    <img src="/image/box-arrow-right.svg" alt="" class="bi pe-none me-2">
                                </a></li>
                            </ul>
                        </div>
                    </div>
                    <!-- 사이드바 끝 -->
                </div>
                <!-- 메뉴바 BODY 끝-->
            </div>
            <!-- 메뉴바 활성화 끝 -->
            <!-- NAV - LOGO -->
            <a class="navbar-brand" href="/">ITSMART LOGO</a>
            <!-- NAV - LOGO END -->
        </div>
    </nav>
</header>
