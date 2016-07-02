# CSSDeadClass

Remove undefined CSS class attributes from your HTML.

## Purpose

This Gem will, given a set of HTML files and a set of CSS files, remove any mentions in the class attributes of HTML objects classes that are not defined in the CSS files.

## Sample Usage

Given the following files

`index.html`

~~~html
<html>
<body>
	<h1 class="happy sad">Heading</h1>
	<p class="red blue">Hello</p>
</body>
</html>
~~~

`app.css`
~~~css
.red {
	color: red;
}

.happy {
	color: black;
}
~~~

Running CSSDeadClass on those two files will change `index.html` to the following, remove calls to `.sad` and `.blue`, as they do not exist:

~~~ html
<html>
<body>
	<h1 class="happy">Heading</h1>
	<p class="red">Hello</p>
</body>
</html>
~~~
	
## Installation

Install using `gem css_dead_class`.

## Configuration

CSSDeadClass takes three options:

### `:css_files`

An array of file paths to CSS files to scan.

### `:html_files`

An array of file paths to HTML files to scan.

### `:classes_to_keep`

An array of CSS classes to keep, regardless of presence in the HTML files. Can either be of the form `.classname` or `classname`.

## Usage

Sample usage in a ruby program:

~~~ ruby
require 'css_dead_classes'

css_deadfiles = CSSDeadClass.new({
	html_files: Dir.glob("**/*.html"),
	css_files: Dir.glob("**/*.css"),
	classes_to_keep: [
		".no-js",
		"blue"
	]
})
css_deadfiles.parse
~~~