$(function(){


    $(document).on('click',"#persons th a, #persons .pagination a", function(){

        $.getScript(this.href);

          return false;
    });


    $(document).on('click',".att", function(){

        $("#att").val(this.id);

        return false;
    });


});
