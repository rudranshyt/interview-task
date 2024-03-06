import { LightningElement, wire } from 'lwc';
import TshirtFieldValues from '@salesforce/apex/accountPicklistController.TshirtFieldValues';
import shoeSizeFieldValues from '@salesforce/apex/accountPicklistController.shoeSizeFieldValues';
import { CurrentPageReference } from 'lightning/navigation';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getDecryptedRecordId from '@salesforce/apex/EncryptDecryptHandler.getDecryptedRecordId';
import UpdateRecords from '@salesforce/apex/RecordUpdateHelper.UpdateRecords';

export default class CustomerProfile extends LightningElement {

    recordId;
    phoneNumber;
    tshirtValues = [];
    shoeSizeValues = [];
    tshirtSize;
    shoeSize;
    dob;
    
    connectedCallback() {
        TshirtFieldValues().then((result) => {
            this.tshirtValues = result;
            console.log('this.tshirtValues------>', JSON.stringify(this.tshirtValues));
        })
        shoeSizeFieldValues().then((result) => {
            this.shoeSizeValues = result;
        })
    }

    @wire(CurrentPageReference)
    getStateParams(currentPageReference) {
        console.log('inside page reference wire method');
        if (currentPageReference) {
            this.recordId = currentPageReference.state.recordId;   
        }
    }

    handleShoeSize(event) {
        this.shoeSize = event.target.value;
    }
   
    handleTshirtValue(event) {
        this.tshirtSize = event.target.value;
    }

    handlePhoneChange(event) {
        this.phoneNumber = event.target.value;
    }

    handleDob(event) {
        this.dob = event.target.value;
    }

    handleSave() {
        UpdateRecords({
            phone: this.phoneNumber,
            tshirtsize: this.tshirtSize,
            shoesize: this.shoeSize,
            dob: this.dob,
            recordId: this.recordId
        })
        .then(result => {
            
            console.log('Record updated successfully');
            this.showToast("Success", "Updated successfully", "success");
        })
        .catch(error => {
            this.showToast("Error", "could not update", "error");
            console.error('Error updating record---->', error);
        });
    }


    showToast(title, message, variant) {
    this.dispatchEvent(
      new ShowToastEvent({
        title: title,
        message: message,
        variant: variant
      })
    );
  }

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

    

    // handleSave() {
    //     console.log('inside save');
    //     this.template.querySelector('lightning-record-edit-form').submit();
    // }

    // handleSuccess() {
    //     const event = new ShowToastEvent({
    //         title: 'Success',
    //         message: 'Updated Successfully',
    //         variant: 'success'
    //     });
    //     this.dispatchEvent(event);
    // }


}