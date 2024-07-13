component {
    remote void function login(form) {
        local.authService = new model.AuthService();
        if (local.authService.authenticate(form.username, form.password)) {
            location("/index.cfm", false);
        } else {
            session.authError = "Invalid username or password";
            location("/view/auth/login.cfm", false);
        }
    }

    remote void function logout() {
        local.authService = new model.AuthService();
        authService.logout();
        location("/view/auth/login.cfm", false);
    }
}