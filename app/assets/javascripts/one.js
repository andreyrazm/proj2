$(function(){


    $(document).on('click',"#persons th a, #persons .pagination a", function(){

        $.getScript(this.href);

          return false;
    });


    $(document).on('click',".att", function(){

        $("#att").val(this.id);

        return false;
    });

    $(document).on('ajax:success',"#persons_new", function(){

        $('#new').val('');
    });

    $(document).on('ajax:complete',".del", function(){

        $.getScript('/person?direction=asc&amp;sort=name');

        return false;
    });


});
