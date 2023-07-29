// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import {Tooltip} from "bootstrap"
import "chartkick/chart.js"


const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new Tooltip(tooltipTriggerEl))