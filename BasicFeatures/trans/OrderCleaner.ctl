// This is a shared source file used by exercises in module 5.

// Clean the orderId value and test if it can be converted to valid id.
// Cleanup removes extra characters from the order (dash and a number at the end).
// Validity test tests if the cleaned value is a long number. 
function long cleanOrderId(string orderId) {
	if (orderId == null) {
		raiseError("Missing orderId value.");
	}
	
	string orderIdPrefix = replace(orderId, "-.*", "");
	
	if (!isLong(orderIdPrefix)) {
		raiseError("Invalid orderId - not a number.");
	}
	
	return str2long(orderIdPrefix);
}

// Parse and validate payment date.
// This function can parse payment dates in three different formats. Validation includes date format check
// as well as date validity check (some of the input dates cannot be parsed at all).
function date parsePaymentDate(string paymentDate) {
	string dateFormat;
	switch (length(paymentDate)) {
		case 19:
			dateFormat = "yyyy-MM-dd HH:mm:ss";
			break;
			
		case 14:
			dateFormat = "yyyyMMddHHmmss";
			break;
		
		case 12:
			dateFormat = "yyyyMMddHHmm";
			break;
			
		default:
			raiseError("Unsupported date format.");
	}

	// Test if the date can be parsed with the format we expected.	
	if (!isDate(paymentDate, dateFormat, null, "UTC")) {
		// If not, report and error.
		raiseError("Input date is not valid (expected format \"" + dateFormat + "\").");
	}
	
	// Date seems to be valid, parse it.
	return str2date(paymentDate, dateFormat, null, "UTC");
}
