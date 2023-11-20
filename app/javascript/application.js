import "jquery"; // this import first
import "jquery-ui-dist";
$(function() {
    $(".task-box").draggable({
      snap: ".task-status",
      snapMode: "inner",
      revert: function(event, ui) {
        // on older version of jQuery UI, you'll have to use ui.helper
        return !event;
      }
    });
  
    $(".task-status").droppable({
      accept: ".task-box",
      tolerance: "pointer",
      drop: function(event, ui) {
        var taskBox = ui.draggable;
        taskBox.css({
          top: '',
          left: ''
        });
        taskBox.detach().appendTo($(this));
        var status = $(this).data("status");
        var projectId = taskBox.data("projectId");
  
        $.ajax({
          url: "/tasks/" + taskBox.data("id") + "/update_status",
          method: "POST",
          data: { task: { status: status }, project_id: projectId },
          beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
          success: function() {
            // taskBox.appendTo(this);
          }
        });
      }
    });
  });