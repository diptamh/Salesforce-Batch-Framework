# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)



### How to use this Batch Framework

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

  public override void Execute(
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
  public override void Finish(Database.BatchableContext bc) {
    completed(JOB_NAME, bc);
  }

  /**
   * @Description : completed method calling is mandatory
   */
  public override void Execute(System.SchedulableContext SC) {
    completed(JOB_NAME, SC);
  }
}
```

2. After the Batch is done create a Mater record in ```Time Warp Scheduler``` Give it a name and the Cron Expression on when it will be scheduled to run.

3. Then Create the Record line items to add the classes names in the ```Time Lines``` record tab. Add the class name in the field Class Name and the number on the sequence it will run in Run Sequence field.

After the above steps are done. It will be scheduled and run accordingly.