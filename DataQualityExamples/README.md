# DataQualityExamples

The aim of the project is to explain basic approaches to data quality in CloverDX. Under graph folder, there are 4 directories with example graphs demonstrating basic data quality techniques in CloverDX.

### 01-basic-validations
* set of examples explaining basic use of Validator
** including eager and group validation rules


### 02-alternative-data-format-handling
* alternative path in readers for alternative data handling (another data parser, errors etc.)

### 03-sequential-dq-check
* sequential data quality processing - Profiling data first using ProfilerProbe component and record validation in the next step
* uses phases to ensure data is not validated/processed before entire dataset is profiled

### 04-custom-dq-check
* custom data quality using coding approach
* the goal is to explain that DQ is not always done solely by CloverDX DQ prebuilt components, but often users leverage other components (Aggregate, Dedup etc.) to build custom validation rules - like subset validation etc.) or even custom CTL coding
* another example in this folder demonstrates how-custom logic can be wrapped into reusable custom components (subgraphs)