/**
 * Created by Zhan.Demo on 26.02.2020.
 */

global with sharing class SendEmailBatch2 implements Database.Batchable<SObject> {
    String objectName;
    String fieldName;
    String criteria;

    public SendEmailBatch2(String objectName, String fieldName, String criteria) {
        this.objectName = objectName;
        this.fieldName = fieldName;
        this.criteria = criteria;
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, ' + fieldName + ' FROM ' + objectName);
    }

    global void execute(Database.BatchableContext BC, List<SObject> records) {
        PreviewRecords.getRecords(fieldName, objectName, objectName);
//        for (SObject item : records) {
//
//
//        }
    }

    global void finish(Database.BatchableContext BC) {

    }
}