/*
 * Welcome to your app's main JavaScript file!
 *
 * We recommend including the built version of this JavaScript file
 * (and its CSS file) in your base layout (base.html.twig).
 */

// any CSS you import will output into a single css file (app.css in this case)
import './styles/app.scss';

import "@hotwired/turbo";

console.log('Hello Webpack Encore! Edit me in assets/app.ts');

document.addEventListener("turbo:load", () => {
    // When using Turbo, use rhe turbo events to initialize your JavaScript, instead of relying on DOMContentLoaded
    console.log("Hello Turbo! Turbo navigation ready");
});