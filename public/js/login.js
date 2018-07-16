$(document).ready(function() {
    var state = false;
    // $("input:text:visible:first").focus();
    function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    };
        
        console.log(getUrlParameter('failed'));
    if(getUrlParameter('failed')) {
       document.getElementById("litheader").className = "";
        document.getElementById("login").className = "denied";
        document.getElementById("login").value = "Access Denied";
    }
    
    
    
    
    
    
    
    
    
    
    
    $('#accesspanel').on('submit', function(e) {

    
    document.getElementById("litheader").className = "poweron";
    document.getElementById("login").className = "";
    document.getElementById("login").value = "Authenticating...";
    
        // $.ajax({
                // url: '/login',
                // dataType: 'text',
                // type: 'post',
                // contentType: 'application/x-www-form-urlencoded',
                // data: $(this).serialize(),
                // success: function( data, textStatus, jQxhr ){ },
                // error: function( jqXhr, textStatus, errorThrown ){
                    // document.getElementById("litheader").className = "";
                    // document.getElementById("login").className = "denied";
                    // document.getElementById("login").value = "Access Denied";
                    // console.log( errorThrown );
                // }
            // });
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // e.preventDefault();
         // document.getElementById("litheader").className = "";
        // document.getElementById("login").className = "denied";
        // document.getElementById("login").value = "Access Denied";
 
    });
});






// $(document).ready(function() {
    // var state = false;
    // $("input:text:visible:first").focus();
    // $('#accesspanel').on('submit', function(e) {
        // e.preventDefault();
        // state = !state;
        // if (state) {
            // document.getElementById("litheader").className = "poweron";
            // document.getElementById("login").className = "";
            // document.getElementById("login").value = "Authenticating...";
        // }else{
            // document.getElementById("litheader").className = "";
            // document.getElementById("login").className = "denied";
            // document.getElementById("login").value = "Access Denied";
        // }
    // });
// });




// Read a page's GET URL variables and return them as an associative array.
// function getUrlVars()
// {
    // var vars = [], hash;
    // var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    // for(var i = 0; i < hashes.length; i++)
    // {
        // hash = hashes[i].split('=');
        // vars.push(hash[0]);
        // vars[hash[0]] = hash[1];
    // }
    // return vars;
// }