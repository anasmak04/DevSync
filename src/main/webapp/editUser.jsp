<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit User</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
<div class="mx-auto mt-6 bg-white p-8 rounded-lg shadow-lg">
  <h2 class="text-2xl font-semibold mb-6 text-center">Edit User</h2>

  <form action="users" method="POST" class="space-y-4">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="id" value="${user.id}">

    <div>
      <label for="firstName" class="block text-sm font-medium text-gray-700">First Name:</label>
      <input
              type="text"
              id="firstName"
              name="firstName"
              value="${user.firstName}"
              class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
      >
    </div>

    <!-- Last Name -->
    <div>
      <label for="lastName" class="block text-sm font-medium text-gray-700">Last Name:</label>
      <input
              type="text"
              id="lastName"
              name="lastName"
              value="${user.lastName}"
              class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
      >
    </div>

    <!-- Email -->
    <div>
      <label for="email" class="block text-sm font-medium text-gray-700">Email:</label>
      <input
              type="email"
              id="email"
              name="email"
              value="${user.email}"
              class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
      >
    </div>

    <!-- Password -->
    <div>
      <label for="password" class="block text-sm font-medium text-gray-700">Password:</label>
      <input
              type="password"
              id="password"
              name="password"
              value="${user.password}"
              class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
      >
    </div>

    <!-- Role -->
    <div>
      <label for="role" class="block text-sm font-medium text-gray-700">Role:</label>
      <select
              id="role"
              name="role"
              class="mt-1 block w-full px-3 py-2 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
      >
        <option value="ADMIN" ${user.role.name() == 'ADMIN' ? 'selected' : ''}>Admin</option>
        <option value="USER" ${user.role.name() == 'USER' ? 'selected' : ''}>User</option>
      </select>
    </div>

    <div class="text-center">
      <input
              type="submit"
              value="Update User"
              class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      >
    </div>
  </form>
</div>
</body>
</html>
