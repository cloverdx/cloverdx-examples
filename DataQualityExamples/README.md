# DataQualityExamples

The aim of the project is to explain basic approaches to data quality in
CloverDX. The graphs are split into four folders each focusing on slightly
different aspect of data quality work with CloverDX.

### Folder `1-basic-validations`

Introduction to
[Validator component](https://doc.cloverdx.com/latest/developer/validator.html)
and how it can be used to validate the data quality with different settings.
The examples show how to configure the Validator to use lazy evaluation, group
rules, and more.

### Folder `2-data-format-validation`

Overview of how you can use _Data policy_ settings in CloverDX
[Reader components](https://doc.cloverdx.com/latest/developer/readers.html) to
handle errors in source files such as extra fields or different data layouts.

### Folder `3-profiling-and-validation`

Shows how you can use
[ProfilerProbe](https://doc.cloverdx.com/latest/developer/profilerprobe.html)
component to measure basic properties of your data and effectively use it to
augment your data validation logic.

### Folder `4-custom-dq-check`

Examples in this folder show how you can implement custom validation rules in
two different ways:

- Using other components besides Data Quality components. The examples also show
how you can then wrap the implementation into a subgraph to make it easier to
use and.
- Using custom validation rules in Validator component.

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
