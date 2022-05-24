@isTest
public with sharing class FacilityTriggerHandlerTest {
    @TestSetup
    static void setup() {
        List<Facility__c> facilityList = new List<Facility__c>();
        List<Patient__c> patientList = new List<Patient__c>();

        for (Integer i = 4; i < 6; i++) {
            facilityList.add(
            new Facility__c(
                Clinic_name__c = 'Test clinic name ' + i,
			    FacilityNumber__c = String.valueOf(i)
            )
        );
        }
        insert facilityList;
        for (Integer i = 0; i < 2; i++) {
            patientList.add(
                new Patient__c(
                    first_name__c = 'Lex',
			 		last_name__c = 'Luthor',
			 		patient_id__c = String.valueOf(i),
			 		facility__c = facilityList[i].id
                )
            );
        }
        insert patientList;
    }

    @isTest
    static void testMethod1() {
        Facility__c deletedFacility = [SELECT id, Clinic_name__c, FacilityNumber__c FROM Facility__c WHERE Clinic_name__c = 'Test clinic name 4'];
        Test.startTest();
        delete deletedFacility;
        Test.stopTest();
        System.assertEquals(2, [SELECT count() FROM Patient__c WHERE Facility__c IN (SELECT Id from facility__c Where Clinic_name__c = 'Test clinic name 5')]);
    }
}