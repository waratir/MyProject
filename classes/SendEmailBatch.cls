global with sharing class SendEmailBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Object_Name__c, Criterion__c, Data_field__c, Email_Template_Name__c FROM sendEmailControll__c]);
    }

    global void execute(Database.BatchableContext BC, List<sendEmailControll__c> objects) {
        for (sendEmailControll__c item : objects) {
            SendEmailBatch2 batch = new SendEmailBatch2(item.Object_Name__c, item.Data_field__c, item.Criterion__c);
            Database.executeBatch(batch);

//            if (item.Criterion__c == 'Send Email on Birthday') {
//                List<SObject> listRecords = Database.query('SELECT Id, ' + item.Data_field__c + ' FROM ' + item.Object_Name__c + ' WHERE Birthdate = TODAY');
//                String cron = '0 0 13 ' + String.valueOf(System.now().day()) + ' ' + String.valueOf(System.now().month()) + ' ?  *';
//                System.schedule('SendEmailOnBirthday', cron, new schedulerSendEmail(listRecords, item.Email_Template_Name__c));
//            }
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.scheduleBatch(new SendEmailBatch(), 'New Job', 10);
    }

}