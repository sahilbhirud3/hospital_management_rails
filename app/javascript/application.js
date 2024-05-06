// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import * as Turbo from "@hotwired/turbo"
import "controllers"
import toastr from 'toastr';
import 'toastr/toastr.scss';
import Rails from "@rails/ujs";
import "jquery";

//= require jquery
//= require jquery_ujs
//= require rails-ujs


Rails.start();
// Initialize Toastr with options
document.addEventListener("DOMContentLoaded", function() {
    toastr.options = {
        "closeButton": false,
        "debug": false,
        "newestOnTop": true,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "5000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
      }
  });
  