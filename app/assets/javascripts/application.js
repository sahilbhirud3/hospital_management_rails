import toastr from 'toastr';
import 'toastr/toastr.scss';
// Initialize Toastr with options
document.addEventListener("DOMContentLoaded", function() {
    toastr.options = {
      closeButton: true,
      progressBar: true,
      positionClass: 'toast-top-right'
      // Add more options as needed
    };
  });
  