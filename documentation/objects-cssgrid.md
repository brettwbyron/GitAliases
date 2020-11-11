# objects/cssgrid.scss

## CSS Grid layout

[CSS Grid layout on Mozilla](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout)

[CSS Grid layout on CSS-Tricks](https://css-tricks.com/snippets/css/complete-guide-grid/)

> CSS Grid Layout is the most powerful layout system available in CSS. It is a 2-dimensional system, meaning it can handle both columns and rows, unlike flexbox which is largely a 1-dimensional system. You work with Grid Layout by applying CSS rules both to a parent element (which becomes the Grid Container) and to that element’s children (which become Grid Items). - _CSS-Tricks_

## Example HTML

```
<div class="grid">
    <div class="grid-item grid-item-1">

    </div>
    <div class="grid-item grid-item-2">

    </div>
    <div class="grid-item grid-item-3">

    </div>
    <div class="grid-item grid-item-4">

    </div>
</div>
```

## SCSS

CSS Grid has varied support on browsers. As of Nov. 2020 we still must support IE11. In order to do that we have to write our CSS to fallback to older browsers. I have written a mixin to help make that easier.

```
.grid-item-1 {
    ie-grid-item($row, $row-span, $col, $col-span, $area:null)
}

$row: Set the row number of your item.
$row-span: Set how many rows your item spans. Set to "1" by default.
$col: Set the column number of your item.
$col-span: Set how many columns you item spans. Set to "1" by default.
$area: Specify the grid-area name your item is referring to.  Make sure it corresponds to a grid-area in your grid-template-areas.   
```

[Back to home](README.md)