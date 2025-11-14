// Clean the global context.
function cleanupHook() {
	window.loadDataToForm = null;
}

// Parse URL and get everything after the question mark
function loadDataToForm() {	
 	
	// Extract the string after the last question mark in URL and treat it as a "query string"
	const url = window.location.href;
	const match = url.match(/\?([^?]*)$/);
	const queryString = match ? match[1] : null;
	
	if (queryString) {
		const params = new URLSearchParams(queryString);
		for (const [key, value] of params.entries()) {
			setValueNotify(value, key);
		}
	}
}

// Helper function to notify element that it has new value.
function setValueNotify(newValue, elementId) {
	const elem = document.getElementById(elementId);
	elem.value = newValue;
	elem.dispatchEvent(new Event("input"));
}

// Trigger the function when the form loads.
loadDataToForm();
