# objects/grid.scss

## CSS Flex Grid layout

CSS flex grid layout generates a flex-based grid system. The grid.scss file uses the `$max-columns` and `$column-gutter` variables to control how the classes are generated. The variables are set on the `settings/variables.scss` file.

## Example

Assuming the variabls set below, this would create a grid that displays a single column by default and on medium or larger screens show two columns.

```
Variables:
$max-columns: 8;
$column-gutter: 0.5em;

<div class="row">
    <div class="col-8 col-4-md flex-col flex-c-center">
        <!-- content -->
    </div>
    <div class="col-8 col-4-md flex-col flex-c-center">
        <!-- content -->
    </div>
    <div class="col-8 col-4-md flex-col flex-c-center">
        <!-- content -->
    </div>
    <div class="col-8 col-4-md flex-col flex-c-center">
        <!-- content -->
    </div>
</div>
```

[Back to home](README.md)