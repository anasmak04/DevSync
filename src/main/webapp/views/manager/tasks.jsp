
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    Calendar calendar = Calendar.getInstance();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    // Default for no user selection (min is today)
    String today = sdf.format(calendar.getTime());

    // For user selection (min is three days from now)
    calendar.add(Calendar.DAY_OF_YEAR, 3);
    String threeDaysFromNow = sdf.format(calendar.getTime());
%>

<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js" defer></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
    <!-- Nucleo Icons -->
    <link href="${pageContext.request.contextPath}/public/css/nucleo-icons.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/public/css/nucleo-svg.css" rel="stylesheet" />
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <!-- CSS Files -->
    <link id="pagestyle" href="${pageContext.request.contextPath}/public/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">


    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
</head>
<style>
    .toast {
        opacity: 1 !important;
    }

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

    .custom-item {
        display: flex;
        align-items: center;
        padding: 10px;
    }

    /* Profile image styling */
    .profile-img {
        width: 30px;
        height: 30px;
        border-radius: 50%;
        object-fit: cover;
        margin-right: 10px;
    }

    /* Dropdown menu size and appearance */
    .custom-menu {
        max-height: 300px;
        overflow-y: auto;
    }

    /* Highlight on hover */
    .custom-item:hover {
        background-color: #f8f9fa;
    }
    .file-upload {
        display: none; /* Hide the default file input */
    }

    .file-upload-label {
        display: inline-flex;
        align-items: center;
        cursor: pointer;
        background: transparent;
        color: white; /* Adjust as needed */
        border: 1px solid transparent; /* Optional: Add border if needed */
        padding: 8px 12px; /* Adjust padding */
        border-radius: 5px; /* Optional: rounded corners */
    }

    .file-upload-label:hover {
        border: 1px solid white; /* Show border on hover */
    }

    .file-upload-label .icon {
        margin-right: 8px; /* Space between icon and text */
    }
    .text-primary-hover:hover {
        background-color: #5e72e4;
    }

    .success{
        background-color: #D9FDEF !important;
        color: #216E64 !important;
    }
    .warning{
        background-color: #F1F2F4 !important;
        color: #172B4D !important;
    }
    .primary {
        background-color: #D6E4FF !important;
        color: #2B44BD !important;
    }
    .danger {
        background-color: #FEE2E2 !important;
        color: #C53030 !important;
    }
