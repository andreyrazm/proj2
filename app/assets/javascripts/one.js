$(function(){


    $(document).on('click',"#persons th a, #persons .pagination a", function(){

        $.getScript(this.href);

          return false;
    });


    $(".att").click(function(){
        $("#att").val(this.id);
    });


    //
    // $(document).on('submit', '#persons_search', function () {
    //     $.get(this.action, $(this).serialize(), null, "script");
    //     return false;
//
    // } );


});
