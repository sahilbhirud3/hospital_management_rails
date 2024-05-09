// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo"; // Importing a named export 'Turbo' from '@hotwired/turbo'
import "@hotwired/turbo-rails"; 
import "controllers"
import toastr from 'toastr';
import 'toastr/toastr.scss';
import Rails from "@rails/ujs";
import "jquery";
import "chartkick"
import "Chart.bundle"
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require_tree .


Rails.start();
