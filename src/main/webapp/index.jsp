
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
<body class="bg-gray-100 p-6">

<h2 class="text-2xl  font-semibold mb-4">User List</h2>

<form action="users" method="POST" class="bg-white p-6 rounded-lg shadow-lg mb-6">
    <input type="text" id="firstName" name="firstName" placeholder="First Name" required class="border border-gray-300 rounded p-2 mb-4 w-full">
    <input type="text" id="lastName" name="lastName" placeholder="Last Name" required class="border border-gray-300 rounded p-2 mb-4 w-full">
    <input type="email" id="email" name="email" placeholder="Email" required class="border border-gray-300 rounded p-2 mb-4 w-full">
    <input type="password" id="password" name="password" placeholder="Password" required class="border border-gray-300 rounded p-2 mb-4 w-full">

    <label for="role" class="block mb-2">Role:</label>
    <select id="role" name="role" required class="border border-gray-300 rounded p-2 mb-4 w-full">
        <option value="USER">User</option>
        <option value="MANAGER">Manager</option>
    </select>

    <input type="submit" value="Add User" class="bg-blue-500 text-white rounded p-2 w-full hover:bg-blue-600 transition duration-200">
</form>

<hr class="my-4">

<a href="users" class="text-blue-500 cursor-pointer hover:underline">View Existing Users</a>

</body>
</html>

