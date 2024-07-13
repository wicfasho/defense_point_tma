
<cfinclude template="../includes/header.cfm">

<title>Task Details</title>

<body>
    <div class="logo" style="padding-left: 20px">
        <img src="assets/images/logo.svg"> <h2 class="mb-0">Task Management Application</h2>

        <a style="float: right" href="/view/tasks/list.cfm"><button class="btn btn-primary">Add New</button></a>
        <div style="clear:both"></div>
    </div>

    <main>
        <div class="details-container">
            <cfscript>
                taskService = new model.TaskService();
                task = taskService.getTask(url.id);
            </cfscript>

            <h2>Task Details</h2>
            <cfoutput>
                <a href="/view/tasks/list.cfm?id=#task.id#">Edit</a> | <a class="delete_task" id="#task.id#" href="##">Delete</a>
            </cfoutput>

            <table class="mb-5">
                <cfoutput>
                    <tr>
                        <th width="120">Task ID</th>
                        <td>#task.id#</td>
                    </tr>
                    <tr>
                        <th>Task Name</th>
                        <td>#task.task_name#</td>
                    </tr>
                    <tr>
                        <th>Description</th>
                        <td>#task.description#</td>
                    </tr>
                    <tr>
                        <th>Status</th>
                        <td>#task.status#</td>
                    </tr>
                </cfoutput>
            </table>
            <a href="/view/tasks/list.cfm">Back to Tasks</a>
        </div>
    </main>
    <cfinclude template="../includes/footer.cfm">
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

    .logo {
        margin: 2em auto;
        padding: 2em;
        width: 80%;
        background: white;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    main {
        margin: 2em auto;
        padding: 2em;
        width: 80%;
        background: white;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .container {
        display: flex;
        justify-content: space-between;
    }

    .form-container {
        width: 30%;
        margin-right: 2%;
    }

    .list-container {
        width: 68%;
    }

    .details-container {
        width: 100%;
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

    a {
        color: #333;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }
</style>

<script>
    $(document).delegate('.delete_task', 'click', function(e){
        e.preventDefault();
        if(confirm('Are you sure you want to delete this task?')) {
            var self = $(this)
            $.ajax({
                url: "/controller/TaskController.cfc?method=delete&id=" + self.attr('id'),
                method: "POST",
                data: [],
                success: function(result){
                    alert(result.message)
                    window.location.href="/"
                },
                error: function(xhr, ajaxOptions, thrownError){
                    alert(thrownError);
                }   
            })
        }
    })
</script>