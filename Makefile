init:
	bower install

jshint:
	./node_modules/jshint/bin/jshint lib/*.js

riot:
	@ # Build standalone
	@ cat license.js > riot.js
	@ echo '(function($$) { "use strict";' >> riot.js
	@ cat lib/{observable,render,route}.js >> riot.js
	@ echo '})(typeof top == "object" ? window.$$ || (window.$$ = {}) : exports);' >> riot.js
	@ # Build jquery
	@ cat license.js > jquery.riot.js
	@ echo '(function($$) { "use strict";' >> jquery.riot.js
	@ cat lib/{jquery.observable,render,route}.js >> jquery.riot.js
	@ echo '})(typeof top == "object" ? window.$$ || (window.$$ = {}) : exports);' >> jquery.riot.js
	@ echo 'Done.'

min: riot
	./node_modules/uglify-js/bin/uglifyjs riot.js --comments --mangle -o riot.min.js
	./node_modules/uglify-js/bin/uglifyjs riot.js --comments --mangle -o jquery.riot.min.js

test: min
	node test/node.js

benchmark: riot
	node test/benchmark.js

.PHONY: test compare
