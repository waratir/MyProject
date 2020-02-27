/**
 * Created by Zhan.Demo on 25.02.2020.
 */

public with sharing class sendEmailWithCriteria {
    public List<SObject> sObjects;
    public String templName;
    public Date selectDate;
    public String criteria;

    public sendEmailWithCriteria(List<SObject> sObjects, String templateName, Date selectDate, String criteria) {
        this.sObjects = sObjects;
        this.templName = templateName;
        this.selectDate = selectDate;
        this.criteria = criteria;
    }

    public String createStringCriteria(String criteria) {
        String createdString;

        switch on criteria {
            when 'Every year' {
                createdString = '0 0 13 ' + selectDate.day() + ' ' + selectDate.month() + ' ?  *';
            }
            when 'Every month' {
                createdString = '0 0 13 ' + selectDate.day() + ' *' + ' ?  *';
            }
            when 'Every day' {
                createdString = '0 0 13 * * ?';
            }
        }
        return createdString;
    }

    public void sendEmailMethod() {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses =
        message.optOutPolicy = 'FILTER';
        message.setTemplateId([SELECT Id FROM EmailTemplate WHERE Name =: templName].Id);
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