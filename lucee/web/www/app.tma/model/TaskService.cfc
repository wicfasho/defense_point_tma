component {
    public query function getAllTasks() {
        qTaskList = queryExecute("SELECT * FROM tasks ORDER BY id DESC", []);
        return qTaskList;
    }

    public function addTask(taskName, description, status) {
        queryExecute(
            "INSERT INTO tasks (task_name, description, status) VALUES (?, ?, ?)",
            [taskName, description, status]
        );
    }

    public function updateTask(taskName, description, status, taskId) {
        queryExecute(
            "UPDATE tasks SET task_name = ?, description = ?, status = ? WHERE id = ?",
            [taskName, description, status, taskId]
        );
    }

    public function deleteTask(taskId) {
        queryExecute(
            "DELETE FROM tasks WHERE id = ?",
            [taskId]
        );
    }

    public query function getTask(taskId) {
        qTask = queryExecute("SELECT * FROM tasks WHERE id = ?", [taskId]);
        return qTask;
    }
}
