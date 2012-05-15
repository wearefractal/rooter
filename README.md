## Information

<table>
<tr>
<td>Package</td><td>dermis</td>
</tr>
<tr>
<td>Description</td>
<td>Sugar</td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.4</td>
</tr>
</table>

## Introduction

Dermis exists to provide an easy to use wrapper around routing and rendering. If you find yourself requesting data from the server then rendering it throughout your application dermis can help clean up your workflow.

## Includes

Dermis itself is tiny but comes with great tools baked in. These include RequireJS, SockJS, Vein, jQuery, Jade, and more. A more diverse selection of builds will be available soon to help customize your stack - right now everything you need to get an app off the ground is included by default.

## Routing

Passing a single route to dermis will automatically load routes/(base) and routes/(template) when triggered.

```javascript
require(["dermis"], function (dermis) {
  // This will load routes/test.js and templates/test.js
  dermis.route('/test/:id');
});
```

You can also pass functions as your second and third arguments.

```javascript
require(["dermis"], function (dermis) {
  dermis.route('/test/:id', require('tasks/runtest'), require('tmpl/rendertest'));
});
```

## Structure

#### routes/test.js

Your route function will receive two arguments. The first argument is an object that contains the parameters from your route - the second argument is your template/render/view/secondary function.

```javascript
define(function () {
  return function (args, templ) {
    $('#test').html(templ({
      user: "choni"
    }));
  }
});
```

#### templates/test.js

Your template function will receive any arguments that were passed in from your route function. Your template files MUST be valid AMD modules. If you use jade templates have a look at [jaded](https://github.com/wearefractal/jaded) which will compile your templates to AMD modules.

```javascript
define(function () {
  return function (args) {
    return "User" + args.user + " triggered this!";
  }
});
```

## Examples

You can see examples in the [example folder.](https://github.com/wearefractal/dermis/tree/master/examples)

## LICENSE

(MIT License)

Copyright (c) 2012 Fractal <contact@wearefractal.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
