/**
 * @Description : Class to extent by other Batches using this framework to run and scheduele classes
 */
virtual public class TimeToExtend implements Database.Stateful, Database.Batchable<sObject>, Schedulable {
  public List<Time_Lines__c> classesToRun { get; set; }
  public TimeToExtend() {
  }

  /**
   * @Description : Basic Batch Methods which will be overridden by other classes which will be implementing this
   */
  public virtual Database.QueryLocator start(Database.BatchableContext BC) {
    return null;
  }

  public virtual void execute(
    Database.BatchableContext BC,
    List<sObject> scope
  ) {
  }

  public virtual void finish(Database.BatchableContext BC) {
  }

  /**
   * @Description : Basic Execute method of Schedule class which will be overridden by other classes which will be implementing this
   */
  public virtual void execute(System.SchedulableContext sc) {
  }

  /**
   * @Description : Completed to be call by the Finish of the Batch to execute the next Batch
   */
  public virtual void completed(String JOB_NAME, Database.BatchableContext BC) {
    if (this.classesToRun?.isEmpty())
      return;

    Time_Lines__c line = this.classesToRun[0];
    TimeToExtend timerInstance = (TimeToExtend) (Type.forName(
        line.Class_Name__c
      ))
      .newInstance();
    this.classesToRun.remove(this.classesToRun.indexOf(line));
    timerInstance.classesToRun = this.classesToRun;
    Database.executeBatch(timerInstance);
  }

  /**
   * @Description : Completed to be call by the execute of the scheduled class to execute the next Batch
   */
  public virtual void completed(String JOB_NAME, System.SchedulableContext SC) {
    TimeToExtend timerInstance = (TimeToExtend) Type.forName(JOB_NAME)
      .newInstance();

    List<Time_Lines__c> timeWrappers = [
      SELECT id, Class_Name__c, Time_Warp_Scheduler__c
      FROM Time_Lines__c
      WHERE Class_Name__c = :JOB_NAME
      LIMIT 1
    ];

    List<Time_Lines__c> timeLines = [
      SELECT id, Class_Name__c, Time_Warp_Scheduler__c
      FROM Time_Lines__c
      WHERE
        Time_Warp_Scheduler__c = :timeWrappers[0].Time_Warp_Scheduler__c
        AND Class_Name__c != :JOB_NAME
      ORDER BY Run_Sequence__c ASC
    ];

    timerInstance.classesToRun = timeLines;
    Database.executeBatch(timerInstance);
  }
}
