import "@hotwired/turbo-rails"
// import '@popperjs/core'
// import * as bootstrap from "bootstrap"
import "chartkick/chart.js"
import "./controllers"


import {Turbo} from "@hotwired/turbo-rails";

Turbo.StreamActions.redirect = function () {
    Turbo.visit(this.target);
};

document.addEventListener("turbo:before-stream-render", (event) => {
    const fallbackToDefaultActions = event.detail.render;
    event.detail.render = function (streamElement) {
        if (streamElement.action === "redirect") {
            Turbo.visit(streamElement.target);
        } else {
            fallbackToDefaultActions(streamElement);
        }
    };
});

import {Tooltip} from "bootstrap"

const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new Tooltip(tooltipTriggerEl))


// import { Turbo } from "@hotwired/turbo-rails";

// import {Modal} from "bootstrap"


// import 'bootstrap'

// import * as bootstrap from "bootstrap"

// Turbo.StreamActions.redirect = function () {
//     Turbo.visit(this.target);
// };
//
// // or using event listener
//
// document.addEventListener("turbo:before-stream-render", (event) => {
//     const fallbackToDefaultActions = event.detail.render;
//     event.detail.render = function (streamElement) {
//         if (streamElement.action === "redirect") {
//             Turbo.visit(streamElement.target);
//         } else {
//             fallbackToDefaultActions(streamElement);
//         }
//     };
// });