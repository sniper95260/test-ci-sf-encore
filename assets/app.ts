/*
 * Welcome to your app's main JavaScript file!
 *
 * We recommend including the built version of this JavaScript file
 * (and its CSS file) in your base layout (base.html.twig).
 */

// any CSS you import will output into a single css file (app.css in this case)
import './styles/app.scss';

import "@hotwired/turbo";

import { initTerminalRuntime } from './scripts/terminal-runtime';
import { initDocsToc } from './scripts/docs-toc';
import { initFaq } from './scripts/faq';

console.log('Hello Webpack Encore! Edit me in assets/app.ts');

function initPageScripts(): void {
    initTerminalRuntime();
    initDocsToc();
    initFaq();
}

document.addEventListener("turbo:load", initPageScripts);