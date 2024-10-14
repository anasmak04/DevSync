const form = document.getElementById('form')
const email = document.getElementById('email-log')
const password = document.getElementById('password')

const email_error = document.getElementById('email-log-error');
const password_error = document.getElementById('password-log-error');


form.addEventListener('submit' , (e) => {
    var isValid = true;

    email_error.textContent = '';
    password_error.textContent = '';


    if(email.value.trim() === ''){
        email_error.textContent = 'The Email is required'
        isValid = false
    }
    else if(password.value.trim() === ''){
        password_error.textContent = 'The Password is required'
        isValid = false
    }
    else if(!isValid){
        e.preventDefault()
    }
})
