public class ContactBatch extends TimeToExtend {
  public ContactBatch() {
  }
  public static final String JOB_NAME = ContactBatch.class.getName();

  /**
   * Desciption : Normal Batch Calling
   */
  public override Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator([SELECT Id FROM Contact]);
  }

  public override void Execute(
    Database.BatchableContext bc,
    List<Sobject> scope
  ) {
  }

  public override void Finish(Database.BatchableContext bc) {
    completed(JOB_NAME, bc);
  }

  /**
   * @Description : This is for the 1st class to be Scheduled
   */
  public override void Execute(System.SchedulableContext SC) {
    completed(JOB_NAME, SC);
  }
}
