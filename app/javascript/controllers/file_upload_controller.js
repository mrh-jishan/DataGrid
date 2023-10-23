import {Controller} from "@hotwired/stimulus"
import SlimSelect from 'slim-select'

// Connects to data-controller="file-upload"
export default class extends Controller {

    static targets = ['inputFile', 'uniqueBy']

    connect() {
        const element = this.hasInputFileTarget ? this.inputFileTarget : this.element
        const uniqueBy = new SlimSelect({select: this.uniqueByTarget,});
        element.addEventListener('change', function (e) {
            if (e.target.files[0]) {
                const file = e.target.files[0];
                const reader = new FileReader();
                reader.onload = function (e) {
                    const contents = e.target.result;
                    const lines = contents.split("\n");
                    if (lines.length > 0) {
                        const headers = lines[0].split(",").map(header => ({text: header, value: header}));
                        uniqueBy.setData(headers)
                    } else {
                        uniqueBy.setData([])
                    }
                };
                reader.readAsText(file);
            }
        });
    }
}
