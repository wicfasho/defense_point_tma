<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <base href="http://localhost:80/">
    <title>Login Page - Task Management Application</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f2f5;
        }
        .logo {
            align-self: center
        }
        .login-container {
            width: 100%;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .login-container h2 {
            margin-bottom: 30px;
            font-weight: 700;
            color: #333333;
        }
        .login-container .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .login-container .form-group label {
            font-weight: 600;
            color: #555555;
        }
        .login-container .form-control {
            border-radius: 10px;
            border: 1px solid #dddddd;
            padding: 10px;
        }
        .login-container .btn-primary {
            background-color: #007bff;
            border: none;
            border-radius: 10px;
            padding: 10px;
            font-size: 16px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .login-container .btn-primary:hover {
            background-color: #0056b3;
        }
        .login-container .forgot-password {
            display: block;
            margin-top: 10px;
            color: #007bff;
            text-decoration: none;
        }
        .login-container .forgot-password:hover {
            text-decoration: underline;
        }
        .login-container .signup-link {
            margin-top: 20px;
            color: #555555;
        }
        .login-container .signup-link a {
            color: #007bff;
            text-decoration: none;
            font-weight: 600;
        }
        .login-container .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="row">
        <div class="logo p-3">
            <img src="assets/images/logo.svg">
        </div>
        
        <div class="login-container">
            <h2>Login</h2>

            <cfscript>
                if(session.keyExists("authError")) {
                    writeOutput('<div class="alert bg-danger">' & session.authError & '</div>')
                    structDelete(session, "authError")
                }
            </cfscript>

            <form method="POST" action="/controller/AuthController.cfc?method=login">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="username" class="form-control" name="username" id="username" placeholder="Enter username" value="defensepoint">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" name="password" id="password" placeholder="Password" value="defensepoint">
                </div>
                <button type="submit" class="btn btn-danger btn-block">Login</button>
                <a href="#" class="forgot-password">Forgot password?</a>
            </form>
            <div class="signup-link">
                Don't have an account? <a href="#">Sign up</a>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
