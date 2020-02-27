public with sharing class PreviewRecords {

    public static List<SObject> getRecordsForPreview(String fieldDate, String objectName, String criteria) {
        if (criteria == 'Every year') {
            List<SObject> listSObjects = Database.query('SELECT FirstName, LastName, ' + fieldDate + ' FROM ' + objectName + ' WHERE ' + fieldDate + ' = TODAY');
            return listSObjects;
        }
        if (criteria == 'Every month') {
            List<String> listId = new List<String>();
            AggregateResult[] results = Database.query('SELECT Id, DAY_IN_MONTH(' + fieldDate + ') FROM ' + objectName + ' GROUP BY Id, ' + fieldDate);
            for (AggregateResult item : results) {
                if (item.get('expr0') == System.now().day()) {
                    listId.add(String.valueOf(item.get('Id')));
                }
            }
            System.debug(listId);
            List<SObject> listSObjects = Database.query('SELECT Id, FirstName, LastName, ' + fieldDate + ' FROM ' + objectName + ' WHERE Id IN :listId');
            return listSObjects;
        }
        return null;
    }

    public static List<SObject> getRecordsForBatch(Date fieldDate, String criteria) {
        return null;
    }
}