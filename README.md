# Salesforce Batch Framework

## Overview
This Salesforce Batch Framework is designed to empower consultants and administrators to efficiently schedule and chain batch jobs written by developers. The framework follows a class design where the custom batch classes extend a base class, providing a structured and scalable solution.

## Class Design
```diff
/**
* @@ Description: For any class where this will be implemented extend the TimeToExtend class @@
*/
public class ContactBatch extends TimeToExtend {
  public ContactBatch() {}
  public static final String JOB_NAME = ContactBatch.class.getName();

  /**
   * @@ Desciption : Normal Batch Calling @@
   */
  public override Database.QueryLocator start(Database.BatchableContext bc) {
    /**
    * + Todo : Write SOQL to return below
    */
    return Database.getQueryLocator([SELECT Id FROM Contact]);
  }

  public override void execute(
    Database.BatchableContext bc,
    List<Sobject> scope
  ) {
    /**
    * + Todo : Write the execute logic here
    */
  }

  /**
   * @@ Description : Here we are calling the completed method which will help in navigating @@
   * @@ through other classes and chaining. @@
   */
  public override void finish(Database.BatchableContext bc) {
    completed(JOB_NAME, bc);
  }

  /**
   * @@ Description : completed method calling is mandatory @@
   */
  public override void execute(System.SchedulableContext SC) {
    completed(JOB_NAME, SC);
  }
}
```

## Time Warp Scheduler

The Time Warp Scheduler is a crucial component of this framework, allowing users to schedule batch jobs with precision.

### Create Master Record

To schedule a batch job, follow these steps:

1. Navigate to the Time Warp Scheduler tab.
2. Create a new Master record.
3. Provide a name for the scheduled job.
4. Specify the Cron Expression for when the job should run.

### Create Record Line Items

Once the Master record is created, proceed to add Record Line Items:

1. Navigate to the Time Lines tab.
2. Create a new Record Line Item.
3. Add the class name in the "Class Name" field.
4. Specify the run sequence in the "Run Sequence" field.
5. Repeat these steps for each class you want to include in the scheduled batch job.


Feel free to customize and extend the framework to meet the specific needs of your Salesforce implementation. If you encounter any issues or have questions, refer to the troubleshooting section or reach out to the development team.

Happy coding!