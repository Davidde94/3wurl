$(document).ready(function() {

  $("#mainForm").submit(function(event) {
    event.preventDefault();

    var array = $(this).serializeArray();
    var json = {};

    $.each(array, function() {
        json[this.name] = this.value || '';
    });
    json = JSON.stringify(json);

    $.ajax({
      type: "POST",
      url: $("#mainForm").attr("action"),
      dataType: "json",
      contentType: "application/json",
      data: json
    })
    .done(function(data) {
      var url = data["url"]
      $("#resultBox").show();
      $("#link").text(url);
    })
    .fail(function(data) {
      console.log(data);
    })
  });

  $("#link").click(function() {
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val($("#link").text()).select();
    document.execCommand("copy");
    $temp.remove();
    console.log("copied to clipboard! " + $(this).text());
  });

});
