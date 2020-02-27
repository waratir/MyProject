/**
 * Created by Zhan.Demo on 25.02.2020.
 */

global with sharing class schedulerSendEmail implements Schedulable {
    public List<String> sObjects;
    public String templateName;
    public Date selectDate;
    public String criteria;

    public schedulerSendEmail(List<SObject> sObjects, String templateName) {
        List<String> listId = new List<String>();
        for (SObject item: sObjects){
            listId.add(item.Id);
        }
        this.sObjects = listId;
        this.templateName = templateName;
    }

    global void execute(SchedulableContext ctx) {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = sObjects;
        message.setTemplateId([SELECT Id FROM EmailTemplate WHERE Name =: templateName].Id);
        message.optOutPolicy = 'FILTER';
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