</style>
<body class="g-sidenav-show" style="background-color:white;">
<div class="min-height-300 position-absolute w-100" style="background-color: #5E72E4"></div>
<aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-4 shadow-blur"
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
                <a class="nav-link" href="dashboard">
                    <div
                            class="icon icon-shape icon-sm border-radius-md text-center me-2 mb-2 d-flex align-items-center justify-content-center">
                        <i class="bx bx-home text-primary text-sm opacity-10"></i>
                    </div>
                    <span class="nav-link-text ms-1">Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="" style="background-color: #5E72E4;">
                    <div
                            class="icon icon-shape icon-sm border-radius-md text-center me-2 mb-2 d-flex align-items-center justify-content-center">
                        <i class="bx bx-task text-danger text-sm opacity-10"></i>
                    </div>
                    <span class="nav-link-text text-white ms-1">Tasks</span>
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
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <img src="${pageContext.request.contextPath}/${sessionScope.user.profile}"
                                         style="width: 40px; height: 40px; border-radius: 50%; margin-right: 10px;" />
                                </c:when>
                                <c:otherwise>
                                    <p>User not logged in</p>
                                </c:otherwise>
                            </c:choose>

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
            <c:forEach var="task" items="${lastTasks}">
                <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
                    <div class="card" style="background-color:white;">
                        <div class="card-body p-3">
                            <div class="row">
                                <div class="col-8">
                                    <div class="numbers">
                                        <p class="text-sm mb-0 font-weight-bold">
                                                ${task.title}
                                        </p>
                                        <h5 class="font-weight-bolder">
                                            ${task.endDate}
                                        </h5>
                                        <p class="mb-0">
                                    <span class="text-sm font-weight-bolder ${task.status == 'DONE' ? 'text-success' : 'text-warning'}">
                                        ${task.status}
                                    </span>

                                        </p>
                                    </div>
                                </div>
                                <div class="col-4 text-end">
                                    <div class="icon icon-shape bg-gradient-primary shadow-primary text-center rounded-circle">
                                        <a href="#">
                                            <c:if test="${not empty task.user.profile}">
                                                <img src="${pageContext.request.contextPath}/${task.user.profile}" alt="user-avatar" class="icon icon-shape bg-gradient-primary shadow-primary text-center rounded-circle">
                                            </c:if>
                                            <c:if test="${empty task.user.profile}">
                                                <img src="${pageContext.request.contextPath}/public/images/avatar.jfif" alt="user-avatar" class="icon icon-shape bg-gradient-primary shadow-primary text-center rounded-circle">
                                            </c:if>
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
                            <div>
                                <a href="" class="btn btn-primary" data-bs-toggle="modal"
                                   data-bs-target="#addTag">Add Tag</a>
                                <a href="" class="btn btn-primary" data-bs-toggle="modal"
                                   data-bs-target="#addTask">New Task</a>

                            </div>

                        </div>
                        <div class="card-body px-0 pt-0 pb-2" style="height: 100vh;">
                            <div class="table-responsive p-0">
                                <table class="table align-items-center mb-0" style="height: auto">
                                    <thead>
                                    <tr>
                                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            ID</th>
                                        <th
                                                class="text-start text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Title</th>
                                        <th
                                                class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Status</th>

                                               <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Start Date</th>
                                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            End Date</th>
                                        <th
                                                class="text-start text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Assigned</th>
                                        <th
                                                class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                            Action</th>



                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="task" items="${tasks}">
                                        <tr>
                                            <td>${task.id}</td>
                                            <td class="align-middle text-start">${task.title}</td>
                                            <td class="align-middle text-center">
                                                <form action="${pageContext.request.contextPath}/manager/tasks" method="POST">
                                                    <input type="hidden" name="task_id" value="${task.id}" />
                                                    <div class="dropdown">
                                                        <button class="btn  btn-sm dropdown-toggle ${task.status == 'DONE' ? 'success' : task.status == 'IN_PROGRESS' ? 'primary': task.status == 'CANCELLED' ? 'danger' : 'warning'}" type="button" id="statusDropdown${task.id}" data-bs-toggle="${task.status == 'CANCELLED' ? '' : 'dropdown'}" aria-expanded="false" style="border-radius: 5px !important;">
                                                                ${task.status}
                                                        </button>
                                                        <ul class="dropdown-menu" aria-labelledby="statusDropdown${task.id}">
                                                            <li class="text-center">
                                                                <button class="dropdown-item text-dark font-weight-bold" type="submit" name="status" value="TODO">Todo</button>
                                                            </li>
                                                            <li class="text-center">
                                                                <button class="dropdown-item text-primary font-weight-bold" type="submit" name="status" value="IN_PROGRESS">Inprogress</button>
                                                            </li>
                                                            <li class="text-center">
                                                                <button class="dropdown-item text-success font-weight-bold" type="submit" name="status" value="DONE">Done</button>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </form>
                                            </td>
                                            <td class="align-middle text-center">
                                                <span class="text-secondary text-xs font-weight-bold">${task.startDate}</span>
                                            </td>
                                            <td class="align-middle text-center">
                                                <span class="text-secondary text-xs font-weight-bold">${task.endDate}</span>
                                            </td>
                                            <form method="POST" action="${pageContext.request.contextPath}/manager/tasks">
                                                <td class="d-flex align-items-center justify-content-between">
                                                    <div class="d-flex align-items-center" style="width: 10px">
                                                        <c:if test="${not empty task.user.profile}">
                                                            <img src="${pageContext.request.contextPath}/${task.user.profile}"
                                                                 class="avatar avatar-sm me-2 border-radius-2xl profilee"
                                                                 alt="user"
                                                                 style="object-fit: cover; width: 40px; height: 40px;">
                                                        </c:if>
                                                        <c:if test="${empty task.user.profile}">
                                                            <img src="${pageContext.request.contextPath}/public/images/avatar.jfif"
                                                                 class="avatar avatar-sm me-2 border-radius-2xl profilee"
                                                                 alt="user"
                                                                 style="object-fit: cover; width: 40px; height: 40px;">
                                                        </c:if>

                                                        <div class="d-flex flex-column align-items-start ms-2">
                                                        <span class="text-secondary text-xs font-weight-bold" id="usernamee">
                                                                ${not empty task.user.username ? task.user.username : 'unassigned'}
                                                        </span>
                                                            <span class="text-secondary text-xs">------</span>
                                                        </div>
                                                    </div>

                                                    <div class="d-flex align-items-center">
                                                        <div class="dropdown ms-3">
                                                            <button class="btn btn-primary bg-transparent dropdown-toggle p-0 shadow-none text-secondary" type="button" data-bs-toggle="dropdown"></button>
                                                            <ul class="dropdown-menu custom-menu">
                                                                <c:forEach var="user" items="${users}">
                                                                    <li class="text-primary-hover">
                                                                        <a class="dropdown-item custom-item" href="#"
                                                                           data-profilee="${pageContext.request.contextPath}/${user.profile}"
                                                                           data-usernamee="${user.username}"
                                                                           data-userIdd="${user.id}"
                                                                           onclick="updateProfileImageTable(event, this);">
                                                                            <img src="${pageContext.request.contextPath}/${user.profile}" alt="${user.username}" class="profile-img">
                                                                            <span>${user.username}</span>
                                                                        </a>
                                                                    </li>
                                                                </c:forEach>
                                                            </ul>
                                                        </div>
                                                        <input type="hidden" id="user_id1" name="userId">
                                                        <input type="hidden" name="task_id" value="${task.id}">
                                                        <button type="submit" class="badge badge-sm bg-gradient-success text-center ms-5 border-0" style="border: none; display: none;width: 20px;height: 20px">
                                                            <i class="bx bx-check text-white"></i>
                                                        </button>
                                                        <c:if test="${sessionScope.tokenRequest.task.id == task.id}">
                                                            <a class="badge badge-sm bg-gradient-danger text-center cursor-pointer ms-5 border-0 d-flex justify-content-center align-items-center"
                                                               data-message="${sessionScope.tokenRequest.message}"
                                                               data-requestId="${sessionScope.tokenRequest.id}"
                                                               data-status="${sessionScope.tokenRequest.requestType}"
                                                               data-bs-toggle="modal"
                                                               data-bs-target="#updateUser"
                                                               style="border: none; width: 20px;height: 20px">
                                                                <i class="bx bxs-circle text-white"></i>
                                                            </a>
                                                        </c:if>
                                                    </div>


                                                </td>
                                            </form>




                                            <td class="align-middle text-center">
                                                <button class="badge badge-sm bg-gradient-primary text-center" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight"
                                                        data-show-tasktitle="${task.title}"
                                                        data-show-task-username="${task.user.username}"
                                                        data-show-description="${task.description}"
                                                        data-show-start="${task.startDate}"
                                                        data-show-end="${task.endDate}"
                                                        data-show-userprofile="${pageContext.request.contextPath}/${task.user.profile}"
                                                        data-show-manager="${task.manager.username}"
                                                        data-show-file="${task.file}"
                                                        data-show-createdAt="${task.createdAt}"
                                                        style="border: none">
                                                    <i class="bx bxs-show"></i>
                                                </button>
                                                <form action="${pageContext.request.contextPath}/manager/tasks" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this user?');">
                                                    <input type="hidden" name="id" value="${task.id}">
                                                    <input type="hidden" name="_method" value="delete">
                                                    <button class="badge badge-sm bg-gradient-danger text-center" style="border: none"><i class="bx bxs-trash"></i></button>
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
        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel" style="width: 800px !important;">
            <div class="offcanvas-header">
                <h5 id="offcanvasRightLabel">Task Details</h5>
                <p class="text-secondary font-weight-normal" id="show-task-createdAt"></p>
            </div>
            <div class="offcanvas-body">
                <div class="mb-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="dropdown mt-3">
                            <button class="btn btn-primary bg-transparent p-0 text-secondary shadow-none" type="button" data-bs-toggle="dropdown" aria-expanded="false" id="show-task-username">
                            </button>
                        </div>
                        <img src="${pageContext.request.contextPath}/public/images/avatar.jfif" id="show-task-userprofile" class="profile-img" style="width: 50px; height: 50px; object-fit: cover;">
                    </div>
                    <input type="text" id="show-task-title" class="form-control bg-transparent mb-3 mt-3 text-dark font-weight-bold shadow-none" placeholder="Title" readonly style="border: none">
                    <textarea id="show-task-description" class="form-control bg-dark mb-3" readonly></textarea>
                    <div class="row mt-3 mb-5">
                        <div class="col">
                            <label>Start Date</label>
                            <span id="show-task-start" class="form-control bg-transparent text-secondary border-0"></span>
                        </div>
                        <div class="col">
                            <label>End Date</label>
                            <span id="show-task-end" class="form-control bg-transparent text-secondary border-0"></span>
                        </div>
                    </div>
                    <div class="file-upload-container mt-3 d-flex align-items-center justify-content-start">
                        <i class="bx bx-file text-primary opacity-10 me-3" style="font-size: 30px"></i>
                        <span id="show-task-file" class="text-secondary">No file joined in this Task</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="addTask" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
            <div class="modal-dialog border-radius-xl" style="background-color:white;">
                <div class="modal-content border-radius-xl" style="background-color:white;">
                    <div class="modal-header border-bottom-0" style="background-color:white;">
                        <h5 class="modal-title text-dark" id="editProfileModalLabel">Add New Task</h5>
                        <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="background-color:white;">
                        <form action="${pageContext.request.contextPath}/manager/tasks" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="dropdown mt-3">
                                        <button class="btn btn-primary bg-transparent dropdown-toggle p-0 text-secondary shadow-none" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                            Assign to person
                                        </button>
                                        <ul class="dropdown-menu custom-menu" aria-labelledby="userDropdown">
                                            <c:forEach var="user" items="${users}">
                                                <li>
                                                    <a class="dropdown-item custom-item" href="#" data-profile="${pageContext.request.contextPath}/${user.profile}" data-username="${user.username}" data-userId="${user.id}" onclick="updateProfileImage(event)">
                                                        <img src="${pageContext.request.contextPath}/${user.profile}" alt="${user.username}" class="profile-img">
                                                        <span>${user.username}</span>
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>

                                    <input type="hidden" value="${sessionScope.user.id}" name="manager_id">
                                    <input type="hidden" id="userId" name="user_id">
                                    <img id="selectedProfileImg" src="${pageContext.request.contextPath}/public/images/avatar.jfif" class="profile-img" style="width: 40px; height: 40px; object-fit: cover;">
                                </div>
                                <input type="text" id="title" name="title" class="form-control bg-transparent mb-3 mt-3 text-dark font-weight-bold shadow-none" placeholder="Title" style="border: none">
                                <textarea type="text" id="description" name="description" class="form-control bg-dark mb-3"></textarea>
                                <div class="row mt-3">
                                    <div class="col">
                                        <label>Start Date</label>
                                        <input type="date" name="start_date" id="startDate" class="form-control bg-transparent text-secondary border-0" placeholder="Start Date" min="<%= threeDaysFromNow %>">
                                    </div>
                                    <div class="col">
                                        <label>End Date</label>
                                        <input type="date" name="end_date" id="endDate" class="form-control bg-transparent text-secondary border-0" placeholder="End Date" min="<%= threeDaysFromNow %>">
                                    </div>
                                </div>
                                <div class="form-group d-flex flex-column">
                                    <label >Choose Your Tags</label>
                                    <select name="tags[]" id="tag-multiple" multiple class="select2" style="border: none !important;">
                                        <c:forEach var="tag" items="${tags}">
                                            <option value="${tag.id}">
                                                ${tag.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="file-upload-container mt-3 d-flex align-items-center justify-content-start">
                                    <input type="file" name="file" id="file" class="file-upload">
                                    <label for="file" class="file-upload-label border-0">
                                        <i class="bx bx-file text-primary opacity-10" style="font-size: 30px"></i>
                                    </label>
                                    <span id="file-selected" class="text-secondary">No file selected</span>
                                </div>



                            </div>
                            <button type="submit" class="btn btn-primary" style="float: right">Create</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="addTag" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true" style="z-index: 99999;width: 100%">
            <div class="modal-dialog border-radius-xl" style="background-color:white;">
                <div class="modal-content border-radius-xl" style="background-color:white;">
                    <div class="modal-header border-bottom-0" style="background-color:white;">
                        <h5 class="modal-title text-dark">Add New Tag</h5>
                        <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="background-color:white;">
                        <form action="${pageContext.request.contextPath}/manager/tags" method="post">
                            <div class="mb-3">
                                <input type="text" id="name" name="name" class="form-control bg-transparent mb-3 mt-3 text-dark font-weight-bold shadow-none" placeholder="Name">
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
                    <div class="modal-header" >
                        <h5 class="modal-title text-dark" >Token Request</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/manager/tasks" method="post">

                            <div class="mb-3">
                                <input type="text" id="message" name="message" class="form-control bg-transparent mb-3 mt-3 text-dark font-weight-bold shadow-none border-0" placeholder="Message" value="${sessionScope.tokenRequest.message}">
                                <input type="hidden" name="requestId" value="${sessionScope.tokenRequest.id}">
                                <select name="requestType" id="requestType" class="form-control bg-transparent mb-3 mt-3 text-dark font-weight-bold shadow-none">
                                    <option value="PENDING" ${sessionScope.tokenRequest.requestType == 'PENDING' ? 'selected' : ''}>${sessionScope.tokenRequest.requestType}</option>
                                    <option value="ACCEPTED" ${sessionScope.tokenRequest.requestType == 'ACCEPTED' ? 'selected' : ''}>ACCEPT</option>
                                    <option value="REJECTED" ${sessionScope.tokenRequest.requestType == 'REJECTED' ? 'selected' : ''}>REJECT</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary" style="float: right">submit</button>
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

    <!-- Script to Show Toast -->

</main>


<script src="${pageContext.request.contextPath}/public/assets/js/core/popper.min.js"></script>
<script src="${pageContext.request.contextPath}/public/assets/js/core/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/public/assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="${pageContext.request.contextPath}/public/assets/js/plugins/smooth-scrollbar.min.js"></script>
<script src="${pageContext.request.contextPath}/public/assets/js/plugins/chartjs.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn-script.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>


<script src="https://cdn.tiny.cloud/1/f9ggt3dqixvgwwjjoxp3xio6hgf0r72qnuvll71z6g0sckld/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    tinymce.init({
        selector: 'textarea',
        plugins: 'anchor autolink charmap codesample emoticons image link lists media searchreplace table visualblocks wordcount',
        toolbar: 'undo redo | blocks fontfamily fontsize | bold italic underline strikethrough | link image media table | align lineheight | numlist bullist indent outdent | emoticons charmap | removeformat',
    });
