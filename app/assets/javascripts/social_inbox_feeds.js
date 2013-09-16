$(document).ready(function(){
  var val = $(".pagination em.current").html();
  $(document).on("click", ".show-more", function(e){
    e.preventDefault();
    e.stopPropagation();
    console.log(val);
    value = parseInt(val) + 1;
    var href = "/?page=" + value
    console.log("href: " + href)
    val = parseInt(val) + 1;
    $.get(href.toString(), null, null, "script");
    return false;
  })
  
  $(document).on("click", ".filter-part", function(e){
    e.preventDefault();
    e.stopPropagation();
    $.get(this.href, {inbox_type: $(this).data("inboxtype")}, null, "script")
    return false;
  })
})