import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getDecryptedRecordId from '@salesforce/apex/EncryptDecryptHandler.getDecryptedRecordId';

export default class CustomerProfile extends LightningElement {

  recordId;

    // @wire(CurrentPageReference)
    // getStateParams(currentPageReference) {
    //     console.log('inside page reference wire method');
    //     if (currentPageReference) {
    //         const encryptedRecordId = currentPageReference.state.recordId;
    //         console.log('encryptedRecordId---->', encryptedRecordId);
    //         if (encryptedRecordId) {
    //             getDecryptedRecordId({ encryptedId: encryptedRecordId })
    //                 .then(result => {
    //                     this.recordId = result;
    //                     console.log('this.recordId---->', this.recordId);
    //                 })
    //                 .catch(error => {
    //                     console.error('Error decrypting record Id', error);
    //                 });
    //         }
    //     }
    // }

     @wire(CurrentPageReference)
    getStateParams(currentPageReference) {
        console.log('inside page reference wire method');
        if (currentPageReference) {
            this.recordId = currentPageReference.state.recordId;   
        }
    }

    handleSave() {
        console.log('inside save');
        this.template.querySelector('lightning-record-edit-form').submit();
    }

    handleSuccess() {
        const event = new ShowToastEvent({
            title: 'Success',
            message: 'Updated Successfully',
            variant: 'success'
        });
        this.dispatchEvent(event);
    }
}