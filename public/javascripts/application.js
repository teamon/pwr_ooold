$(document).ready(function(){

  function updateImagesList(){
    $.get("/lectures/" + $("#imageUpload").attr("rel") + "/images", {}, function(data, textStatus){
      $("#images .images").html(data)
      $("#images .images ul").sortable({
        // axis: 'y',
        cursor: 'crosshair',
        stop: function(event, ui){
          $.post("/lectures/" + $("#imageUpload").attr("rel") + "/images/update_positions", {
            "positions[]": $(this).sortable('toArray')
          })
        }
      })
      $("#images .images ul").disableSelection();
      $("#images .images a.delete").click(function(){
        $.ajax({
          type: "DELETE",
          url: $(this).attr("href")
        })
        $(this).parent().parent().hide("slow").remove();
        return false
      })
    })
  }
  if($("#imageUpload").length > 0){
  
  
    $("#imageUpload").fileUpload ({
      uploader: "/flash/uploader.swf",
      script: "/lectures/" + $("#imageUpload").attr("rel") + "/images",
      scriptData: flashUploadScriptData,
      fileDataName: 'file',
      cancelImg: "/images/fancy_closebox.png",
      //auto: true,
      multi: true,
      folder: "/uploads",
      onAllComplete: updateImagesList
    })

  
    $("#startUpload").click(function(){
      $('#imageUpload').fileUploadStart()
      return false
    })
  
    $("#clearQueue").click(function(){
      $('#imageUpload').fileUploadClearQueue()
      return false
    })
  
    updateImagesList()
  }
  
  $("#lecture_date").datepicker($.datepicker.regional['pl']);
	$(".images a.img").fancybox()
	
	$("a.delete").click(function(){
    if(confirm($(this).attr("rel"))){
      form = $('<form method="post">').attr("action", this.href).append('<input type="hidden" value="DELETE" name="_method" />')
      $("body").append(form)
      form.submit()
    }
    return false;
  })

})