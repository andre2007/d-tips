---
title: Dub application template
tags:
    - dub
---
# Dub application template

## File structure

```
  dub.json
- source
  - my
      app.d
    - test
        testapp.d
```

## dub.json

``` json
{
	"authors": [
		"Developer"
	],
	"copyright": "Copyright © 2021, Developer",
	"description": "A minimal D application.",
	"license": "proprietary",
	"name": "sample",
	"configurations": [{
		"name": "debug",
		"targetType": "executable",
		"excludedSourceFiles": ["source/my/test/"]
	}, {
		"name": "unittest",
		"targetType": "executable",
		"mainSourceFile": "source/my/test/testapp.d",
		"excludedSourceFiles": ["source/my/app.d"],
		"dependencies": {
			"d-unit": "~>0.10.1"
		}
	}]
}
```

## source/my/app.d

``` d
module my.app;

void main()
{

}
```

## source/my/test/testapp.d

``` d
module my.test.testapp;

import dunit;

mixin Main;

class Test
{
    mixin UnitTest;

    @Test
    public void assertEqualsFailure()
    {
        string expected = "bar";
        string actual = "baz";

        assertEquals(expected, actual);
    }
}
```
