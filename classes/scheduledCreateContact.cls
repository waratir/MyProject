/**
 * Created by Zhan.Demo on 04.02.2020.
 */

global with sharing class scheduledCreateContact implements Schedulable {
    global void execute(SchedulableContext SC) {
        createContact.startJob();
        String day = String.valueOf(System.now().day());
        String month = String.valueOf(System.now().month());
        String hour = String.valueOf(System.now().hour());
        String minute = String.valueOf(System.now().minute() + 1);
        String second = String.valueOf(System.now().second());

        String strJobName = 'Job-' + second + '_' + minute + '_' + hour + '_' + day + '_' + month;
        String strSchedule = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?';
        System.schedule(strJobName, strSchedule, new scheduledCreateContact());
    }
}