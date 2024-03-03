import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

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
    
    handleSave() {
        console.log("inside save");
        this.template.querySelector("lightning-record-edit-form").submit();
    }

    handleSuccess() {
        const event = new ShowToastEvent({
            title: "Success",
            message: "Updated Successfully",
            variant: "success"
        });
        this.dispatchEvent(event);
    }
}
