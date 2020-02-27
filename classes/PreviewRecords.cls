public with sharing class PreviewRecords {

    public static List<SObject> getRecordsForPreview(List<SObject> listSObjects, String fieldDate, String criteria) {

        if (criteria == 'Every year') {
            List<SObject> result = new List<SObject>();
            for (SObject item : listSObjects) {
                System.debug('item.get(fieldDate) ' + item.get(fieldDate));
                System.debug('Date.today() ' + Date.today());
                if (item.get(fieldDate) != null) {
                    if (Date.valueOf(item.get(fieldDate)).day() == Date.today().day() && Date.valueOf(item.get(fieldDate)).month() == Date.today().month()) {
                        result.add(item);
                    }
                }
            }
            return result;
        }
        if (criteria == 'Every month') {
            List<SObject> result = new List<SObject>();
            for (SObject item : listSObjects) {
                if (item.get(fieldDate) != null) {
                    Integer dateField = Date.valueOf(item.get(fieldDate)).day();
                    if (dateField == System.now().day() || dateField > Date.daysInMonth(System.now().year(), System.now().month())) {
                        result.add(item);
                    }
                }
            }
            return result;
        }
        return null;
    }

}