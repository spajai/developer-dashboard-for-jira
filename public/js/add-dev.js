$(document).ready(function(){
        // click on button submit
        $('.button').click(function(event) {
         // send ajax
            var formData = {
                'name'   :$('#name').val(),
                'team'   :$('#teamId option:selected').val(),
                'user_id':$('#userId').val()
            };
            var sendData = JSON.stringify(formData);
            var type = $(this).data('info').type;
             $.ajax({
                 //url: '/api/v1/admin/dev/add',
                 url:  $(this).data('url'),
                 type : $(this).data('info').type,
                 dataType : 'json',
                 data : sendData,
                 encode : true
             }).done(function(data) {

             var notification = {
                "PUT" : {
                    "Warning" : "User Does not exists" ,
                    "msg": '<div class="alert alert-warning"> User already exists </div>',
                    "valid" : '<div class="alert alert-success"> User Updated Successfully </div>'
                },
                "DELETE" : {
                    "Warning" : "User Does not exists",
                    "msg" : '<div class="alert alert-warning"> User does not exists </div>',
                    "valid" : '<div class="alert alert-success"> User Deleted Successfully </div>'
                },
                "POST" : {
                    "Warning" : "Username already exists",
                    "msg" : '<div class="alert alert-warning"> User does not exists </div>',
                    "valid" : '<div class="alert alert-success"> User Registered Successfully </div>'
                },
                "ISE" : '<div class="alert alert-error"> Exception: Server Error </div>'
             };
             event.preventDefault();
             if(data.status == -1) {
                         $.alert({
                             title: 'Warning',
                             theme: 'supervan',
                             icon: 'fa fa-warning',
                             type: 'orange',
                             content: notification[type].Warning,
                         });
                     $('.success').append(notification[type].msg).fadeOut(5000);
                      return false;
             } else if (data.status == 0) {
                     $.alert({
                         title: 'Error',
                         theme: 'supervan',
                         icon: 'fa fa-error',
                         type: 'red',
                         content: 'Server Error',
                     });
                   $('.success').append(notification["ISE"]).fadeOut(5000);
                      return false;
                  }  else if (data.status == 1){
                         $.alert({
                             title: 'Success',
                             theme: 'supervan',
                             icon: 'fa fa-success',
                             type: 'green',
                             content: 'Request Completed Successfully',
                         });
                 $('.success').append(notification[type].success).fadeOut(5000);
             }
     });
   });
 });