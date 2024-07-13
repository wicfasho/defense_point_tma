<cfinclude template="../includes/header.cfm">

<body>
    <div class="logo" style="padding-left: 20px">
        <img src="assets/images/logo.svg"> <h2 class="mb-0">Task Management Application</h2>

        <a style="float: right" href="/view/tasks/list.cfm"><button class="btn btn-primary">Add New</button></a>
        <div style="clear:both"></div>
    </div>
    <main>
        <div class="row">
            <div class="col-sm-12 col-md-4 form-container">
                <h2>Add Task</h2>
                <form class="addTask" action="/controller/TaskController.cfc?method=add" method="post">
                    <cfparam name="url.id" default="">
                    <input type="hidden" name="task_id" value="<cfoutput>#url.id#</cfoutput>">
                    <cfscript>
                        taskService = new model.TaskService();
                        task = taskService.getTask(url.id);
                    </cfscript>
                    <label for="task_name">Task Name:</label>
                    <input type="text" name="task_name" id="task_name" value="<cfoutput>#task.task_name#</cfoutput>" required>
                    <label for="description">Description:</label>
                    <textarea name="description" id="description" required><cfoutput>#task.description#</cfoutput></textarea>
                    <label for="status">Status:</label>
                    <select name="status" id="status">
                        <option <cfif task.status.toLowerCase() eq 'pending'> selected </cfif> value="Pending">Pending</option>
                        <option <cfif task.status.toLowerCase() eq 'in progress'> selected </cfif> value="In Progress">In Progress</option>
                        <option <cfif task.status.toLowerCase() eq 'completed'> selected </cfif> value="Completed">Completed</option>
                    </select>
                    <button type="submit"><cfif url.id.len()>Update<cfelse>Add</cfif> Task</button>
                </form>
            </div>
            <div class="col-sm-12 col-md-8 list-container">
                <h2>Tasks</h2>
                <table id="tasks-table">
                    <thead>
                        <tr>
                            <th width="10">ID</th>
                            <th>Task Name</th>
                            <th>Description</th>
                            <th width="50">Status</th>
                            <th width="100">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

</body>

<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
    }

    header {
        background-color: #333;
        color: white;
        padding: 1em 0;
        text-align: center;
    }

    main {
        margin: 2em auto;
        padding: 2em;
        width: 80%;
        background: white;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .logo {
        margin: 2em auto;
        padding: 2em;
        width: 80%;
        background: white;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .form-container {
        /* width: 30%; */
        /* margin-right: 2%; */
    }

    .list-container {
        /* width: 68%; */
    }

    h2 {
        font-size: 1.5em;
        margin-bottom: 1em;
    }

    form {
        display: flex;
        flex-direction: column;
    }

    label {
        margin-bottom: 0.5em;
        font-weight: bold;
    }

    input[type="text"],
    textarea,
    select {
        margin-bottom: 1em;
        padding: 0.5em;
        font-size: 1em;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    button {
        padding: 0.5em 1em;
        border: none;
        background-color: #333;
        color: white;
        cursor: pointer;
        font-size: 1em;
    }

    button:hover {
        background-color: #555;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 1em;
    }

    th, td {
        padding: 1em;
        border: 1px solid #ddd;
        text-align: left;
    }

    th {
        background-color: #f4f4f4;
    }
</style>

<cfinclude template="../includes/footer.cfm">

<script>
    $(function(){
        // DataTable Init
        var table = $('#tasks-table').DataTable({
            'ajax': {
                'url': '/controller/TaskController.cfc?method=index'
            },
            "columns": [
                { "data": "id" },
                { "data": "task_name"},
                { "data": "description"},
                { "data": "status"},
                {"data":"action",className:'text-center'}
            ],
            "pageLength": 10,
            "aaSorting": [],
        });

        $('form.addTask').on('submit', function(e){
            e.preventDefault();

            var form = $(this);
            $.ajax({
                url: form.attr('action'),
                method: form.attr('method'),
                data: form.serialize(),
                success: function(result){
                    if (result.status == 'success'){
                        $('#tasks-table').DataTable().ajax.reload();
                        if (result.updated == 0) {
                            form.trigger("reset")
                        }
                    }
                    
                    alert(result.message)
                },
                error: function(xhr, ajaxOptions, thrownError){
                    alert(thrownError);
                }   
            });
        })

        $(document).delegate('.delete_task', 'click', function(e){
            e.preventDefault();
            if(confirm('Are you sure you want to delete this task?')) {
                var self = $(this)
                $.ajax({
                    url: "/controller/TaskController.cfc?method=delete&id=" + self.attr('id'),
                    method: "POST",
                    data: [],
                    success: function(result){
                        if (result.status == 'success'){
                            $('#tasks-table').DataTable().ajax.reload();
                        }
                        
                        // alert(result.message)
                    },
                    error: function(xhr, ajaxOptions, thrownError){
                        alert(thrownError);
                    }   
                })
            }
        })
    })
</script>
</html>
