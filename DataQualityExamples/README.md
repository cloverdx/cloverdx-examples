# DataQualityExamples

The aim of the project is to explain basic approaches to data quality in CloverDX. Under graph folder, there are four directories with example graphs demonstrating basic data quality techniques in CloverDX.

### 01-basic-validations folder

Introduction to [Validator component](https://doc.cloverdx.com/latest/developer/validator.html) and how it can be used to validate the data quality with different settings. The examples show how to cofigure the Validator to use lazy evaluation, group rule, and more.

### 02-alternative-data-format-handling folder

Overview of how you can use Data policy settings in CloverDX [Reader components](https://doc.cloverdx.com/latest/developer/readers.html) to handle errors in source files such as extra fields or different data layouts.

### 03-sequential-dq-check folder

Shows how you can use ProfilerProbe component to measure basic properties of your data and effectively use it to augment your data validation logic.
* Sequential data quality processing - Profiling data first using ProfilerProbe component and record validation in the next step.
* Uses phases to ensure data is not validated/processed before entire dataset is profiled.

### 04-custom-dq-check folder

Custom data quality using coding approach. The examples show that data quality is not always done solely by Data Quality components from CloverDX, but often by other components (Aggregate, Dedup, etc.). These components can be used to build custom validation rules - like subset validation, foreign key checks, etc. Data quality is al
* Another example in this folder demonstrates how-custom logic can be wrapped into reusable custom components (subgraphs)