</script>

<script>
    window.onload = function() {
        const successMessage = '<%= session.getAttribute("success") != null ? session.getAttribute("success") : "" %>';
        if (successMessage) {
            toastr.options = {
                "closeButton": true,
                "progressBar": true,
                "positionClass": "toast-top-right",
                "timeOut": "2000",
                "extendedTimeOut": "1000",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut",
                "showDuration": "300",
                "hideDuration": "1000"
            };

            toastr.success(successMessage);
            <% session.removeAttribute("success"); %>
        }
        else {
            const errorMessage = '<%= session.getAttribute("error") != null ? session.getAttribute("error") : "" %>';
            if (errorMessage) {
                toastr.options = {
                    "closeButton": true,
                    "progressBar": true,
                    "positionClass": "toast-top-right",
                    "timeOut": "2000",  // Duration on screen
                    "extendedTimeOut": "1000",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut",
                    "showDuration": "300",
                    "hideDuration": "1000"
                };

                toastr.error(errorMessage);
                <% session.removeAttribute("error"); %>
            }
        }
    };
</script>


<script>
    $(document).ready(function() {
        $('#offcanvasRight').on('show.bs.offcanvas', function(event) {
            var button = $(event.relatedTarget);
            var taskUsername = button.data('show-task-username');
            var taskTitle = button.data('show-tasktitle');
            var description = button.data('show-description');
            var start = button.data('show-start');
            var end = button.data('show-end');
            var userprofile = button.data('show-userprofile');
            var file = button.data('show-file');
            var createdAt = button.data('show-createdAt');

            var modal = $(this);

            modal.find('#show-task-username').text('Assigned To ' + taskUsername);
            modal.find('#show-task-title').val(taskTitle);
            tinymce.get('show-task-description').setContent(description);
            modal.find('#show-task-start').text(start);
            modal.find('#show-task-end').text(end);
            modal.find('#show-task-userprofile').attr('src', userprofile);
            modal.find('#show-task-file').text(file ? file : 'No file joined in this Task');
            modal.find('#show-task-createdAt').text(createdAt);
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

<script>
    $(function () {
        $('.selectOne').select2({
            placeholder: "user",
            allowClear: true
        });
        $('#tag-multiple').select2({
            placeholder: "Tags",
            allowClear: true
        });
    });

</script>

<script>

    const startDateInput = document.getElementById('startDate');
    const endDateInput = document.getElementById('endDate');
    const threeDaysFromNow = '<%= threeDaysFromNow %>';
    const today = '<%= today %>';

    function updateProfileImage(event) {
        event.preventDefault();
        const profileImgSrc = event.currentTarget.getAttribute('data-profile');
        const selectedProfileImg = document.getElementById('selectedProfileImg');
        const username = event.currentTarget.getAttribute('data-username');
        const dropdownButton = document.getElementById('userDropdown');
        const userId = event.currentTarget.getAttribute('data-userId');
        const userIdInput = document.getElementById('userId');

        selectedProfileImg.src = profileImgSrc;
        dropdownButton.innerText = `Assigned to ` + username;
        userIdInput.value = userId;

        // Set the min date to three days from today if a user is selected
        startDateInput.min = threeDaysFromNow;
        endDateInput.min = threeDaysFromNow;
    }

    // Reset min dates to today if no user is selected
    document.getElementById('userDropdown').addEventListener('click', function() {
        if (!document.getElementById('userId').value) {
            startDateInput.min = today;
            endDateInput.min = today;
        }
    });
    function updateProfileImageTable(event, dropdownItem) {
        event.preventDefault();

        const taskCell = dropdownItem.closest('td');

        const imgElement = taskCell.querySelector('.profilee');
        const usernameElement = taskCell.querySelector('#usernamee');

        const profileImgSrc = dropdownItem.getAttribute('data-profilee');
        imgElement.src = profileImgSrc;

        const username = dropdownItem.getAttribute('data-usernamee');
        usernameElement.innerText = username === 'unassigned' ? 'unassigned' : username;

        const userId = dropdownItem.getAttribute('data-userIdd');
        const userIdInput = taskCell.querySelector('#user_id1');
        userIdInput.value = userId;

        const submitBtn = taskCell.querySelector('button[type="submit"]');
        submitBtn.style.display = userId ? 'flex' : 'none';
        submitBtn.style.alignItems = 'center';
        submitBtn.style.justifyContent = 'center';
    }

</script>

<script>
    const fileInput = document.getElementById('file');
    const fileSelectedText = document.getElementById('file-selected');

    fileInput.addEventListener('change', function() {
        if (fileInput.files.length > 0) {
            fileSelectedText.textContent = fileInput.files[0].name;
        } else {
            fileSelectedText.textContent = "No file selected";
        }
    });
</script>

</body>
</html>
