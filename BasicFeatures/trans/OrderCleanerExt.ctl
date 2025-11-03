// This is a shared source file used by exercises in module 6.

// Clean the orderId value and test if it can be converted to valid id.
// Cleanup removes extra characters from the order (dash and a number at the end).
// Validity test tests if the cleaned value is a long number. 
function long cleanOrderId(string orderId) {
	if (orderId == null) {
		reportError("Missing orderId value.", "orderId", $in.0.orderId);
	}
	
	string orderIdPrefix = replace(orderId, "-.*", "");
	
	if (!isLong(orderIdPrefix)) {
		reportError("Invalid orderId - not a number.", "orderId", $in.0.orderId);
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
			reportError("Unsupported date format.", "paymentDate", $in.0.paymentDate);
	}

	// Test if the date can be parsed with the format we expected.	
	if (!isDate(paymentDate, dateFormat, null, "UTC")) {
		// If not, report and error.
		reportError("Input date is not valid (expected format \"" + dateFormat + "\").", "paymentDate", $in.0.paymentDate);
	}
	
	// Date seems to be valid, parse it.
	return str2date(paymentDate, dateFormat, null, "UTC");
}

// Global variable that holds the original value of the input. This is done in order not to have to encode the value
// in some complex way so that it can be parsed from the error message.
string __originalValue;

// Report error together with the field name. Note that field name can be null - for example if an error occurred
// in computation that is not related to just a single field. 
function void reportError(string errorMessage, string fieldName, string originalValue) {
	__originalValue = originalValue;
	raiseError(nvl(fieldName, "") + "##" + errorMessage);
}

// Extract error text from error reported via reportError function. Returns null if the error text is empty.
function string getErrorTextFromMessage(string message) {
	integer delim = indexOf(message, "##");
	if (delim < 0) {
		return message;
	}
	
	string result = substring(message, delim + 2);
	return result != "" ? result : null; // Return empty message as null instead of just an empty string.
}

// Extract field name from error reported via reportError function. Returns null if no field name was specified or if the field name is empty.
function string getErrorFieldNameFromMessage(string message) {
	integer delim = indexOf(message, "##");
	if (delim < 0) {
		return null;
	}
	
	string result = left(message, delim);
	return result != "" ? result : null; // Return empty field name as null instead of just an empty string.
}

function string getErrorFieldOriginalValue() {
	return __originalValue;
}
