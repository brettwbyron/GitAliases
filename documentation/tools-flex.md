# tools/flex.scss

## Flexbox Layout Mixins

The flex objects use abbreviations, see below to understand. Flex mixins are used like the corresponding class file except that these are included in classes in your SCSS.

```
// -----------------------------------------------------------------------------
// =Flex object
// -----------------------------------------------------------------------------
// m = main axis
// w = wrap or space along cross axis
// c = cross axis alignment
// self = align-self
```

## Example SCSS

```
.jv-button { 
    @include flex-inline;
    @include flex-center;
    ...
}

.prev, .next {
    @include flex-col;
    @include flex-m-center;
    @include flex-c-center;
    ...
} 
```

[Back to home](README.md)