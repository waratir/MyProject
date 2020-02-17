public with sharing class createContact {
    public static Integer numContact = 1;

    public static void startJob(){
        Contact contact = new Contact(FirstName = 'FirstName' + numContact, LastName = 'LastName' + numContact);
        insert contact;
        numContact ++;
    }
}