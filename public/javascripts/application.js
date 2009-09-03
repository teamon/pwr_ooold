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
        $(this).parent().remove();
        return false
      })
    })
  }
  
  $("#imageUpload").fileUpload ({
    uploader: "/flash/uploader.swf",
    script: "/lectures/" + $("#imageUpload").attr("rel") + "/images",
    scriptData: flashUploadScriptData,
    fileDataName: 'file',
    cancelImg: "/images/cancel.png",
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
  
  if($("#imageUpload").length > 0){
    updateImagesList()
  }
  
  $("#lecture_date").datepicker($.datepicker.regional['pl']);
	

})