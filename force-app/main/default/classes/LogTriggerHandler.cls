/**
 * @description       : LogTriggerHandler
 * @author            : agentgill
 * @group             :
 * @last modified on  : 03-26-2021
 * @last modified by  : agentgill
 * Modifications Log
 * Ver   Date         Author      Modification
 * 1.0   02-18-2021   agentgill   Initial Version
 **/
public inherited sharing class LogTriggerHandler extends TriggerHandler {
  List<Log__e> incomingRecords = new List<Log__e>();

  /**
   * @description Contructor
   * @author agentgill | 02-18-2021
   **/
  public LogTriggerHandler() {
    this.incomingRecords = (List<Log__e>) Trigger.new;
    System.debug(LoggingLevel.ERROR, '>>>' + incomingRecords);
  }

  /**
   * @description after Insert
   * @author agentgill | 02-18-2021
   **/
  override public void afterInsert() {
    List<LogEvent__c> events = new List<LogEvent__c>();

    for (Log__e event : this.incomingRecords) {
      events.add(
        new LogEvent__c(
          Log_Data__c = event.Log_Message__c,
          Quiddity__c = event.Quiddity__c,
          Request_Id__c = event.request_id__c,
          Severity__c = event.severity__c,
          Source__c = event.Source__c,
          Salesforce_Record_Id__c = event.Salesforce_Record_Id__c
        )
      );
    }

    List<Database.SaveResult> res = Database.insert(events, false);
    for (Database.SaveResult saveRes : res) {
      if (!saveRes.isSuccess()) {
        System.debug(
          LoggingLevel.ERROR,
          'Failed to save log message: ' + saveRes
        );
      }
    }
  }
}
