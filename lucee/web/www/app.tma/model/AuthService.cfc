component {
    function authenticate(username, password) {
        qUserRecord = queryExecute("SELECT * FROM users WHERE username = ?", [form.username]);
        if (qUserRecord.recordCount.toString().len()) {
            hashedPassword = qUserRecord.password;
            if (hash(password) == hashedPassword) {
                session.userId = qUserRecord.id;
                session.authenticated = true;
                return true;
            }
        }
        return false;
    }

    function logout() {
        structClear(session);
    }
}