## How to use this Batch Framework

1. Need to Write the batches in this format as given below:

```
public class ContactBatch extends TimeToExtend {
  public ContactBatch() {
  }
  public static final String JOB_NAME = ContactBatch.class.getName();

  /**
   * Desciption : Normal Batch Calling
   */
  public override Database.QueryLocator start(Database.BatchableContext bc) {
    /**
    * @Todo : Write SOQL to return below
    */
    return Database.getQueryLocator([SELECT Id FROM Contact]);
  }

  public override void execute(
    Database.BatchableContext bc,
    List<Sobject> scope
  ) {
    /**
    * @Todo : Write the execute logic here
    */
  }

  /**
   * @Description : completed method calling is mandatory
   */
  public override void finish(Database.BatchableContext bc) {
    completed(JOB_NAME, bc);
  }

  /**
   * @Description : completed method calling is mandatory
   */
  public override void execute(System.SchedulableContext SC) {
    completed(JOB_NAME, SC);
  }
}
```

2. After the Batch is done create a Mater record in `Time Warp Scheduler` Give it a name and the Cron Expression on when it will be scheduled to run.

3. Then Create the Record line items to add the classes names in the `Time Lines` record tab. Add the class name in the field Class Name and the number on the sequence it will run in Run Sequence field.

After the above steps are done. It will be scheduled and run accordingly.
