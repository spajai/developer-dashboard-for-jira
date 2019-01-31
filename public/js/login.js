$(document).ready(function() {
    var valid ;
    function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    };
    if(getUrlParameter('failed')) {
        valid = false;
       document.getElementById("litheader").className = "";
        document.getElementById("login").className = "denied";
        document.getElementById("login").value = "Access Denied";
    }
    
    $('#accesspanel').on('submit', function(e) {
        valid = true;
        e.preventDefault();
        document.getElementById("litheader").className = "poweron";
        document.getElementById("login").className = "";
        document.getElementById("login").value = "Authenticating...";
         // $('#accesspanel').submit();
        if (valid) this.submit();
    });

});