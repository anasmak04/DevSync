<!---<html>

<head>
    <title>Login</title>
</head>

<body>
    <h1>Login</h1>
    <form action="login" method="post">
        <label for="email">Username:</label>
        <input type="email" id="email" name="email" required>
        <br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>
        <br>
        <input type="submit" value="Login">
    </form>
</body>

</html>
-->

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link
            href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700"
            rel="stylesheet"
    />
    <link
            rel="stylesheet"
            href="vue-toast-notification/dist/theme-default.css"
    />

    <link href="https://rsms.me/inter/inter-ui.css" rel="stylesheet" />

    <!-- Nucleo Icons -->
    <link href="${pageContext.request.contextPath}/public/css/nucleo-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/public/assetsAuth/css/nucleo-svg.css" rel="stylesheet" />
    <!-- Font Awesome Icons -->
    <script
            src="https://kit.fontawesome.com/42d5adcbca.js"
            crossorigin="anonymous"
    ></script>
    <link href="${pageContext.request.contextPath}/public/css/nucleo-svg.css" rel="stylesheet" />
    <!-- CSS Files -->
    <link
            id="pagestyle"
            href="${pageContext.request.contextPath}/public/assetsAuth/css/argon-dashboard.css?v=2.0.4"
            rel="stylesheet"
    />
    <link
            href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
            rel="stylesheet"
    />
    <script async defer src="https://buttons.github.io/buttons.js"></script>
</head>
<style>

</style>

<body class="bg-white">


<main id="main">


    <div class="container position-sticky z-index-sticky top-0">
        <div class="row">
            <div class="col-12">
                <nav
                        class="navbar navbar-expand-lg blur border-radius-lg top-0 z-index-3 shadow position-absolute mt-4 py-2 start-0 end-0 mx-4"
                >
                    <div class="container-fluid">
                        <a
                                class="navbar-brand font-weight-bolder ms-lg-0 ms-3"
                        >
                            D E V S Y N C
                        </a>
                        <button
                                class="navbar-toggler shadow-none ms-2"
                                type="button"
                                data-bs-toggle="collapse"
                                data-bs-target="#navigation"
                                aria-controls="navigation"
                                aria-expanded="false"
                                aria-label="Toggle navigation"
                        >
        <span class="navbar-toggler-icon mt-2">
          <span class="navbar-toggler-bar bar1"></span>
          <span class="navbar-toggler-bar bar2"></span>
          <span class="navbar-toggler-bar bar3"></span>
        </span>
                        </button>
                        <div class="collapse navbar-collapse" id="navigation" v-if="user.role">
                            <ul class="navbar-nav mx-auto">

                                <li class="nav-item">
                                    <a href="#about"
                                       class="nav-link me-2"
                                    >
                                        About us
                                    </a>
                                </li>

                                <li class="nav-item">
                                    <a
                                                 class="nav-link me-2 cursor-pointer"

                                    >
                                        Contact us
                                    </a>
                                </li>
                            </ul>

                        </div>
                        <div class="collapse navbar-collapse">
                            <ul class="navbar-nav mx-auto">
                                <li class="nav-item">
                                    <a class="nav-link me-2">
                                        <i class="fas fa-user-circle opacity-6 text-dark me-1"></i>
                                        Sign Up
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link me-2">
                                        <i class="fas fa-key opacity-6 text-dark me-1"></i>
                                        Sign In
                                    </a>
                                </li>
                            </ul>
                            <ul class="navbar-nav d-lg-block d-none">
                                <li class="nav-item">
                                    <a
                                            class="btn btn-sm mb-0 me-1 btn-primary"
                                    >Subscribe</a
                                    >
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
    </div>
    <main class="main-content mt-0">
        <section>
            <div class="page-header min-vh-100">
                <div class="container">
                    <div class="row">
                        <div
                                class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto"
                        >
                            <div class="card card-plain">
                                <div class="card-header pb-0 text-start">
                                    <h4 class="font-weight-bolder text-dark">Sign In</h4>
                                    <p class="mb-0 text-secondary">Enter your email and password to sign in</p>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/auth/login" method="POST" id="form">
                                        <div class="mb-3 form-outline">
                                            <input
                                                    type="email"
                                                    name="email"
                                                    class="form-control form-control-lg bg-secondary border-dark text-white"
                                                    placeholder="Email"
                                            />

                                        </div>
                                        <div class="mb-3">
                                            <input
                                                    type="password"
                                                    name="password"
                                                    class="form-control form-control-lg bg-secondary border-dark text-white"
                                            />

                                        </div>
                                        <div class="d-flex align-items-center justify-content-between">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="rememberMe" />
                                                <label class="form-check-label text-secondary" for="rememberMe">Remember me</label>
                                            </div>
                                            <a
                                                    class="btn btn-link text-white mt-3"
                                            >Forgot Password?</a
                                            >
                                        </div>
                                        <div class="text-center" style="display: none">
                                            <div class="spinner-border" role="status">
                                                <span class="visually-hidden">Loading...</span>
                                            </div>
                                        </div>
                                        <div class="text-center">
                                            <button
                                                    type="submit"
                                                    name="submit"
                                                    class="btn btn-lg btn-primary btn-lg w-100 mt-4 mb-0"
                                            >
                                                Sign in
                                            </button>
                                        </div>
                                    </form>
                                </div>
                                <div class="card-footer text-center pt-0 px-lg-2 px-1">
                                    <p class="mb-4 text-sm mx-auto">
                                        Don't have an account?
                                        <a
                                                class="text-primary font-weight-bold"
                                        >Sign up</a
                                        >
                                    </p>
                                </div>

                            </div>
                        </div>
                        <div
                                class="col-6 d-lg-flex d-none h-100 my-auto pe-0 position-absolute top-0 end-0 text-center justify-content-center flex-column"
                        >
                            <div
                                    class="position-relative bg-gradient-primary h-100 m-3 px-7 border-radius-lg d-flex flex-column justify-content-center overflow-hidden"
                            >
                                <span class="mask bg-gradient-primary opacity-6"></span>

                                <h4
                                        class="mt-5 text-white font-weight-bolder position-relative"
                                >
                                    "Attention is the new currency"
                                </h4>
                                <p class="text-white position-relative">
                                    The more effortless the writing looks, the more effort the
                                    writer actually put into the process.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>



<script src="${pageContext.request.contextPath}/public/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/public/assets/vendor/swiper/swiper-bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/public/assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/public/assets/vendor/aos/aos.js"></script>
<script src="${pageContext.request.contextPath}/public/assets/vendor/php-email-form/validate.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>


<!-- Template Main JS File -->
<script src="${pageContext.request.contextPath}/public/assets/js/main.js"></script>
<script src="${pageContext.request.contextPath}/public/js/form.js"></script>
<script src="${pageContext.request.contextPath}/public/js/login.js"></script>
<script src="${pageContext.request.contextPath}/public/js/search.js"></script>



</body>
</html>
