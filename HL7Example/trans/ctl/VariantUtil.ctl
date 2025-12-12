import "${TRANS_DIR}/ctl/Common.ctl";

// Not a constant so that it can be changed by caller if needed.
string VARIANT_CONV_DEFAULT_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss.SSS";

// If set to true, various casting functions will verify if they are not casting to smaller type. E.g. long to integer will not be allowed.
// If set to false, the functions will apply default conversion that will result in loss of precision (e.g. number to integer will truncate the number).
// Set this in caller to override.
boolean STRICT_TYPE_CASTING = false;

// Get keys from variant map as string. This assumes that variant is a map[string, variant].
function string[] getVariantKeys(variant v) {
	if (getType(v) != "map") {
		return null;	
	}
	
	string[] result;
	
	foreach (variant k: getKeys(v)) {
		push(result, toString(k));
	}
	
	return result;
}

// Assumes that all elements in the list are the same (which does not have to be the case in variant.
function string getVariantListInnerType(variant v) {
	if (v == null) {
		return null;
	}
	
	if (getType(v) != "list") {
		raiseError("List variant expected.");
	}
	
	if (length(v) == 0) {
		// Empty list, cannot determine type.
		return null;
	}
	
	return getType(v[0]);
}

function string variantToString(variant v) {
	if (v == null) {
		return null;
	}
	
	string type = getType(v);
	if (type != "list") {
		return variantFlatToString(v);
	}
	
	if (type == "list") {
		return variantListToString(v);
	}
	
	raiseError("Unsupported variant struture. Code: 0x233003042020.");
}

// Convert single value (not a list or map) to a string.
function string variantFlatToString(variant v) {
	if (v == null) {
		return null;
	}
	
	switch (getType(v)) {
		case "string":
			return cast(v, string);
			
		case "integer":
		case "long":
		case "boolean":
		case "number":
		case "double":
		case "decimal":
			return toString(v);

		case "date":
			return date2str(cast(v, date), VARIANT_CONV_DEFAULT_DATE_FORMAT);
			
		default:
			raiseError("Unsupported type \"" + getType(v) + "\". Error code: 0x232403042020.");
	}
}

function string variantListToString(variant v) {
	if (v == null) {
		return null;
	}
	
	return toString(v);
}

function integer variantToInteger(variant v) {
	if (v == null) {
		return null;
	}
	
	switch (getType(v)) {
		case "string":
			return str2integer(trimToNull(cast(v, string)));
			
		case "integer":
			return cast(v, integer);
			
		case "long":
			strictTypeCheckError("long", "integer");
			return long2integer(cast(v, long));
			
		case "boolean":
			return cast(v, boolean) ? 1 : 0;
			
		case "number":
		case "double":
			strictTypeCheckError("number", "integer");
			return double2integer(cast(v, number));
			
		case "decimal":
			strictTypeCheckError("decimal", "integer");
			return decimal2integer(cast(v, decimal));
			
		case "date":
			strictTypeCheckError("date", "integer");
			return long2integer(date2long(cast(v, date)));
		
		default:
			raiseError("Unsupported variant type \"" + getType(v) + "\".");
	}
}

function long variantToLong(variant v) {
	if (v == null) {
		return null;
	}
	
	switch (getType(v)) {
		case "string":
			return str2long(trimToNull(cast(v, string)));
			
		case "integer":
			return cast(v, integer);
			
		case "long":
			return cast(v, long);
			
		case "boolean":
			return cast(v, boolean) ? 1 : 0;
			
		case "number":
		case "double":
			strictTypeCheckError("number", "long");
			return double2integer(cast(v, number));
			
		case "decimal":
			strictTypeCheckError("decimal", "long");
			return decimal2integer(cast(v, decimal));
			
		case "date":
			// TODO maybe? strictTypeCheckError("date", "long");
			return date2long(cast(v, date));
		
		default:
			raiseError("Unsupported variant type \"" + getType(v) + "\".");
	}
}

function date variantToDate(variant v) {
	if (v == null) {
		return null;
	}
	
	switch (getType(v)) {
		case "date":
			return cast(v, date);
			
		case "string":
			return str2date(trimToNull(cast(v, string)), VARIANT_CONV_DEFAULT_DATE_FORMAT);
			
		case "integer":
			strictTypeCheckError("integer", "date");
			return long2date(cast(v, integer));
			
		case "long":
			strictTypeCheckError("long", "date");
			return long2date(cast(v, long));
			
		case "boolean":
		case "number":
		case "decimal":
		case "double":
			unsupportedConversionError(getType(v), "date");
		
		default:
			raiseError("Unsupported variant type \"" + getType(v) + "\".");
	}
}

