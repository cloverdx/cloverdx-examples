# HL7Example

Training/demo project that shows how to work with **HL7 v2** data in **CloverDX**.

The project focuses on parsing HL7 messages into CloverDX **variant** structures and then using **CTL** to navigate segments/fields and extract values. The included examples are documented with notes directly inside the graphs/jobflows.

## What This Project Demonstrates

- Reading HL7 v2 messages from text files using **HL7 Reader**
- Filtering to a specific message type (**ORU_R01** – observation result)
- Working with parsed HL7 content as **variant** in CTL
- Extracting patient information (PID) and observation text (OBX)
- Orchestrating processing of multiple input files via a **jobflow**
- Writing extracted results to **Excel** and logging run outcomes

## Quick Start

This project has no database dependencies. Input files are included in the project.

1. Open the project in **CloverDX Designer**.
2. Run the jobflow:
   - `jobflow/ProcessHL7Files.jbf`

This jobflow:
- Lists HL7 files in `${DATAIN_DIR}/hl7 v2/*.txt`
- Executes `graph/ProcessHL7File.grf` for each file
- Writes a per-file Excel output and a summary log

## Running a Single File

To process one HL7 file only:

- Run `graph/ProcessHL7File.grf`
- Set the parameter `INPUT_FILE_URL` (defaults to `${DATAIN_DIR}/hl7 v2/patient01.txt`)

### Output

- Excel output is written to: `${DATAOUT_DIR}/Output_${RUN_ID}.xlsx`
  - Sheet `Data` includes:
    - `patientName`
    - `obxText`
- Messages that cannot be parsed or are rejected by the reader go to the “Discarded Messages” path (and are counted in the jobflow summary).

## Notes on the CTL Implementation

The main graph uses CTL that works with the **variant** datatype to:
- Locate `PID.5` anywhere in the message and format a patient name
- Find `OBX` segments and collect text observations (TX) from `OBX.5`

The CTL imports helper functions externalized under:
- `trans/ctl/VariantUtil.ctl`

## Properties

Author: Calvin Cortez <calvin.cortez@cloverdx.com>  
Version: 1.3  
Compatible: CloverDX 7.2+  

## Usage and licensing

Feel free to reuse or fork these projects in your own CloverDX solutions.

Note that the code in this repository is provided on an **"as is" basis, without
warranties or conditions of any kind, either express or implied, including,
without limitation, any warranties or conditions of title, non-infringement,
merchantability, or fitness for a particular purpose.**
Unless otherwise specified, the code in this repository is licensed under
[Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0).

## Contributing

We welcome your feedback and contributions. You can:
- submit comments or pull requests here on GitHub,
- reach out to us through [cloverdx.com](https://www.cloverdx.com).
