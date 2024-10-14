let image = document.getElementById("image");
let input = document.getElementById("input-file");

input.onchange = () => {
    image.src = URL.createObjectURL(input.files[0]);
}


//auth
document.getElementById('form').addEventListener('submit', function(event) {
    var fullname = document.getElementById('fullname');
    var email = document.getElementById('email');
    var password = document.getElementById('password');
    var confirm_password = document.getElementById('confirm_password');

    var fullname_error = document.getElementById('fullname-error');
    var email_error = document.getElementById('email-error');
    var password_error = document.getElementById('password-error');
    var confirm_password_error = document.getElementById('confirm_password-error');

    var isValid = true;

    fullname_error.textContent = '';
    email_error.textContent = '';
    password_error.textContent = '';
    confirm_password_error.textContent = '';

    // Full Name validation
    if (fullname.value.trim() === '') {
        fullname_error.textContent = 'Full Name is required';
        isValid = false;
    }
    else if (email.value.trim() === '') {
        email_error.textContent = 'Email is required';
        isValid = false;
    }
    else if (password.value.trim() === '') {
        password_error.textContent = 'Password is required';
        isValid = false;
    }
    else if (confirm_password.value.trim() === '') {
        confirm_password_error.textContent = 'Confirm Password is required';
        isValid = false;
    } else if (confirm_password.value.trim() !== password.value.trim()) {
        confirm_password_error.textContent = 'Passwords do not match';
        isValid = false;
    }
    else if (!isValid) {
        event.preventDefault();
    }
});
