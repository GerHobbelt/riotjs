init:
	bower install

jshint:
	./node_modules/jshint/bin/jshint lib/*.js

riot:
	@ # Build standalone
	@ cat license.js > riot.js
	@ echo '(function(riot) { "use strict";' >> riot.js
	@ cat lib/{observable,render,route}.js >> riot.js
	@ echo '})(typeof window !== "undefined" ? window.riot = {} : exports);' >> riot.js
	@ # Build jquery
	@ cat license.js > jquery.riot.js
	@ echo '(function(riot) { "use strict";' >> jquery.riot.js
	@ cat lib/{jquery.observable,render,route}.js >> jquery.riot.js
	@ echo '})(typeof window == "object" ? window.riot || (window.riot = {}) : exports);' >> jquery.riot.js
	@ echo 'Done.'

min: riot
	./node_modules/uglify-js/bin/uglifyjs riot.js        --comments --mangle -o riot.min.js --source-map=riot.min.js.map
	./node_modules/uglify-js/bin/uglifyjs jquery.riot.js --comments --mangle -o jquery.riot.min.js --source-map=jquery.riot.min.js.map

test: riot
	node test/node.js

benchmark: riot
	node test/benchmark.js

.PHONY: test
