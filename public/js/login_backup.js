$(document).ready(function() {

    function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    };
    if(getUrlParameter('failed')) {
       document.getElementById("litheader").className = "";
        document.getElementById("login").className = "denied";
        document.getElementById("login").value = "Access Denied";
    }
    
    

    
    
    
    
    
    
    $('#accesspanel').on('submit', function(e) {
        wait(500,"glow();");
    });
    
    
    
    function glow() {
        
        document.getElementById("litheader").className = "poweron";
        document.getElementById("login").className = "";
        document.getElementById("login").value = "Authenticating...";
        
    }
    
    
    function wait(ms, cb) {
  var waitDateOne = new Date();
  while ((new Date()) - waitDateOne <= ms) {
       document.getElementById("litheader").className = "poweron";
        document.getElementById("login").className = "";
        document.getElementById("login").value = "Authenticating...";
  }
  if (cb) {
    eval(cb);
  }
}
    
});