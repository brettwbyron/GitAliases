# utilities/sizing.scss

## Size Classes

This files generates classes to control percentage-based widths and heights you can use in your layouts. In the mixin settings specify your starting (smallest value) width, ending (largest value), and incremental value.

The following setup would generate these classes.
```
@include generate-width($start:0, $end:100, $inc:25);
@include generate-height($start:0, $end:100, $inc:25);

/*! =Size classes */
.w-0 {width:0%}
.w-25 {width:25%}
.w-50 {width:50%}
.w-75 {width:75%}
.w-100 {width:100%}
.h-0 {height:0%}
.h-25 {height:25%}
.h-50 {height:50%}
.h-75 {height:75%}
.h-100 {height:100%}
```

[Back to home](README.md)