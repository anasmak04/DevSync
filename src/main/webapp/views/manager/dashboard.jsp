
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
    <!-- Nucleo Icons -->
    <link href="${pageContext.request.contextPath}/public/css/nucleo-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/public/css/nucleo-svg.css" rel="stylesheet" />
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <!-- CSS Files -->
    <link id="pagestyle" href="${pageContext.request.contextPath}/public/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
</head>
<style>

    .cards {
        width: 100%;
        border: none;
        background-color: transparent;
        border: none;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column
    }

    .cards img {
        width: 70px;
        height: 70px;
        border-radius: 50%;
        object-fit: cover;
    }

    .cards label {
        margin-top: 30px;
        text-align: center;
        height: 40px;
        cursor: pointer;
        font-weight: bold;
        font-size: 20px;
        margin-bottom: 10px;

    }

    .cards input {
        display: none;
    }
</style>
<body class="g-sidenav-show" style="background-color:white;">
<div class="min-height-300 position-absolute w-100" style="background-color:#5E72E4;"></div>
<aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-4 "
       id="sidenav-main" style="background-color:white;z-index: 999">
    <div class="sidenav-header">
        <i class="fas fa-times p-3 cursor-pointer text-secondary opacity-5 position-absolute end-0 top-0 d-none d-xl-none"
           aria-hidden="true" id="iconSidenav"></i>
        <a class="navbar-brand m-0" href=" https://demos.creative-tim.com/argon-dashboard/pages/dashboard.html "
           target="_blank">
            <span class="ms-1 font-weight-bold">D E V S Y N C</span>

        </a>
    </div>
    <hr class="horizontal dark mt-0">
    <div class="collapse navbar-collapse  w-auto " id="sidenav-collapse-main">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link active" href="" style="background-color: #5E72E4;">
                    <div
                            class="icon icon-shape icon-sm border-radius-md text-center me-2 mb-2 d-flex align-items-center justify-content-center">
                        <i class="bx bx-home text-white text-sm opacity-10"></i>
                    </div>
                    <span class="nav-link-text text-white ms-1">Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="tasks">
                    <div
                            class="icon icon-shape icon-sm border-radius-md text-center me-2 mb-2 d-flex align-items-center justify-content-center">
                        <i class="bx bx-task text-danger text-sm opacity-10"></i>
                    </div>
                    <span class="nav-link-text ms-1">Tasks</span>
                </a>
            </li>


        </ul>
    </div>

