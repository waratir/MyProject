public with sharing class SendEmailController {
    @AuraEnabled
    public static List<String> getObjectNames() {
        List<String> names = new List<String>{
                '', 'Contact', 'User', 'Account', 'Opportunity'
        };
        return names;
    }

    @AuraEnabled
    public static List<Map<String, String>> getFieldNames(String selectedObject) {
        List<Map<String, String>> options = new List<Map<String, String>>();
        options.add(new Map<String, String>{
                'label' => '', 'value' => ''
        });

        Map<String, SObjectField> fields = new Map<String, SObjectField>(Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap());
        Set<String> fieldSet = fields.keySet();
        for (String s : fieldSet) {
            SObjectField fieldToken = fields.get(s);
            DescribeFieldResult selectedField = fieldToken.getDescribe();
            if (selectedField.isAccessible()) {
                if (String.valueOf(selectedField.getType()) == 'Date') {
                    options.add(new Map<String, String>{
                            'label' => selectedField.getName().capitalize(), 'value' => String.valueOf(selectedField.getType())
                    });
                }

            }
        }
        return options;
    }

    @AuraEnabled
    public static List<EmailTemplate> TemplatesNames() {
        List<EmailTemplate> options = [SELECT Name, Body FROM EmailTemplate WHERE CreatedDate > 2020-02-04T07:18:20.000Z];
        return options;
    }

    @AuraEnabled
    public static List<sendEmailControll__c> getSendEmailControll() {
        List<sendEmailControll__c> options = [SELECT Data_field__c, Object_Name__c, Email_Template_Name__c, Criterion__c FROM sendEmailControll__c];
        return options;
    }

    @AuraEnabled
    public static void saveData(String selectedObject, String selectField, String selectCriterion, String selectTemplate) {
        sendEmailControll__c record = new sendEmailControll__c(Object_Name__c = selectedObject, Data_field__c = selectField, Criterion__c = selectCriterion, Email_Template_Name__c = selectTemplate);
        insert record;
    }
}