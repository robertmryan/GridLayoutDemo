## GridLayoutDemo

This is a sample project with a collection view with custom grid layout. The idea was to illustrate how to make a fixed grid based upon how many items are added, but if the number of items exceeds 25, it flows on to a second page.

Note, there is some configuration of the collection view in IB, namely:

 - Specified the `GridLayout` class for the collection view layout
 - Specified that the collection view should be paged

The app starts with 15 cells (just short of 4x4 grid), and adds enough to go to 28, resulting in one page with 25 and another page with 3.

This was developed in Xcode 8.3.3 with iOS 10.3.

See https://stackoverflow.com/a/45537004/1271826.

Rob Ryan </br>
6 Aug 2017

## License

Copyright &copy; 2017 Robert Ryan. All rights reserved.

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
