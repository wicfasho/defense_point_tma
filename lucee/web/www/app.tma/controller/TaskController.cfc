component {
    remote function index() {
        cfcontent(reset="true", type="application/json")

        local.taskService = new model.TaskService();
        local.tasks = local.taskService.getAllTasks();

        local.result = {"data": []};

        for (task in local.tasks) {
            arrayAppend(local.result.data, {
                "id": task.id,
                "task_name": task.task_name,
                "description": task.description,
                "status": '<span class="badge badge-#task.status.toLowerCase() == 'pending' ? 'danger' : task.status.toLowerCase() == 'in progress' ? 'primary' : 'success'#">#task.status#</span>',
                "action": '<a href="/view/tasks/list.cfm?id=#task.id#">Edit</a> | <a class="delete_task" id="#task.id#" href="##">Delete</a>'
            })
        }

        writeOutput(serializeJSON(local.result));
    }

    remote function add(form) {
        cfcontent(reset="true", type="application/json")

        try{
            local.taskService = new model.TaskService();
            if(isDefined('form.task_id') && form.task_id.len()) {
                local.taskService.updateTask(form.task_name, form.description, form.status, form.task_id);
            }
            else {
                local.taskService.addTask(form.task_name, form.description, form.status);
            }

            result = {
                "status": "success",
                "updated": (isDefined('form.task_id') && form.task_id.len()) ? 1 : 0,
                "message": "Task Successfully #(isDefined('form.task_id') && form.task_id.len()) ? 'updated' : 'added'#"
            }
        }
        catch(any e) {
            result = {
                "status": "failure",
                "message": "An Error Occurred. Task wasn't added: " & e.message
            }
        }
        
        writeOutput(serializeJSON(result));
    }

    remote function delete(url) {
        cfcontent(reset="true", type="application/json")

        try {
            local.taskService = new model.TaskService();
            local.taskService.deleteTask(url.id);

            result = {
                "status": "success",
                "message": "Task Successfully deleted"
            }
        }
        catch(any e) {
            result = {
                "status": "failure",
                "message": "Oops! Task couldn't be deleted: " & e.message
            }
        }
        
        writeOutput(serializeJSON(result));
    }
}
