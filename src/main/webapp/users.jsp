<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User List</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 p-6">


<hr class="my-4">

<a href="index.jsp" class="bg-green-500 text-white rounded px-3 py-1 mb-4  hover:bg-blue-600 transition duration-200">Add New User</a>

<div class="overflow-x-auto mt-4">
  <table class="min-w-full bg-white border border-gray-300 rounded-lg shadow-lg">
    <thead>
    <tr class="bg-gray-200">
      <th class="py-2 px-4 border-b">Id</th>
      <th class="py-2 px-4 border-b">First Name</th>
      <th class="py-2 px-4 border-b">Last Name</th>
      <th class="py-2 px-4 border-b">Email</th>
      <th class="py-2 px-4 border-b">Role</th>
      <th class="py-2 px-4 border-b">Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${users}">
      <tr class="hover:bg-gray-100">
        <td class="py-2 px-4 border-b">${user.id}</td>
        <td class="py-2 px-4 border-b">${user.firstName}</td>
        <td class="py-2 px-4 border-b">${user.lastName}</td>
        <td class="py-2 px-4 border-b">${user.email}</td>
        <td class="py-2 px-4 border-b">${user.role}</td>
        <td class="py-2 px-4 border-b">
          <form action="users" method="POST" style="display:inline;">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="id" value="${user.id}">
            <input type="submit" value="Delete" class="bg-red-500 text-white rounded px-3 py-1 hover:bg-red-600 transition duration-200" onclick="return confirm('Are you sure you want to delete this user?');">
          </form>

          <form action="users" method="GET" style="display:inline;">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" value="${user.id}">
            <input type="submit" value="Edit" class="bg-blue-500 text-white rounded px-3 py-1 hover:bg-blue-600 transition duration-200">
          </form>
        </td>
      </tr>
    </c:forEach>
    <c:if test="${empty users}">
      <tr>
        <td colspan="6" class="text-center py-2">No users found.</td>
      </tr>
    </c:if>
    </tbody>
  </table>
</div>

<hr class="my-4">


</body>
</html>
