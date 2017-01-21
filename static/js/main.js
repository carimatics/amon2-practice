if (typeof(window.console) == "undefined") {
    console = {};
    console.log = console.warn = console.error = function(a) {};
}

$(document).ready(function() {
    $('ul.nav.navbar-nav li:has(a[href="'+location.pathname+'"])').addClass("active");
});
