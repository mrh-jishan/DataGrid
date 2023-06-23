// app/javascript/controllers/editable_controller.js
import {Controller} from '@hotwired/stimulus';
import mrujs from 'mrujs';

export default class extends Controller {
    static targets = ['input'];

    edit() {
        const input = document.createElement('input');
        input.value = this.element.innerText;
        this.element.innerHTML = '';
        this.element.appendChild(input);
        input.focus();

        input.addEventListener('blur', () => {
            const newValue = input.value;
            const id = this.element.parentElement.dataset.id;
            const itemId = this.element.parentElement.dataset.itemId;
            const columnName = this.element.dataset.columnName;

            // Send an AJAX request to update the data
            this.updateData(itemId, id, columnName, newValue);
        });
    }

    updateData(itemId, id, columnName, newValue) {
        const url = `/file_uploads/${itemId}/csv_rows/${id}`;
        const csrfToken = document.querySelector("meta[name='csrf-token']").content;
        const params = {
            _method: 'patch',
            file_upload: {
                [columnName]: newValue
            }
        };

        mrujs.fetch(url, {
            method: 'PATCH',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': csrfToken
            },
            body: JSON.stringify(params)
        })
            .then(response => response.json())
            .then(data => {
                // Handle the response or perform any necessary DOM updates
            })
            .catch(error => {
                // Handle errors, if any
            });
    }
}
