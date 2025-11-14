// Clean the global context.
function cleanupHook() {
	window.loadDataToEnum = null;
}

// Call CloverDX Data Service to query recent executions. It is also possible to call any other API or compute the value in other ways.
function loadDataToEnum() {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			// Process web service call result.
			let enumValues = [];

			// Add runs to the dropdown.
			const jobData = JSON.parse(this.responseText);
			setValueNotify(this.responseText, "jobId_input_values");
		}
	};
	
	// Note that we call Data Service here (which will in turn call the REST API). We can also call the REST API directly, however
	// I wanted to show how this can be done with Data Services since the data for dropdowns often comes from sources that
	// are harder to work with in JavaScript (e. g. databases, Excel files, ...).
	xhttp.open("GET", "/clover/data-service/GetDropDownItems", true);
	xhttp.send();
}

// Helper function to notify element that it has new value.
function setValueNotify(newValue, elementId) {
	const elem = document.getElementById(elementId);
	elem.value = newValue;
	elem.dispatchEvent(new Event("input"));
}

// Trigger the function when the form loads.
loadDataToEnum();