function number variantToNumber(variant v) {
	if (v == null) {
		return null;
	}
	
	switch (getType(v)) {
		case "string":
			// TODO: this is only needed since Hubspot API is insane and writes out floating-point numbers with 53 decimal places.
			return decimal2double(str2decimal(trimToNull(cast(v, string))));
			//return str2double(cast(v, string));
			
		case "integer":
			// TODO do strict type check here?
			return cast(v, integer);
			
		case "long":
			// TODO do strict type check here?
			return cast(v, long);
			
		case "boolean":
			return cast(v, boolean) ? 1.0f : 0.0f;
			
		case "number":
		case "double":
			return cast(v, number);
			
		case "decimal":
			// TODO do strict type check here?
			return decimal2double(cast(v, decimal));

		case "date":
			strictTypeCheckError("date", "number");
			return date2long(cast(v, date));
		
		default:
			raiseError("Unsupported variant type \"" + getType(v) + "\".");
	}
}

function decimal variantToDecimal(variant v) {
	if (v == null) {
		return null;
	}
	
	switch (getType(v)) {
		case "string":
			return str2decimal(trimToNull(cast(v, string)));
			
		case "integer":
			return cast(v, integer);
			
		case "long":
			return cast(v, long);
			
		case "boolean":
			return cast(v, boolean) ? 1d : 0d;
			
		case "number":
		case "double":
			return cast(v, number);
			
		case "decimal":
			return cast(v, decimal);

		case "date":
			return date2long(cast(v, date));
		
		default:
			raiseError("Unsupported variant type \"" + getType(v) + "\".");
	}
}

function boolean variantToBoolean(variant v) {
	if (v == null) {
		return null;
	}
	
	switch (getType(v)) {
		case "string":
			switch (lowerCase(cast(v, string))) {
				case "true":
				case "yes":
				case "t":
					return true;
				
				case "false":
				case "no":
				case "f":
					return false;
					
				case "null":
				case "":
					return null;
					
				default:
					raiseError("Unknown value for a boolean \"" + v + "\".");
			}
			
		case "integer":
			strictTypeCheckError("integer", "boolean");
			return cast(v, integer) != 0;
			
		case "long":
			strictTypeCheckError("long", "boolean");
			return cast(v, long) != 0;
			
		case "boolean":
			return cast(v, boolean);
			
		case "number":
		case "double":
			strictTypeCheckError("number", "boolean");
			return cast(v, number) != 0.0f; // TODO do (-epsilon, epsilon) range check here?
			
		case "decimal":
			strictTypeCheckError("decimal", "boolean");
			return cast(v, decimal) != 0.0d;

		case "date":
			unsupportedConversionError("date", "boolean");
		
		default:
			raiseError("Unsupported variant type \"" + getType(v) + "\".");
	}
}
// Raise error if strict type checking is enabled.
function void strictTypeCheckError(string inType, string outType) {
	if (STRICT_TYPE_CASTING == true) {
		raiseError("Strict type conversions prevent conversion from \"" + inType + "\" to \"" + outType + "\".");
	}
	
	// Do nothing if strict types are not enabled.
}

function void unsupportedConversionError(string inType, string outType) {
	raiseError("Unsupported conversion from \"" + inType + "\" to \"" + outType + "\".");
}

// Find all objects in variant that match given name. Name match must be exact. 
// Returns list of objects { string _path, string _query, variant _value } where path is the _path to given value, _value
// is the object itself and _query represents input search string.
// Path is composed of path elements separated by "/". Lists use "[i]" syntax to represent list elements. First
// element has index of 0.
// Returns null if the value was not found.
// Example path: /HL7/INTERCHANGE/GROUP/MSG_ORU/MSH or /HL7/INTERCHANGE/GROUP/MSG_ORU/GROUP_1/GROUP_4/GROUP_5/[3]/OBX
function variant[] findAllElementsByName(string name, variant input) {
	return findElementByNameImpl(name, input, "");
}

// Returns list of objects that match given name (exact match is needed). Implemented as depth first search.
// This is the "worker" method of the recursive algorithm.
function variant[] findElementByNameImpl(string name, variant input, string currentPath) {
	if (getType(input) != "map" && getType(input) != "list") {
		return null;
	}
	
	variant[] result;
		
	if (getType(input) == "map") {
		string[] keys = getVariantKeys(input);
		
		foreach (string key: keys) {
			if (key == name) {
				append(result, {
					"_path" -> currentPath + "/" + key,
					"_query" -> name,
					"_value" -> input[key]
				});
			} else {
				variant[] resultPartial = findElementByNameImpl(name, input[key], currentPath + "/" + key);
				
				if (resultPartial != null) {
					copy(result, resultPartial);
				}
			}
		}
	} else if (getType(input) == "list") {
		for (integer i = 0; i < length(input); ++i) {
			variant[] resultPartial = findElementByNameImpl(name, input[i], currentPath + "/[" + i + "]");
			
			if (resultPartial != null) {
				copy(result, resultPartial);
			}
		}
	}
	
	return length(result) == 0 ? null : result;
}

function variant getFirstElementByName(string name, variant input) {
	variant[] elems = findAllElementsByName(name, input);
	return elems[0]["_value"];
}
