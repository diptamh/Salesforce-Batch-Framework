/**
 * @Description : Example class for quick testing
 */

public class AccountBatch extends TimeToExtend {
  public AccountBatch() {
  }
  public static final String JOB_NAME = AccountBatch.class.getName();

  /**
   * Desciption : Normal Batch Calling
   */
  public override Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator([SELECT Id FROM Account]);
  }
  public override void execute(
    Database.BatchableContext bc,
    List<Sobject> scope
  ) {
    /**
     * Here the Query Execute Condition will go
     */
  }

  public override void finish(Database.BatchableContext bc) {
    completed(JOB_NAME, bc);
  }

  /**
   * @Description : This is for the 1st class to be Scheduled
   */
  public override void execute(System.SchedulableContext SC) {
    completed(JOB_NAME, SC);
  }
}
