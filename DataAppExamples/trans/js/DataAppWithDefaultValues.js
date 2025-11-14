// Clean the global context.
function cleanupHook() {
	window.setDefaultParameterValues = null;
}

// Set default values for the three parameters in the Data App.
// Form control names are always NNNN_input where NNNN is name of the parameter as defined in the Data App. Names are
// case sensitive.
function setDefaultParameterValues() {
	setValueNotify(randomInt(0, 1000), "intValue_input");
	setValueNotify(formatDateClover(new Date()), "dateValue_input");
	setValueNotify("Random value is " + randomInt(0, 1000), "stringValue_input");
}

function setValueNotify(newValue, elementId) {
	const elem = document.getElementById(elementId);
	elem.value = newValue;
	elem.dispatchEvent(new Event("input"));
}

function randomInt(min, max) {
	return Math.floor(Math.random() * (max - min) + min);
}

// Format date-time as "yyyy-MM-dd HH:mm:ss".
function formatDateClover(dateVal) {
	return dateVal.getFullYear() + "-" + padNum(dateVal.getMonth() + 1) + "-" + padNum(dateVal.getDate()) + " " +
		padNum(dateVal.getHours()) + ":" + padNum(dateVal.getMinutes()) + ":" + padNum(dateVal.getSeconds());
}

function padNum(value) {
	var x = "00" + value;
	return x.slice(-2);
}

// Trigger the functions when the form loads.
setDefaultParameterValues();
