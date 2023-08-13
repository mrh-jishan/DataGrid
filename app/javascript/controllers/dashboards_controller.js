import {Controller} from "@hotwired/stimulus"
import Chart from 'chart.js/auto';
import mrujs from "mrujs";
import Sortable from "sortablejs";

// Connects to data-controller="dashboards"
export default class extends Controller {

    static targets = ['canvas', 'headers', 'columnNames', 'groupBy']

    static values = {
        type: {
            type: String,
            default: 'line'
        },
        data: Object,
        options: Object,
        headers: [],
        rows: []
    }

    connect() {
        (async () => {
            new Sortable(this.headersTarget, {
                animation: 150,
                group: {
                    name: 'shared',
                    pull: true,
                    put: true
                },
                onEnd: (ev) => onEndChange(ev),
            });

            const sortableColumnName = new Sortable(this.columnNamesTarget, {
                animation: 150,
                group: {
                    name: 'shared',
                    pull: true,
                    put: true
                },
                onEnd: (ev) => onEndChange(ev),
            });

            const sortableGroupBy = new Sortable(this.groupByTarget, {
                animation: 150,
                group: {
                    name: 'shared',
                    pull: true,
                    put: true,
                    // put: (to) => {
                    //     return to.el.children.length < 1;
                    // }
                },
                onEnd: (ev) => onEndChange(ev),
            });

            const ctx = this.canvasTarget.getContext('2d');
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
                    }
                }
            });

            const onEndChange = (ev) => {
                const columnNames = Array.from(sortableColumnName.el.children)
                    .reduce((accumulator, currentValue) => ({
                        ...accumulator,
                        [currentValue.dataset.name]: currentValue.dataset.type
                    }), {})

                const groupBy = Array.from(sortableGroupBy.el.children)
                    .reduce((accumulator, currentValue) => ({
                        ...accumulator,
                        [currentValue.dataset.name]: currentValue.dataset.type
                    }), {})

                const queryParams = new URLSearchParams({
                    column_names: encodeURIComponent(JSON.stringify(columnNames)),
                    group_by: encodeURIComponent(JSON.stringify(groupBy)),
                });
                const fileUploadId = this.element.dataset.index;

                mrujs.fetch(`/file_uploads/${fileUploadId}/csv_rows.json?${queryParams}`)
                    .then((response) => response.json())
                    .then(res => {
                        const colors = generateDistinctColors([...Object.keys(groupBy), ...Object.keys(columnNames)].length * 4)
                        Object.keys(groupBy).forEach((gKey) => {
                            const newData = {
                                labels: res.map(r => r[toParameterizedUnderscore(gKey)]),
                                datasets:
                                    [
                                        ...Object.keys(columnNames).map((key, index) => {
                                            const attr = `${toParameterizedUnderscore(key)}_${columnNames[key]}`
                                            return {
                                                label: key,
                                                data: res.map(d => d[attr]),
                                                backgroundColor: colors[index],
                                                borderColor: colors[index + 1],
                                                borderWidth: 1,
                                            }
                                        }),
                                        ...Object.keys(groupBy).map((key, index) => {
                                            const attr = `${toParameterizedUnderscore(key)}_${groupBy[key]}`
                                            return {
                                                label: key,
                                                data: res.map(d => d[attr]),
                                                backgroundColor: colors[index],
                                                borderColor: colors[index + 1],
                                                borderWidth: 1,
                                            }
                                        }),

                                    ]
                            };
                            chart.data.datasets = newData.datasets
                            chart.data.labels = newData.labels;
                            chart.update()
                        })
                    })
            }


            const generateDistinctColors = (count) => {
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


            const toParameterizedUnderscore = (str) => {
                return str
                    .trim() // Remove leading and trailing whitespace
                    .toLowerCase() // Convert to lowercase
                    .replace(/[^a-zA-Z0-9]+/g, "_"); // Replace non-alphanumeric characters with underscores
            }
        })()
    }
}
