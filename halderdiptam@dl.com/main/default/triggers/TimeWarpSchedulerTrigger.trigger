/**
 * @Description: This Trigger is to capture the Wrap Scheduler and set the Schedule accordingly for the batches to run.
 * @FIX: Make it bulkified.
 */
trigger TimeWarpSchedulerTrigger on Time_Warp_Scheduler__c(after update) {
  List<Time_Lines__c> timeWrappers = [
    SELECT
      id,
      Class_Name__c,
      Time_Warp_Scheduler__r.Time_Crons__c,
      Time_Warp_Scheduler__r.Name
    FROM Time_Lines__c
    WHERE Time_Warp_Scheduler__c = :Trigger.new[0].Id
    ORDER BY Run_Sequence__c ASC
  ];

  Time_Lines__c timeLine = timeWrappers[0];
  String jobID = System.schedule(
    timeLine.Time_Warp_Scheduler__r.Name,
    timeLine.Time_Warp_Scheduler__r.Time_Crons__c,
    (TimeToExtend) (Type.forName(timeLine.Class_Name__c)).newInstance()
  );
}
