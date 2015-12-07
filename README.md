## EmbeddedPageViewController

### Introduction

Example of embedding iOS page view controller within a scene with other controls on it.

The key with `UIPageViewController` (if you have a lot of sub view controllers at least) is to minimize the 
memory footprint of the child view controllers (i.e. don't load them all in at once). Instead, just have 
an array of storyboard IDs, for example, and instantiate them just-in-time.

Personally, I like the child view controllers to know what "page" they represent, so I define a protocol in
which we capture the "index" of the page, and I just make sure that all of the child view controllers conform
to that protocol. That simplifies the page view controller data source code.

### Reference

See http://stackoverflow.com/questions/34138682/ios-uipageviewcontroller-swipe-only-some-part-of-the-screen

### License

The MIT License (MIT)

Copyright (c) 2015 Rob Ryan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

