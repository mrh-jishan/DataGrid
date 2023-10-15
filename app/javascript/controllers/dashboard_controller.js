import {Controller} from "@hotwired/stimulus"
import Chart from 'chart.js/auto';
import mrujs from "mrujs";

// Connects to data-controller="dashboard"
export default class extends Controller {

    static targets = ['canvas']

    static values = {
        type: {
            type: String,
            default: 'line'
        },
        columnNames: {
            type: Object,
            default: {}
        },
        groupBy: {
            type: Object,
            default: {}
        },
        data: Object,
        options: {
            type: Object,
            default: {}
        },
    }

    connect() {
        const element = this.hasCanvasTarget ? this.canvasTarget : this.element
        const ctx = element.getContext('2d');
        const chart = new Chart(ctx, {
            type: this.typeValue,
            data: {
                labels: [],
                datasets: []
            },
            options: {
                plugins: {
                    legend: {
                        // onClick: () => false, // Disable click events on legend labels
                    },
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                ...this.optionsValue
            }
        });

        const fileUploadId = this.element.dataset.index;
        const columnNames = this.columnNamesValue;
        const groupBy = this.groupByValue;

        const queryParams = new URLSearchParams({
            column_names: encodeURIComponent(JSON.stringify(columnNames)),
            group_by: encodeURIComponent(JSON.stringify(groupBy)),
        });

        mrujs.fetch(`/file_uploads/${fileUploadId}/csv_rows.json?${queryParams}`)
            .then((response) => response.json())
            .then(data => {
                const colors = this.generateDistinctColors([...Object.keys(groupBy), ...Object.keys(columnNames)].length * 4)
                const newData = Object.keys(groupBy).map((gKey) => {
                    return {
                        labels: data.map(r => r[this.toParameterizedUnderscore(gKey)]),
                        datasets:
                            [
                                ...Object.keys(columnNames).map((key, index) => {
                                    const attr = `${this.toParameterizedUnderscore(key)}_${columnNames[key]}`
                                    return {
                                        label: key,
                                        data: data.map(d => d[attr]),
                                        backgroundColor: colors[index],
                                        borderColor: colors[index + 1],
                                        borderWidth: 1,
                                    }
                                }),
                                ...Object.keys(groupBy).map((key, index) => {
                                    const attr = `${this.toParameterizedUnderscore(key)}_${groupBy[key]}`
                                    return {
                                        label: key,
                                        data: data.map(d => d[attr]),
                                        backgroundColor: colors[index],
                                        borderColor: colors[index + 1],
                                        borderWidth: 1,
                                    }
                                }),
                            ]
                    };
                })
                chart.data.datasets = newData[0]?.datasets || []
                chart.data.labels = newData[0]?.labels || [];
                chart.update()
            })
    }

    generateDistinctColors = (count) => {
        const colors = [];
        for (let i = 0; i < count; i++) {
            const hue = (i * 360 / count) % 360; // Generate hues equally spaced around the color wheel
            const saturation = 90 + Math.random() * 10; // Random saturation in the range [90, 100]
            const lightness = 50 + Math.random() * 10; // Random lightness in the range [50, 60]
            const color = `hsl(${hue}, ${saturation}%, ${lightness}%)`;
            colors.push(color);
        }
        return colors;
    }

    toParameterizedUnderscore = (str) => {
        return str
            .trim() // Remove leading and trailing whitespace
            .toLowerCase() // Convert to lowercase
            .replace(/[^a-zA-Z0-9]+/g, "_"); // Replace non-alphanumeric characters with underscores
    }
}
