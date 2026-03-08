/*
 * Welcome to your app's main JavaScript file!
 *
 * We recommend including the built version of this JavaScript file
 * (and its CSS file) in your base layout (base.html.twig).
 */

// any CSS you import will output into a single css file (app.css in this case)
import './styles/app.scss';

document.addEventListener('DOMContentLoaded', () => {
    const el = document.createElement('p');
    el.textContent = 'JS chargé avec succès !';
    document.body.appendChild(el);
});