</aside>
<main class="main-content position-relative border-radius-lg ">
    <!-- Navbar -->
    <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl " id="navbarBlur"
         data-scroll="false">
        <div class="container-fluid py-1 px-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
                    <li class="breadcrumb-item text-sm"><a class="opacity-5 text-white"
                                                           href="javascript:;">Pages</a></li>
                    <li class="breadcrumb-item text-sm text-white active" aria-current="page">Dashboard</li>
                </ol>
                <h6 class="font-weight-bolder text-white mb-0">Dashboard</h6>
            </nav>
            <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
                <div class="ms-md-auto pe-md-3 d-flex align-items-center">
                    <div class="input-group">
                            <span class="input-group-text text-body"><i class="fas fa-search"
                                                                        aria-hidden="true"></i></span>
                        <input type="text" class="form-control" placeholder="Type here...">
                    </div>
                </div>
                <ul class="navbar-nav  justify-content-end">
                    <li class="nav-item d-flex align-items-center">
                        <a class="nav-link text-white font-weight-bold px-0" href=""
                        >

                            <img src="${pageContext.request.contextPath}/${sessionScope.user.profile}" alt="" srcset=""
                                 style="width: 40px;height:40px;border-radius:50%;margin-right:10px;">

                            <form action="../auth/login" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to logout?');">
                                <input type="hidden" name="_logout" value="logout">
                                <button style="border: none;border: none;background-color: transparent"><span class="d-sm-inline d-none text-white">Logout</span></button>
                            </form>
                        </a>
                    </li>
                    <li class="nav-item d-xl-none ps-3 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-white p-0" id="iconNavbarSidenav">
                            <div class="sidenav-toggler-inner">
                                <i class="sidenav-toggler-line bg-white"></i>
                                <i class="sidenav-toggler-line bg-white"></i>
                                <i class="sidenav-toggler-line bg-white"></i>
                            </div>
                        </a>
                    </li>
                    <li class="nav-item px-3 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-white p-0">
                            <i class="fa fa-cog fixed-plugin-button-nav cursor-pointer"></i>
                        </a>
                    </li>
                    <li class="nav-item dropdown pe-2 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-white p-0" id="dropdownMenuButton"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa fa-bell cursor-pointer"></i>
                        </a>

                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- End Navbar -->
    <div class="container-fluid py-4">
        <div class="row">
            <c:forEach var="user" items="${last_users}">
            <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                <div class="card" style="background-color:white;">
                    <div class="card-body p-3">
                        <div class="row">
                            <div class="col-8">
                                <div class="numbers">
                                    <p class="text-sm mb-0 font-weight-bold">
                                        ${user.email}
                                    </p>
                                    <h5 class="font-weight-bolder">
                                        ${user.username}
                                    </h5>
                                    <p class="mb-0">
                                    <span class="text-success text-sm font-weight-bolder">
                                       ${user.role}
                                    </span>
                                        created
                                    </p>
                                </div>
                            </div>
                            <div class="col-4 text-end">
                                <div class="icon icon-shape bg-gradient-primary shadow-primary text-center rounded-circle">
                                    <a href="#">
                                        <img src="${pageContext.request.contextPath}/${user.profile}" alt="user-avatar" class="icon icon-shape bg-gradient-primary shadow-primary text-center rounded-circle">
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
            </c:forEach>

        </div>

        <div class="row mt-4">
            <div class="row">
                <div class="col-12">
                    <div class="card mb-4" style="background-color:white;">
                        <div class="card-header pb-0 d-flex justify-content-between align-items-center"
                             style="background-color:white;">
                            <h6>Users</h6>
                            <a href="" class="btn btn-primary" data-bs-toggle="modal"
                               data-bs-target="#addUser">Create One</a>

                        </div>
                        <div class="card-body px-0 pt-0 pb-2">
                            <div class="table-responsive p-0">
                                <table class="table align-items-center mb-0">
                                    <thead>
                                    <tr>
                                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            ID</th>
                                        <th
                                                class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            User</th>
                                        <th
                                                class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Email</th>
                                        <th
                                                class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Location</th>

                                        <th
                                                class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Craeted_at</th>
                                        <th
                                                class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Role</th>
                                        <th
                                                class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Action</th>



                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="user" items="${users}">


                                    <tr>
                                        <td>${user.id}</td>
                                        <td class="align-middle text-center d-flex justify-content-center align-items-center">
                                            <img src="${pageContext.request.contextPath}/${user.profile}" class="avatar avatar-sm" alt="user" style="object-fit: cover;">
                                        </td>
                                        <td class="align-middle text-center">${user.email}</td>
                                        <td class="align-middle text-center">loc</td>
                                        <td class="align-middle text-center">
                                            <span class="text-secondary text-xs font-weight-bold">${user.createdAt}</span>
                                        </td>
                                        <td class="align-middle text-center">
                                            <span class="badge badge-sm ${user.role == 'MANAGER' ? 'bg-gradient-success' : 'bg-gradient-warning'}">
                                                ${user.role}
                                            </span>
                                        </td>
                                        <td class="align-middle text-center">
                                            <a href="#" class="status-badge me-3" data-bs-toggle="modal"
                                               data-bs-target="#updateUser">
                                                <button class="badge badge-sm bg-gradient-primary text-center" style="border: none" data-user_name="${user.username}" data-user_email="${user.email}"  data-user_id="${user.id}" data-bs-toggle="modal" data-bs-target="#updateUser">Update</button>
                                            </a>
                                            <form action="../manager/dashboard" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                                <input type="hidden" name="id" value="${user.id}">
                                                <input type="hidden" name="_method" value="delete">
                                                <button class="badge badge-sm bg-gradient-danger text-center" style="border: none">Delete</button>
                                            </form>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                    </tbody>

                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal fade" id="addUser" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true" style="z-index: 100001">
            <div class="modal-dialog" >
                <div class="modal-content" >
                    <div class="modal-header" >
                        <h5 class="modal-title text-dark" id="editProfileModalLabel">Add User</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/manager/dashboard" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <div class="cards">
                                    <img src="${pageContext.request.contextPath}/public/images/avatar.jfif" id="image" style="width: 100px ; height: 100px ; object-fit: cover">
                                    <label for="profile" class="text-sm">Choose Image</label>
                                    <input type="file" id="profile" name="profile"  class="form-control bg-transparent mt-3" placeholder="Put you Picture here">

                                </div>
                                <input type="text" id="username" name="username" class="form-control bg-transparent" placeholder="UserName">
                                <input type="text" id="email" name="email" class="form-control bg-transparent mt-3" placeholder="exemple@gmail.com">
                                <input type="password"  id="password" name="password"  class="form-control bg-transparent mt-3" placeholder="Password">
                                <select type="text"  id="role" name="role"  class="form-control bg-transparent mt-3" placeholder="Phone Number">
                                    <option value="MANAGER">MANAGER</option>
                                    <option value="USER">USER</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary" style="float: right">Create</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="updateUser" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true" style="z-index: 100001">
            <div class="modal-dialog" >
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-dark" >Update User</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="../manager/dashboard" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <input type="hidden" name="user_id" id="user_id">
                                <input type="text" id="username2" name="username" class="form-control bg-transparent text-dark" placeholder="Name">
                                <input type="text" id="useremail"  name="email" class="form-control bg-transparent mt-3 text-dark" placeholder="exemple@gmail.com">
                            </div>
                            <button type="submit" class="btn btn-primary">Update</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <footer class="footer pt-3  ">
            <div class="container-fluid">
                <div class="row align-items-center justify-content-lg-between">
                    <div class="col-lg-6 mb-lg-0 mb-4">
                        <div class="copyright text-center text-sm text-muted text-lg-start">
                            ©
                            <script>
                                document.write(new Date().getFullYear())
                            </script>,
                            made with <i class="fa fa-heart"></i> by
                            <a href="https://www.creative-tim.com" class="font-weight-bold"
                               target="_blank">E V E N T O</a>
                            for a better platform.
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <ul class="nav nav-footer justify-content-center justify-content-lg-end">
                            <li class="nav-item">
                                <a href="https://www.creative-tim.com" class="nav-link text-muted"
                                   target="_blank">E V E N T O</a>
                            </li>
                            <li class="nav-item">
                                <a href="https://www.creative-tim.com/presentation" class="nav-link text-muted"
                                   target="_blank">About Us</a>
                            </li>
                            <li class="nav-item">
                                <a href="https://www.creative-tim.com/blog" class="nav-link text-muted"
                                   target="_blank">Blog</a>
                            </li>
                            <li class="nav-item">
                                <a href="https://www.creative-tim.com/license" class="nav-link pe-0 text-muted"
                                   target="_blank">License</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </footer>
    </div>
</main>


<script src="${pageContext.request.contextPath}/public/assets/js/core/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/public/assets/js/core/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/public/assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="${pageContext.request.contextPath}/public/assets/js/plugins/smooth-scrollbar.min.js"></script>
<script src="${pageContext.request.contextPath}/public/assets/js/plugins/chartjs.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>


<script>
    $(document).ready(function() {
        $('#updateUser').on('show.bs.modal', function(event) {
            var button = $(event.relatedTarget);
            var userId = button.data('user_id');
            var userName = button.data('user_name');
            var userEmail = button.data('user_email');
            var modal = $(this);
            modal.find('#user_id').val(userId);
            modal.find('#username2').val(userName);
            modal.find('#useremail').val(userEmail);
        });
    });
</script>


<script>

    let image = document.getElementById("image");
    let input = document.getElementById("profile");

    input.onchange = () => {
        image.src = URL.createObjectURL(input.files[0]);
    }

</script>

</body>
</html>
