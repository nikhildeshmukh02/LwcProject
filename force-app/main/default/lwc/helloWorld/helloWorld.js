import { LightningElement, track } from 'lwc';
import { APPLICATION_SCOPE, createMessageContext, MessageContext, publish, releaseMessageContext, subscribe, unsubscribe } from 'lightning/messageService';
export default class HelloWorld extends LightningElement {
    @track enterName = 'World';    //default value
    changeHandler(event) {
        this.enterName = event.target.value; // add enter value in variable 
    }
}