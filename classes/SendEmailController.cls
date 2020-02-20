public with sharing class SendEmailController {
    @AuraEnabled
    public static List<Map<String, String>> getObjectNames() {
        List<Map<String, String>> options = new List<Map<String, String>>();

        List<String> standardObjects = new List<String>{'Contact', 'Account', 'Opportunity'};

        Map<String, SObjectType> objs = Schema.getGlobalDescribe();
        for (String key : objs.keySet()) {
            if (objs.get(key).getDescribe().isCustom() || standardObjects.contains(objs.get(key).getDescribe().getName())) {
                if (checkTypeFields(objs.get(key).getDescribe().getName()) ) {
                    options.add(new Map<String, String>{
                            'label' => objs.get(key).getDescribe().getName(), 'value' => key
                    });
                }
            }
        }
        options.add(new Map<String, String>{
                'label' => '', 'value' => ''
        });
        return options;
    }

    @AuraEnabled
    public static List<Map<String, String>> getFieldNames(String selectedObject) {
        List<Map<String, String>> options = new List<Map<String, String>>();
        options.add(new Map<String, String>{
                'label' => '', 'value' => ''
        });

        Map<String, SObjectField> fields = new Map<String, SObjectField>(Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap());
        Set<String> fieldSet = fields.keySet();
        for (String item : fieldSet) {
            SObjectField fieldToken = fields.get(item);
            DescribeFieldResult selectedField = fieldToken.getDescribe();
            if (selectedField.isAccessible() && selectedField.isCustom()) {
                if (String.valueOf(selectedField.getType()) == 'Date' || String.valueOf(selectedField.getType()) == 'DateTime') {
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

    public static Boolean checkTypeFields(String objectName) {
        Map<String, SObjectField> fields = new Map<String, SObjectField>(Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap());
        Set<String> fieldSet = fields.keySet();
        for (String item : fieldSet) {
            SObjectField fieldToken = fields.get(item);
            DescribeFieldResult selectedField = fieldToken.getDescribe();
            if (selectedField.isAccessible() && selectedField.isCustom()) {
                if (String.valueOf(selectedField.getType()) == 'Date' || String.valueOf(selectedField.getType()) == 'DateTime') {
                    return true;
                }
            }
        }
        return false;
    }
}