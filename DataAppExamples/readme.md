# Data App Features

This project is a demo of some of the Data App or Data Service features. It showcases the following:

* How to inject custom javascript to a Data App.
* How to use the custom JS to populate default values for various parameters in the Data App.
* How to use the JS to populate a dropdown based on a result of calling a Data Service.
* How to use basic validation on a drop down to allow users to enter custom values as well.
* How to call CloverDX REST API to query job execution history.
* How to ingest dropdown items from another Data Service.
* How to categorize Data Apps in App Catalog.
* Most common use cases for Data Apps - process triggering, file upload, getting just-in-time data reports

The project contains the following REST jobs (all located in data-service directory):
* 1_DataAppWithDefaultValues.rjob - shows how default values can be generated using a linked JavaScript
* 2_DataAppWithAutofilledDropdown.rjob - dropdown items populated using results from a linked data service (data-service/backend-services/GetDropDownItems.rjob)
* 3_DataAppWithAutofilledDropdownViaJS.rjob - dropdown items populated using JavaScript
* 4_ProcessTrigger.rjob - an example of how Data Apps can be used a simple manual trigger without entering backend ops console
* 5_UploadAndProcessFile.rjob - an example of how Data Apps can be used as data ingestor (data can not only be ingested but also further processed)
* 6_RetrieveData.rjob - an example of how Data Aps can be used as a simple reporting tool - providing just-in-time data output in human readable formats 
* 7_RetrieveDataChart.rjob - an example of how Data Aps can output various output formats (in this case SVG)


## Installation

1. Publish the whole project on your CloverDX Server.
2. Publish all Data Services and enable Data Apps from CloverDX Server console.
3. Configure CloverDX access credentials in `clover-server.prm` parameter file. Following parameters need to be configured:

    * `SERVER_URL`: URL of your CloverDX Server. Make sure to include proper protocol, port and path to "clover" application.
    * `USER_NAME`: name of the user that will be used to log-in to CloverDX Server to call the API.
    * `PASSWORD`: password for the user above.

## Usage and licensing

Feel free to reuse or fork this project in your own CloverDX solutions.

Note that the code in this repository is provided on an **"as is" basis, without
warranties or conditions of any kind, either express or implied, including,
without limitation, any warranties or conditions of title, non-infringement,
merchantability, or fitness for a particular purpose.**  

Unless otherwise specified, the code in this repository is licensed under
[Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0).

## Contributing

We welcome your feedback and contributions. You can:
- Submit comments or pull requests here on GitHub.
- Reach out to us through [cloverdx.com](https://www.cloverdx.com).