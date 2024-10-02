<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>User List</title>
  <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<h2>User List</h2>

<hr>

<h3>Existing Users</h3>
<table border="1">
  <thead>
  <tr>
    <th>Id</th>
    <th>First Name</th>
    <th>Last Name</th>
    <th>Email</th>
    <th>Role</th>
    <th>Actions</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="user" items="${users}">
    <tr>
      <td>${user.id}</td>
      <td>${user.firstName}</td>
      <td>${user.lastName}</td>
      <td>${user.email}</td>
      <td>${user.role}</td>
      <td>
        <form action="users" method="POST" style="display:inline;">
          <input type="hidden" name="action" value="delete">
          <input type="hidden" name="id" value="${user.id}">
          <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete this user?');">
        </form>
        <form action="users" method="GET" style="display:inline;">
          <input type="hidden" name="action" value="edit">
          <input type="hidden" name="userId" value="${user.id}">
          <input type="submit" value="Edit">
        </form>
      </td>
    </tr>
  </c:forEach>
  <c:if test="${empty users}">
    <tr>
      <td colspan="5">No users found.</td>
    </tr>
  </c:if>
  </tbody>
</table>
<hr>
<a href="index.jsp">Add New User</a>
</body>
</html>
