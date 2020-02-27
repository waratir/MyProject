/**
 * Created by Zhan.Demo on 26.02.2020.
 */

global with sharing class SendEmailBatch2 implements Database.Batchable<SObject>, Database.Stateful {
    String objectName;
    String fieldName;
    String criteria;
    String templateName;
    List<SObject> sendEmailTodayRecords = new List<SObject>();

    public SendEmailBatch2(String objectName, String fieldName, String criteria, String templateName) {
        this.objectName = objectName;
        this.fieldName = fieldName;
        this.criteria = criteria;
        this.templateName = templateName;
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, ' + fieldName + ' FROM ' + objectName);
    }

    global void execute(Database.BatchableContext BC, List<SObject> records) {
        sendEmailTodayRecords.addAll(PreviewRecords.getRecordsForPreview(records, fieldName, criteria));
    }

    global void finish(Database.BatchableContext BC) {
        List<String> listId = new List<String>();
        for (SObject item : sendEmailTodayRecords) {
            listId.add(item.Id);
        }
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = listId;
        message.optOutPolicy = 'FILTER';
        message.setTemplateId([SELECT Id FROM EmailTemplate WHERE Name = :templateName].Id);
        Messaging.SingleEmailMessage[] messages =
                new List<Messaging.SingleEmailMessage>{
                        message
                };
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '
                    + results[0].errors[0].message);
        }
    }
}