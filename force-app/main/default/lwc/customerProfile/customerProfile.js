import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';

export default class CustomerProfile extends LightningElement {
    
    recordId = null;

    @wire(CurrentPageReference)
    getStateParams(currentPageReference) {
        console.log('inside page reference wire method');
        if (currentPageReference) {
            const url = new URL(window.location.href);
            const recordId = url.searchParams.get('record-id');
            if (recordId) {
                this.recordId = recordId;
                //console.log('this.recordId----->', this.recordId);
            }
        }
    }
}
