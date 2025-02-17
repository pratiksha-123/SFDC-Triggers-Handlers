import { LightningElement, track } from 'lwc';
import searchRecords from '@salesforce/apex/SearchController.searchRecords';

export default class SearchComponent extends LightningElement {
    @track searchTerm = '';
    @track records = [];
    
    columns = [
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Email / Phone', fieldName: 'Email', type: 'text' },
        { label: 'Stage / Industry', fieldName: 'StageName', type: 'text' }
    ];

    handleSearch(event) {
        this.searchTerm = event.target.value;

        if (this.searchTerm.length > 2) { // Only search if more than 2 characters
            searchRecords({ searchText: this.searchTerm })
                .then(result => {
                    this.records = result;
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        } else {
            this.records = [];
        }
    }
}
