$(document).ready(function(){
  $("#about h3").each(function(i,e){
    $(e).editable("/pages/" + (i+1), {
      type: "text",
      method: "PUT",
      name: "page[title]",
      submit: "Save",
      cancel: "Cancel",
      onblur: "save"
    })
  })
  
  $("#about div div").each(function(i,e){
    $(e).editable("/pages/" + (i+1), {
      loadurl: "/pages/" + (i+1) + "/source",
      type: "autogrow",
      autogrow: {
         lineHeight : 16,
         minHeight  : 32
      },
      submit: "Save",
      cancel: "Cancel",
      method: "PUT",
      name: "page[content]",
      onblur: "save"
    })
  })
  
  
  function updateImagesList(){
    $.get("/works/" + $("#imageUpload").attr("rel") + "/images", {}, function(data, textStatus){
      $("#images .images").html(data)
      $("#images .images ul").sortable({
        axis: 'y',
        cursor: 'crosshair',
        stop: function(event, ui){
          $.post("/works/" + $("#imageUpload").attr("rel") + "/images/update_positions", {
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
    script: "/works/" + $("#imageUpload").attr("rel") + "/images",
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
  
  $("a.delete").click(function(){
    if(confirm("Are you sure?")){
      form = $('<form method="post">').attr("action", this.href).append('<input type="hidden" value="DELETE" name="_method" />')
      $("body").append(form)
      form.submit()
    }
    return false;
  })
  
  if($("#imageUpload").length > 0){
    updateImagesList()
  }
  

})