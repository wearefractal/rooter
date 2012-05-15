define(function(){
  return function(_args, templ){
    console.log(_args);
    $("#testi").html(templ(_args));
  };
});