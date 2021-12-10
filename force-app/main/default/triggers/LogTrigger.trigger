/**
 * @description       : LogTrigger
 * @author            : agentgill
 * @group             :
 * @last modified on  : 03-04-2021
 * @last modified by  : agentgill
 * Modifications Log
 * Ver   Date         Author      Modification
 * 1.0   02-18-2021   agentgill   Initial Version
 **/
trigger LogTrigger on Log__e(after insert) {
  new LogTriggerHandler().run();
}
