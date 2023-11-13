public class AccountBatch extends TimeToExtend {
  /**
   * @Constructor : FIX : Add what is the pourpose of this.
   *                      I think this add to create Type class Instance
   */
  public AccountBatch() {
  }

  /**
   * @Desciption : Used to run the classes from outside UI. Feature to be added later.
   */
  public static final String JOB_NAME = AccountBatch.class.getName();

  /**
   * Desciption : Normal Batch Calling
   */

  public override Database.QueryLocator start(Database.BatchableContext bc) {
    /**
     * Here the Query Start Condition will go
     */
    return Database.getQueryLocator([SELECT Id FROM Account]);
  }
  public override void Execute(
    Database.BatchableContext bc,
    List<Sobject> scope
  ) {
    /**
     * Here the Query Execute Condition will go
     */
  }

  public override void Finish(Database.BatchableContext bc) {
    completed(JOB_NAME, bc);
  }

  /**
   * @Description : Normal Scheduling
   */

  public override void Execute(System.SchedulableContext SC) {
    /**
     * FIX: For the 1st Job this will be called form the Trigger to schedule the 1st job
     */

    /**
     * Make the class to store the rest of the List of classes
     */
    completed(JOB_NAME, SC);
  }
}