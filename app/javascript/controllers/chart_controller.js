import {Controller} from "@hotwired/stimulus"
import Chart from 'chart.js/auto'

// Connects to data-controller="chart"
export default class extends Controller {

    static targets = ['canvas']
    static values = {
        type: {
            type: String,
            default: 'line'
        },
        data: Object,
        options: Object
    }

    connect() {
        const element = this.hasCanvasTarget ? this.canvasTarget : this.element

        this.chart = new Chart(element.getContext('2d'), {
            // @ts-ignore
            type: this.typeValue, // @ts-ignore
            data: this.chartData, // @ts-ignore
            options: this.chartOptions
        })
    }

    disconnect() {
        this.chart.destroy()
        this.chart = undefined
    }

    get chartData() {
        if (!this.hasDataValue) {
            console.warn('[stimulus-chart] You need to pass data as JSON to see the chart.')
        }

        return this.dataValue
    }

    get chartOptions() {
        return {
            ...this.defaultOptions,
            ...this.optionsValue
        }
    }

    get defaultOptions() {
        return {}
    }
}
