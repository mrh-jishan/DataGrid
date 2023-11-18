import {Controller} from "@hotwired/stimulus"
import Tagify from '@yaireo/tagify'

// Connects to data-controller="tagify"
export default class extends Controller {

    connect() {
        this.tagify = new Tagify(this.element,{
            originalInputValueFormat: valuesArr => valuesArr.map(item => item.value).join(',')
        });
    }

    disconnect() {
        this.tagify.destroy();
    }
}
