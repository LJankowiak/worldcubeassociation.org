/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'image-preview';
import 'polyfills';
import 'flag-icon-css/css/flag-icon.css';
import 'incidents-log';
import 'leaflet-wca';
import autosize from 'autosize';

// Setting up autosize
$(function() {
  autosize($('textarea:not(.no-autosize)'));
});