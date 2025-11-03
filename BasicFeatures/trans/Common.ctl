function string camelCaseName(string input) {
	return upperCase(left(input, 1)) + right(lowerCase(input), length(input) - 1);
}

number SIGMA = 1;
function integer getRandomIntGaussian(integer min, integer max) {
	// This is not entirely correct since generating values from truncated normal distribution is not so easy, but it should work fine.
	// We are using "5 sigma" rule for Normal distribution - we clamp the output to range of [-5*sigma, 5*sigma] - this will cover 99.99994% of values.
	// In our case we are using standard normal distribution generator provided by Clover, so we clamp its output to range [-5, 5] and then "stretch"
	// this to the desired range.
	number g = abs(randomGaussian()); // Use abs so that only clamping to [0, 5] is needed.
	if (g > 5.0 * SIGMA) {
		g = 5.0 * SIGMA;
	}
	
	integer res = double2integer((max - min) * g / 5.0 / SIGMA) + min;
	return res;
}

function string getRandomListItem(string[] items) {
	if (items == null || length(items) == 0) {
		return null;
	}
	
	return items[randomInteger(0, length(items) - 1)];
}
