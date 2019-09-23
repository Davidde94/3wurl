$(document).ready(function() {

  $("#mainForm").submit(function(event) {
    event.preventDefault();

    var array = $(this).serializeArray();
    var json = {};

    $.each(array, function() {
        json[this.name] = this.value || '';
    });
    json = JSON.stringify(json);
    console.log(json);

    $.ajax({
      type: "POST",
      url: "/create",
      dataType: "json",
      contentType: "application/json",
      data: json
    })
    .done(function(data) {
      var url = data["url"]
      $("#resultBox").show();
      $("#linkButton").attr("href", url);
      $("#linkButton").text(url);
    })
    .fail(function(data) {
      console.log(data);
    })
  });

});
