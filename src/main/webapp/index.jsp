<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<h2>User List</h2>

<form action="users" method="POST">
    <input type="text" id="firstName" name="firstName" placeholder="First Name" required>
    <input type="text" id="lastName" name="lastName" placeholder="Last Name" required>
    <input type="email" id="email" name="email" placeholder="Email" required>
    <input type="password" id="password" name="password" placeholder="Password" required>

    <label for="role">Role:</label>
    <select id="role" name="role" required>
        <option value="USER">User</option>
        <option value="MANAGER">Manager</option>
    </select>

    <input type="submit" value="Add User">
</form>

<hr>
<a href="users">View Existing Users</a>

</body>
</html>
