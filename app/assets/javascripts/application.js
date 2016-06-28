//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require rails.validations
//= require rails.validations.simple_form
//= require_tree .

$(document).ready(function(){
    $("#search_cep").mask('00000-000', {placeholder: "Digite o CEP"});
    $(document).ajaxStop(function(){
        $("#ajax_loader").hide();
    });
    $(document).ajaxStart(function(){
        $("#ajax_loader").show();
    });
});