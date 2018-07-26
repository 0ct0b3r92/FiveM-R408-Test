$(document).ready(function() {

    window.addEventListener('message', function(event) {
        var item = event.data;

        if (item.showPlayerMenu == true) {
           $('body').css('display', 'block');
            $('.container-fluid').css('display', 'block');
        } else if (item.showPlayerMenu == false) { 
			$('body').css('display', 'none');
            $('.container-fluid').css('display', 'none');

        }
    });

    $("#closeClick").click(function() {
        $.post('http://map/close', JSON.stringify({}));

    });


})