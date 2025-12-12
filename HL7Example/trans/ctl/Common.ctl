
// Trim string and return null if the result is empty string.
function string trimToNull(string s) {
	string r = trim(s);
	if (r == "") {
		return null;
	}
	return r;
}

// Same as trimToNull, but convert result to upper case.
function string trimToNullUp(string s) {
	string r = trim(s);
	if (r == "") {
		return null;
	}

	return upperCase(r);
}

// Same as trimToNull, but convert result to lower case.
function string trimToNullLow(string s) {
	string r = trim(s);
	if (r == "") {
		return null;
	}

	return lowerCase(r);
}

function string[] trimToNull(string[] s) {
	if (s == null) {
		return null;
	}
	
	string[] result;
	foreach (string t: s) {
		push(result, trimToNull(t));
	}
	
	return result;
}

function string[] trimToNullLow(string[] s) {
	if (s == null) {
		return null;
	}
	
	string[] result;
	foreach (string t: s) {
		push(result, trimToNullLow(t));
	}
	
	return result;
}

function string[] trimToNullUp(string[] s) {
	if (s == null) {
		return null;
	}
	
	string[] result;
	foreach (string t: s) {
		push(result, trimToNullUp(t));
	}
	
	return result;
}

// Remove characters specified in chars from the input string.
function string trimChars(string input, string chars) {
	integer start = 0;
	integer end = length(input) - 1;

	while (start < length(input)) {
		if (indexOf(chars, charAt(input, start)) < 0) {
			break;
		}
		start++;
	}
	
	if (start < length(input) - 1) {
		while (end > start) {
			if (indexOf(chars, charAt(input, end)) < 0) {
				break;
			}
			end--;
		}
	}
	
	return substring(input, start, end - start + 1);
}

// Concatenate all non-empty and non-null strings from the input list. List entries will be separated
// by provided delimiter. The input elements are not trimmed automatically. 
function string joinNonEmpty(string delimiter, string[] input) {
	return joinNonEmpty(delimiter, input, false);
}

// Concatenate all non-empty and non-null strings from the input list. List entries will be separated
// by provided delimiter. If autoTrim is set to true, all field values are trimmed (via trimToNull)
// before they are compared with null.
function string joinNonEmpty(string delimiter, string[] input, boolean autoTrim) {
	if (input == null) {
		return null;
	}
	
	string[] nonEmpty;
	foreach (string s: input) {
		if (autoTrim) {
			s = trimToNull(s);
		}
		if (s != null && !isBlank(s)) {
			push(nonEmpty, s);
		}
	}
	
	if (length(nonEmpty) == 0) {
		return null;
	}

	return join(delimiter, nonEmpty);
}

// Get rid of all white-space characters and replace them with regular spaces. Also replace runs of multiple white-spaces with a single space.
function string collapseSpaces(string input) {
	return replace(input, "\\s+", " ");
}

function string safeCharAt(string s, integer pos) {
	if (s == null) {
		return null;
	}
	
	if (pos < 0 || pos >= length(s)) {
		return null;
	}
	
	return charAt(s, pos);
}

// Concatenate list elements without modifying any list.
function string[] concatList(string[] a, string[] b) {
	string[] result;
	
	if (a != null) {
		result = copy(result, a);
	}
	
	if (b != null) {
		result = copy(result, b);
	}
	
	return result;
}

function map[string, integer] makeMapSet(string[] keys) {
	map[string, integer] result;
	
	if (keys == null || length(keys) == 0) {
		return result;
	}
	
	foreach (string key: keys) {
		result[key] = nvl(result[key], 0) + 1;
	}
	
	return result;
}

function string prettyPrintMap(map[string, integer] m, string keyValueSeparator, string entrySeparator) {
	string[] keyValuePairs;
	string[] keys = getKeys(m);
	
	keys = sort(keys);
	
	foreach (string k: keys) {
		push(keyValuePairs, k + keyValueSeparator + m[k]);
	}
	
	return join(entrySeparator, keyValuePairs);
}

function string prettyPrintList(string[] l, string elemSeparator) {
	return join(elemSeparator, l);
}

// Replace parameter references in template code with values of parameters from the map. Parameters in template are
// written as %{NAME} where NAME is a case-sensitive parameter name. Parameter values are then provided in the map as
// NAME -> "value" pairs. 
function string evaluateTemplate(string template, map[string, string] parameters) {
	string[] keys = getKeys(parameters);
	string result = template;
	
	foreach (string key: keys) {
		result = replaceAllNoRegexp(result, "%{" + key + "}", parameters[key]);
	}
	
	result = replace(result, "\\$%", "\\$");

	return result;
}

// This function replaces all occurrences of searchText in inText with withText. This is NOT the same as replace function
// since this function does not allow regular expressions. It can therefore also be used in cases where the searchText
// or withText contain special characters that would need to be escaped in regex.
// This 
function string replaceAllNoRegexp(string inText, string searchText, string withText) {
	if (inText == null) {
		return null;
	}

	// Contains pieces of the inText that DO NOT contain the searchText with replacements added in between after each one.
	string[] resultBuffer = [];
	
	// Search starting from this point. Since replacement cannot be of negative length, we can always resume searching
	// for next searchText occurence from the point where it was found before + length of the withText (since we do not
	// want to replace in the withText as that would lead to infinite recursion).
	// We start from negative length of searchText so that first loop starts from 0.
	integer currentSearchStart = -length(searchText);

	while (currentSearchStart < length(inText) - length(searchText)) {
		currentSearchStart += length(searchText);
		integer nextPos = indexOf(inText, searchText, currentSearchStart);
		if (nextPos < 0) {
			// Not found, so everything from our starting position to the end of string needs to be added to our buffer
			// since it does not contain our search text and there is no need to continue after that.
			append(resultBuffer, substring(inText, currentSearchStart));
			break;
		}
		
		// Found our searchText. We need to take middle of the string from previous occurrence (which was alrady
		// processed), add it to the buffer and then also add the replacement there.
		append(resultBuffer, substring(inText, currentSearchStart, nextPos - currentSearchStart));
		append(resultBuffer, withText);
		currentSearchStart = nextPos;
	}
	
	return join("", resultBuffer);
}

// Normalize string so that it can be used as CTL identifier - must only contain letter, numbers, underscore.
function string normalizeIdentifier(string str) {
	string ident = replace(trim(str), "[^a-zA-Z0-9_]", "_");
	ident = replace(ident, "_+", "_");
	
	if (isNumber(left(ident, 1))) {
		ident = "_" + ident;
	}
	
	return ident;
}
